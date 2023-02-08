open Rat
open Compilateur 
open Exceptions

exception ErreurNonDetectee

(****************************************)
(** Chemin d'accès aux fichiers de test *)
(****************************************)

let pathFichiersRat = "../../../../tests/cond_else_opt/fichiersRat/"

(**********)
(*  TESTS *)
(**********)


let%test_unit "test1"= 
  let _ = compiler (pathFichiersRat^"/tam/test1.rat") in ()

let%test_unit "test_sujet"= 
  let _ = compiler (pathFichiersRat^"test_sujet.rat") in ()

let%test_unit "test2"= 
  let _ = compiler (pathFichiersRat^"/tam/test2.rat") in ()

let%test_unit "test3"= 
  let _ = compiler (pathFichiersRat^"/tam/test3.rat") in ()

let%test_unit "test4"= 
  let _ = compiler (pathFichiersRat^"/tam/test4.rat") in ()

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
  let p_tam = "../../../../tests/cond_else_opt/fichiersRat/tam/" in
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


let%expect_test "test1" =
  runtam (pathFichiersRat^"/tam/test1.rat");
  [%expect{| 3 |}]

let%expect_test "test2" =
  runtam (pathFichiersRat^"/tam/test2.rat");
  [%expect{| 0 |}]

let%expect_test "test3" =
  runtam (pathFichiersRat^"/tam/test3.rat");
  [%expect{| 0 |}]

let%expect_test "test4" =
  runtam (pathFichiersRat^"/tam/test4.rat");
  [%expect{| 5 |}]

let%expect_test "test_sujet" =
  runtam (pathFichiersRat^"test_sujet.rat");
  [%expect {| 0246810 |}]


  let%test_unit "testConditionnelle_opt1"= 
  let _ = compiler (pathFichiersRat^"/type/testConditionnelle_opt1.rat") in ()

let%test_unit "testConditionnelle_opt2"= 
  try 
    let _ = compiler (pathFichiersRat^"/type/testConditionnelle_opt2.rat")
    in raise ErreurNonDetectee
  with
  | TypeInattendu(Int,Bool) -> ()

let%test_unit "testConditionnelle_opt3"= 
  try 
    let _ = compiler (pathFichiersRat^"/type/testConditionnelle_opt3.rat")
    in raise ErreurNonDetectee
  with
  | TypeInattendu(Rat,Bool) -> ()

let%test_unit "testConditionnelle_opt4"= 
  let _ = compiler (pathFichiersRat^"/type/testConditionnelle_opt4.rat") in ()

let%test_unit "testConditionnelle_opt5"= 
  try 
    let _ = compiler (pathFichiersRat^"/type/testConditionnelle_opt5.rat")
    in raise ErreurNonDetectee
  with
  | TypeInattendu(Int,Bool) -> ()

let%test_unit "testConditionnelle_opt6"= 
  try 
    let _ = compiler (pathFichiersRat^"/type/testConditionnelle_opt6.rat")
    in raise ErreurNonDetectee
  with
  | TypeInattendu(Rat,Bool) -> ()
