open Rat
open Compilateur 
open Exceptions

exception ErreurNonDetectee
(****************************************)
(** Chemin d'accès aux fichiers de test *)
(****************************************)

let pathFichiersRat = "../../../../tests/pointeur/fichiersRat/"

(**********)
(*  TESTS *)
(**********)


let%test_unit "testTam1"= 
  let _ = compiler (pathFichiersRat^"testTam1.rat") in ()

let%test_unit "test_sujet"= 
  let _ = compiler (pathFichiersRat^"test_sujet.rat") in ()

let%test_unit "testGestionId1"= 
  let _ = compiler (pathFichiersRat^"testGestionId1.rat") in ()

let%test_unit "testGestionId2"= 
  let _ = compiler (pathFichiersRat^"testGestionId2.rat") in ()

let%test_unit "testnull1"= 
  let _ = compiler (pathFichiersRat^"testnull1.rat") in ()

let%test_unit "testnull2"= 
  let _ = compiler (pathFichiersRat^"testnull2.rat") in ()  

(* Fichiers de tests de la génération de code -> doivent passer la TDS *)
open Unix
open Filename

let rec test d p_tam = 
  try 
    let file = readdir d in
    if (check_suffix file ".rat") 
    then
    (
     try
       let _ = compiler  (p_tam^file) in (); 
     with e -> print_string (p_tam^file); print_newline(); raise e;
    )
    else ();
    test d p_tam
  with End_of_file -> ()

let%test_unit "all_tam" =
  let p_tam = "../../../../tests/tam/avec_fonction/fichiersRat/" in
  let d = opendir p_tam in
  test d p_tam

(* Changer le chemin d'accès du jar. *)
let runtamcmde = "java -jar ../../../../tests/runtam.jar"
(* let runtamcmde = "java -jar /mnt/n7fs/.../tools/runtam/runtam.jar" *)

(* Execute the TAM code obtained from the rat file and return the ouptut of this code *)
let runtamcode cmde ratfile =
  let tamcode = compiler ratfile in
  let (tamfile, chan) = Filename.open_temp_file "test" ".tam" in
  output_string chan tamcode;
  close_out chan;
  let ic = Unix.open_process_in (cmde ^ " " ^ tamfile) in
  let printed = input_line ic in
  close_in ic;
  Sys.remove tamfile;    (* à commenter si on veut étudier le code TAM. *)
  String.trim printed


let runtam ratfile =
  print_string (runtamcode runtamcmde ratfile)


let%expect_test "testTam1" =
  runtam (pathFichiersRat^"testTam1.rat");
  [%expect{| 3 |}]
  
let%expect_test "testsujet" =
  runtam (pathFichiersRat^"test_sujet.rat");
  [%expect{| 423 |}]

let%expect_test "testnull1" =
  runtam (pathFichiersRat^"testnull1.rat");
  [%expect{| 3 |}]

let%test_unit "testAffectation1"= 
  let _ = compiler (pathFichiersRat^"/type/testAffectation1.rat") in ()

let%test_unit "testAffectation2"= 
  let _ = compiler (pathFichiersRat^"/type/testAffectation2.rat") in ()

let%test_unit "testAffectation3"= 
  let _ = compiler (pathFichiersRat^"/type/testAffectation3.rat") in ()

let%test_unit "testAffectation4"= 
  try 
    let _ = compiler (pathFichiersRat^"/type/testAffectation4.rat")
    in raise ErreurNonDetectee
  with
  | TypeInattendu(Int,Rat) -> ()

let%test_unit "testAffectation5"= 
  try 
    let _ = compiler (pathFichiersRat^"/type/testAffectation5.rat")
    in raise ErreurNonDetectee
  with
  | TypeInattendu(Bool,Int) -> ()

let%test_unit "testAffectation6"= 
  try 
    let _ = compiler (pathFichiersRat^"/type/testAffectation6.rat")
    in raise ErreurNonDetectee
  with
  | TypeInattendu(Bool,Rat) -> ()

let%test_unit "testAffectation7"= 
  try 
    let _ = compiler (pathFichiersRat^"/type/testAffectation7.rat")
    in raise ErreurNonDetectee
  with
  | TypeInattendu(Rat,Int) -> ()

let%test_unit "testAffectation8"= 
  try 
    let _ = compiler (pathFichiersRat^"/type/testAffectation8.rat")
    in raise ErreurNonDetectee
  with
  | TypeInattendu(Rat,Bool) -> ()

let%test_unit "testAffectation9"= 
  try 
    let _ = compiler (pathFichiersRat^"/type/testAffectation9.rat")
    in raise ErreurNonDetectee
  with
  | TypeInattendu(Int,Bool) -> ()

