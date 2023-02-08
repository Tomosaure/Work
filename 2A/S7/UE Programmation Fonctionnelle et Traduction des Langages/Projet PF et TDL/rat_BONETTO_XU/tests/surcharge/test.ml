open Rat
open Compilateur 

(****************************************)
(** Chemin d'accès aux fichiers de test *)
(****************************************)

let pathFichiersRat = "../../../../tests/surcharge/fichiersRat/"

(**********)
(*  TESTS *)
(**********)


let%test_unit "testSurcharge1"= 
  let _ = compiler (pathFichiersRat^"test1.rat") in ()

let%test_unit "test2"= 
  let _ = compiler (pathFichiersRat^"test2.rat") in ()
(*
let%test_unit "test3"= 
  let _ = compiler (pathFichiersRat^"test3.rat") in ()
*)

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