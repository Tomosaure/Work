open Util
open Mem
open List

(* get_assoc: TODO
 *)
let rec get_assoc e l def = 
    match l with
    | [] -> def
    | (te,tx)::q  -> if te = e then tx
    else get_assoc e q def

(* Tests unitaires : TODO *)
let%test _ = get_assoc 1 [(1,"a");(3,"b")] "z" = "a"
let%test _ = get_assoc 3 [(1,"a");(3,"b")] "z" = "b"
let%test _ = get_assoc 5 [(1,"a");(3,"b")] "z" = "z"

let rec set_assoc e l x = 
    match l with
    | [] -> [(e,x)]
    | (te,tx)::q  -> if te = e then (e,x)::q
    else (te,tx)::(set_assoc e q x)

(* Tests unitaires : TODO *)
let%test _ = set_assoc 1 [(1,"b");(3,"c")] "a" = [(1,"a");(3,"c")]
let%test _ = set_assoc 3 [(1,"b");(3,"c")] "a" = [(1,"b");(3,"a")]
let%test _ = set_assoc 5 [(1,"b");(3,"c")] "a" = [(1,"b");(3,"c");(5,"a")]


module AssocMemory : Memory =
struct
    (* Type = liste qui associe des adresses (entiers) à des valeurs (caractères) *)
    type mem_type = (int * char) list

    (* Un type qui contient la mémoire + la taille de son bus d'adressage *)
    type mem = int * mem_type

    (* Nom de l'implémentation *)
    let name = "assoc"

    (* Taille du bus d'adressage *)
    let bussize (bs, _) = bs

    (* Taille maximale de la mémoire *)
    let size (bs, _) = pow2 bs

    (* Taille de la mémoire en mémoire *)
    let allocsize (_, m) = 2*(List.length m)

    (* Nombre de cases utilisées *)
     let rec busyness (bs, m) = 
        match m with 
        | [] -> 0
        | (_,x)::q -> if x = _0 then 1 + busyness (bs,q) else busyness (bs,q)

    (* Construire une mémoire vide *)
    let clear bs = (bs, [])

    (* Lire une valeur *)
    let read (_, m) addr = get_assoc addr m _0

    (* Écrire une valeur *)
    let write (bs, m) addr x = (bs, set_assoc addr m x)

    (* Afficher une mémoire *)
end
