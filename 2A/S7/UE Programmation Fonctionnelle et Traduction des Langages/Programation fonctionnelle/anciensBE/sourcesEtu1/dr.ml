(*  Module qui permet la décomposition et la recomposition de données **)
(*  Passage du type t1 vers une liste d'éléments de type t2 (décompose) **)
(*  et inversement (recopose).**)
open Chaines

module type DecomposeRecompose =
sig
  (*  Type de la donnée **)
  type mot
  (*  Type des symboles de l'alphabet de t1 **)
  type symbole

  val decompose : mot -> symbole list
  val recompose : symbole list -> mot
end

module DRString: DecomposeRecompose with type mot = string and type symbole = char =
struct
  type mot = string
  type symbole = char
  let decompose = decompose_chaine
  let recompose = recompose_chaine
end

let decompose_int x = List.map (fun l -> l-48) (List.map (int_of_char) (decompose_chaine (string_of_int x)))

(* TESTS *)
let%test _ = decompose_int 123 = [1;2;3]
let%test _ = decompose_int 0 = [0]
let%test _ = decompose_int 10101 = [1;0;1;0;1]

let recompose_int l = int_of_string (recompose_chaine (List.map (char_of_int) (List.map (fun l -> l + 48) l)))

let%test _ = recompose_int [1;2;3] = 123
let%test _ = recompose_int [0] = 0
let%test _ = recompose_int [1;0;1;0;1] = 10101

module DRNat: DecomposeRecompose with type mot = int and type symbole = int =
struct
  type mot = int
  type symbole = int
  let decompose mot = decompose_int mot
  let recompose symbole = recompose_int symbole 

end

