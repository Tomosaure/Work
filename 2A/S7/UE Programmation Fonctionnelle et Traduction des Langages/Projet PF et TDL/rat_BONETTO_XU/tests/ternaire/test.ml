open Rat
open Compilateur 
open Exceptions

exception ErreurNonDetectee


(****************************************)
(** Chemin d'accès aux fichiers de test *)
(****************************************)

let pathFichiersRat = "../../../../tests/ternaire/fichiersRat/"

(**********)
(*  TESTS *)
(**********)



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


  let%test_unit "testType1"= 
  let _ = compiler (pathFichiersRat^"/type/test1.rat") in ()

let%test_unit "testType2"= 
  try 
    let _ = compiler (pathFichiersRat^"/type/test2.rat")
    in raise ErreurNonDetectee
  with
  | TypeInattendu(Int,Bool) -> ()

let%test_unit "testType3"= 
  try 
    let _ = compiler (pathFichiersRat^"/type/test3.rat")
    in raise ErreurNonDetectee
  with
  | TypeInattendu(Rat,Bool) -> ()

let%test_unit "testType4"= 
  let _ = compiler (pathFichiersRat^"/type/test4.rat") in ()
  
let%test_unit "testType5"= 
  try 
    let _ = compiler (pathFichiersRat^"/type/test5.rat")
    in raise ErreurNonDetectee
  with
  | TypeInattendu(Int,Bool) -> ()

  let%test_unit "testType6"= 
  try 
    let _ = compiler (pathFichiersRat^"/type/test6.rat")
    in raise ErreurNonDetectee
  with
  | TypeInattendu(Rat,Bool) -> ()

let%test_unit "testType7"= 
  let _ = compiler (pathFichiersRat^"/type/test7.rat") in ()

let%test_unit "testType8"= 
try 
  let _ = compiler (pathFichiersRat^"/type/test8.rat")
  in raise ErreurNonDetectee
with
| TypeInattendu(Int,Bool) -> ()

let%test_unit "testType9"= 
try 
  let _ = compiler (pathFichiersRat^"/type/test9.rat")
  in raise ErreurNonDetectee
with
| TypeInattendu(Rat,Bool) -> ()

let%test_unit "testType10"= 
try 
  let _ = compiler (pathFichiersRat^"/type/test10.rat")
  in raise ErreurNonDetectee
with
| TypeInattendu(Int,Rat) -> ()

let%test_unit "testType11"= 
try 
  let _ = compiler (pathFichiersRat^"/type/test11.rat")
  in raise ErreurNonDetectee
with
| TypeInattendu(Bool,Rat) -> ()


let%expect_test "testTam1" =
  runtam (pathFichiersRat^"/tam/test1.rat");
  [%expect{| 18 |}]

let%expect_test "testTam2" =
  runtam (pathFichiersRat^"/tam/test2.rat");
  [%expect{| 21 |}]