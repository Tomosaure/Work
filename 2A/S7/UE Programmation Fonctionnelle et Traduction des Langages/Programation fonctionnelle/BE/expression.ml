(* Exercice 3 *)
module type Expression = sig
  (* Type pour représenter les expressions *)
  type exp


  (* eval : exp -> int *)
  (* Evalue la valeur d'une expression *)
  (* Paramètre exp : l'expression que l'on va evaluer *)
  (* Résultat : la valeur de l'expression *)
  val eval : exp -> int
end

(* Exercice 4 *)
module ExpAvecArbreBinaire : Expression = 
struct
    (* Type pour représenter les expressions binaires *)
    type op = Moins | Plus | Mult | Div
    type exp = Binaire of exp * op * exp | Entier of int
  
    (* eval *)
    let eval =  fun exp -> 
      let rec aux exp acc = 
        match exp with
        | Entier n -> n
        | Binaire (exp1, op, exp2) -> 
          let a = aux exp1 acc in
          let b = aux exp2 acc in
            match op with
            | Plus -> a + b
            | Moins -> a - b
            | Mult -> a * b
            | Div -> if b = 0 then raise Division_by_zero else a / b
      in aux exp 0

    let%test _ = eval (Entier 1) = 1
    let%test _ = eval (Binaire (Entier 3, Moins, Entier 2)) = 1
    let%test _ = eval (Binaire (Entier 3, Plus, Entier 2)) = 5
    let%test _ = eval (Binaire (Entier 3, Mult, Entier 2)) = 6
    let%test _ = eval (Binaire (Entier 3, Div, Entier 2)) = 1
    let%test _ = eval (Binaire (Entier 3, Mult, Entier 0)) = 0
    let%test _ = eval (Binaire (Binaire (Entier 3, Plus, Entier 4), Moins, Entier 12)) = -5
    let%test _ = eval (Binaire (Entier 12, Moins, (Binaire (Entier 3, Plus, Entier 4)))) = 5
    let%test _ = try let _  = eval (Binaire (Entier 3, Div, Entier 0)) in false with Division_by_zero -> true
    
end
(* Exercice 5 *)

module ExpAvecArbreNaire : Expression = 
struct
  
  (* Linéarisation des opérateurs binaire associatif gauche et droit *)
  type op = Moins | Plus | Mult | Div
  type exp = Naire of op * exp list | Valeur of int

  
(* bienformee : exp -> bool *)
(* Vérifie qu'un arbre n-aire représente bien une expression n-aire *)
(* c'est-à-dire que les opérateurs d'addition et multiplication ont au moins deux opérandes *)
(* et que les opérateurs de division et soustraction ont exactement deux opérandes.*)
(* Paramètre : l'arbre n-aire dont ont veut vérifier si il correspond à une expression *)
let bienformee = fun exp ->
  let rec aux exp acc = 
    match exp with
    | Valeur _ -> true
    | Naire (op, l) -> match op with
                       | Plus | Mult -> if List.length l < 2 then false
                                        else List.for_all (fun e -> aux e acc) l
                       | Moins | Div -> if List.length l <> 2 then false
                                        else List.for_all (fun e -> aux e acc) l
  in aux exp true

let en1 = Naire (Plus, [ Valeur 3; Valeur 4; Valeur 12 ])
let en2 = Naire (Moins, [ en1; Valeur 5 ])
let en3 = Naire (Mult, [ en1; en2; en1 ])
let en4 = Naire (Div, [ en3; Valeur 2 ])
let en1err = Naire (Plus, [ Valeur 3 ])
let en2err = Naire (Moins, [ en1; Valeur 5; Valeur 4 ])
let en3err = Naire (Mult, [ en1 ])
let en4err = Naire (Div, [ en3; Valeur 2; Valeur 3 ])

let%test _ = bienformee en1
let%test _ = bienformee en2
let%test _ = bienformee en3
let%test _ = bienformee en4
let%test _ = not (bienformee en1err)
let%test _ = not (bienformee en2err)
let%test _ = not (bienformee en3err)
let%test _ = not (bienformee en4err)

(* eval : exp-> int *)
(* Calcule la valeur d'une expression n-aire *)
(* Paramètre : l'expression dont on veut calculer la valeur *)
(* Précondition : l'expression est bien formée *)
(* Résultat : la valeur de l'expression *)
let  eval_bienformee =  fun exp -> 
  let rec aux exp acc = 
    match exp with
    | Valeur n -> n
    | Naire (op, l) -> match op with
                       | Plus -> List.fold_left (fun acc e -> acc + aux e acc) 0 l
                       | Mult -> List.fold_left (fun acc e -> acc * aux e acc) 1 l
                       | Moins -> let a = aux (List.hd l) acc in
                                  let b = aux (List.hd (List.tl l)) acc 
                                  in a - b
                       | Div -> let a = aux (List.hd l) acc in
                                let b = aux (List.hd (List.tl l)) acc 
                                in if b = 0 then raise Division_by_zero else a / b                                  
  in aux exp 0

let%test _ = eval_bienformee en1 = 19
let%test _ = eval_bienformee en2 = 14
let%test _ = eval_bienformee en3 = 5054
let%test _ = eval_bienformee en4 = 2527
let%test _ = try let _  = eval_bienformee (Naire (Div, [Valeur 3; Valeur 0])) in false with Division_by_zero -> true
   
(* Définition de l'exception Malformee *)
exception Malformee

(* eval : exp-> int *)
(* Calcule la valeur d'une expression n-aire *)
(* Paramètre : l'expression dont on veut calculer la valeur *)
(* Résultat : la valeur de l'expression *)
(* Exception  Malformee si le paramètre est mal formé *)

let eval  = fun exp -> if bienformee exp then eval_bienformee exp else raise Malformee

let%test _ = eval en1 = 19
let%test _ = eval en2 = 14
let%test _ = eval en3 = 5054
let%test _ = eval en4 = 2527
let%test _ = try let _  = eval (Naire (Div, [Valeur 3; Valeur 0])) in false with Division_by_zero -> true
  
let%test _ =
  try
    let _ = eval en1err in
    false
  with Malformee -> true

let%test _ =
  try
    let _ = eval en2err in
    false
  with Malformee -> true

let%test _ =
  try
    let _ = eval en3err in
    false
  with Malformee -> true

let%test _ =
  try
    let _ = eval en4err in
    false
  with Malformee -> true

end