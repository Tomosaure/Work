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

module DRString:DecomposeRecompose with type mot = string and type symbole = char =
struct 
  type mot = string
  type symbole = char
  let decompose mot = decompose_chaine mot
  let recompose symbole = recompose_chaine symbole
end

module DRNat : DecomposeRecompose with type mot = int and type symbole = int =
struct
  type mot = int
  type symbole = int
  let decompose mot = List.map (fun x -> x-48) (List.map int_of_char (decompose_chaine (string_of_int mot)))
  let recompose symbole =  int_of_string (recompose_chaine (List.map char_of_int (List.map (fun x -> x+48) symbole)))

  let%test _ = decompose 112 = [1;1;2]
  let%test _ = recompose [1;1;2] = 112
  
end
