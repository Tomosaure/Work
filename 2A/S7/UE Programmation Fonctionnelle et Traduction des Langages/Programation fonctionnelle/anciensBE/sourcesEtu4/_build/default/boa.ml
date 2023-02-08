(* Interface d'une règle *)
module type Regle =
sig
(* type de l'identifiant de la règle *)
  type tid = int
  (* type des termes *)
  type td

  val id : tid
  
  val appliquer : td -> td list
end

module Regle1 : Regle with type td = char list =
struct 
 type tid = int
 type td = char list
 let id = 1
 let appliquer td = [List.append td ['A']]

 let%test _ = appliquer ['B';'O'] = [['B';'O';'A']]
end

module Regle2 : Regle with type td = char list =
struct 
 type tid = int
 type td = char list
 let id = 2
 let appliquer td = [List.append td (List.tl td)]
 
 let%test _ = appliquer ['B'; 'O'; 'A'] = [['B'; 'O'; 'A'; 'O'; 'A']]
end

module Regle3 : Regle with type td = char list =
struct 
 type tid = int
 type td = char list
 let id = 3
 let rec appliquer td = 
  match td with
  |t1::t2::t3::q -> if ((t1='0') && (t2='0') && (t3='0') || (t1='A') && (t2='0') && (t3='A')) 
    then ['A'::q] @ (List.map (fun l -> t1::l) (appliquer (t2::t3::q)))
    else List.map (fun l -> t1::l) (appliquer (t2::t3::q))
  | _ -> []

  let%test _ = List.mem ['B'; 'A'; 'O'] (appliquer ['B'; 'O'; 'O'; 'O'; 'O'])
  let%test _ = List.mem ['B'; 'O'; 'A'] (appliquer ['B'; 'O'; 'O'; 'O'; 'O'])
  let%test _ = List.length (appliquer ['B'; 'O'; 'O'; 'O'; 'O']) = 2
end

module Regle4 : Regle with type td = char list =
struct 
 type tid = int
 type td = char list
 let id = 4
 let rec appliquer td = 
  match td with
  | t1::t2::q -> if t1 = 'A' && t2 ='A' then [q]
  else List.map (fun l -> t1::l) (appliquer (t2::q))
  | _ -> []
 
 let%test _ = appliquer ['B'; 'A'; 'A'] = [['B']]
end

module type ArbreReecriture =
sig

  type tid = int
  type td
  type arbre_reecriture = Noeud of td * ((tid * arbre_reecriture) list)

  val creer_noeud : td -> (tid * arbre_reecriture) list -> arbre_reecriture

  val racine : arbre_reecriture -> td
  val fils : arbre_reecriture -> (tid * arbre_reecriture) list

  val appartient : td -> arbre_reecriture -> bool

end

module ArbreReecritureBOA : ArbreReecriture = 
struct 
type tid = int
type td = char list
type arbre_reecriture = Noeud of td * ((tid * arbre_reecriture) list)
let creer_noeud racine fils = Noeud(racine, fils)
let racine (Noeud(racine,_)) = racine
let fils (Noeud(_, fils)) = fils
let appartient td arbre =
  let rec aux td arbre = 
    match arbre with
    | Noeud(racine, t::_) -> if racine = td then true else let (_,arb) = t in aux td arb
    | Noeud(racine, []) -> if racine = td then true else false
  in aux td arbre

  let exemple1 = creer_noeud ['B'; 'O'; 'A'] [(1, creer_noeud ['B'; 'O'; 'A'; 'A'] []); (2, creer_noeud ['B'; 'O'; 'A'; 'O'; 'A'] [])]
  let%test _ = appartient ['B'; 'O'; 'A'] exemple1 = true
  let%test _ = appartient ['B'; 'O'; 'A'; 'A'] exemple1 = true
  let%test _ = appartient ['B'; 'O'; 'A'; 'O'; 'A'] exemple1 = true
  let%test _ = appartient ['B'; 'O'; 'A'; 'O'; 'A'; 'A'] exemple1 = true
end
