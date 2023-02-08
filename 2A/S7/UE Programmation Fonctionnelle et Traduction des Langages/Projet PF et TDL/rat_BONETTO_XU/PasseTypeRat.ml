(* Module de la passe de gestion des types *)
(* doit être conforme à l'interface Passe *)
open Tds
open Exceptions
open Ast
open Type

type t1 = Ast.AstTds.programme
type t2 = Ast.AstType.programme

(* analyse_type_affectable : AstSyntax.affectable -> AstTds.affectable*typ *)
(* Paramètre a : l'affectable à analyser *)
(* Vérifie la bonne utilisation des types et tranforme l'affectable
en un affectable de type AstType.affectable *)
(* Erreur si mauvaise utilisation des types *)
let rec analyse_type_affectable a =
  match a with
    |AstTds.Deref aff -> 
      begin 
        match analyse_type_affectable aff with 
        | (naff, Pointeur t) -> AstType.Deref naff, t
        | _ -> raise NotAPointer
      end
    |AstTds.Ident info ->
      match info_ast_to_info info with
          |InfoVar(_,t,_,_) -> AstType.Ident info, t
          |InfoConst _ -> AstType.Ident info ,Int 
          |_ -> failwith "InternalError"

(* analyse_tds_expression : AstTds.expression -> AstType.expression*typ *)
(* Paramètre e : l'expression à analyser *)
(* Vérifie la bonne utilisation des types et tranforme l'expression
en une expression de type AstType.expression *)
(* Erreur si mauvaise utilisation des types *)
let rec analyse_type_expr e = 
  match e with
  | AstTds.Entier(v) -> (AstType.Entier(v), Int)
  | AstTds.Booleen(b) -> (AstType.Booleen(b), Bool)
  | AstTds.Affectable a ->  let na,t = analyse_type_affectable a in AstType.Affectable(na),t
  | AstTds.Unaire(op_unaire, e) -> 
    let (ne, te) = analyse_type_expr e in
    if (not (est_compatible te Rat)) then 
      raise (TypeInattendu(te, Rat))
    else 
      begin
        match op_unaire with
        | Denominateur -> (AstType.Unaire(AstType.Denominateur, ne), Int)
        | Numerateur -> (AstType.Unaire(AstType.Numerateur, ne), Int)
      end 
  |AstTds.Binaire(op_binaire, e1, e2) -> 
    let (ne1, te1) = analyse_type_expr e1 in
    let (ne2, te2) = analyse_type_expr e2 in
    begin
      match op_binaire, te1, te2 with
      | Fraction, Int, Int -> (AstType.Binaire(Fraction, ne1, ne2), Rat)
      | Plus, Int, Int -> (AstType.Binaire(PlusInt, ne1, ne2), Int)
      | Plus, Rat, Rat -> (AstType.Binaire(PlusRat, ne1, ne2), Rat)
      | Mult, Int, Int -> (AstType.Binaire(MultInt, ne1, ne2), Int)
      | Mult, Rat, Rat -> (AstType.Binaire(MultRat, ne1, ne2), Rat)
      | Equ, Int, Int -> (AstType.Binaire(EquInt, ne1, ne2), Bool)
      | Equ, Bool, Bool -> (AstType.Binaire(EquBool, ne1, ne2), Bool)
      | Inf, Int, Int -> (AstType.Binaire(Inf, ne1, ne2), Bool)
      | _ -> raise (TypeBinaireInattendu(op_binaire, te1, te2))   
    end 
  | AstTds.AppelFonction(infol, el) -> 
    begin
      let l = List.map analyse_type_expr el in
      let lt = List.map snd l in
      let rec chercherFonction infol = 
        match infol with 
        | [] -> raise (TypesParametresInattendus (lt,[]))
        | info::q -> 
          begin
            match info_ast_to_info info with 
            | InfoFun(_,tr,tp) -> 
              if (est_compatible_list tp lt) then AstType.AppelFonction(info, List.map fst l), tr
              else chercherFonction q
            | _ -> raise MauvaiseUtilisationType
          end
      in chercherFonction infol
    end
  | AstTds.Ternaire (e1, e2, e3) -> 
    let (ne1, te1) = analyse_type_expr e1 in
    let (ne2, te2) = analyse_type_expr e2 in
    let (ne3, te3) = analyse_type_expr e3 in
    if (est_compatible te1 Bool) then 
      if (est_compatible te2 te3) then (AstType.Ternaire(ne1, ne2, ne3), te2)
      else raise (TypeInattendu(te3, te2))
    else raise (TypeInattendu(te1, Bool))
  |AstTds.Null -> (AstType.Null, Pointeur Undefined)
  |AstTds.New t -> (AstType.New t, Pointeur t)
  |AstTds.Adresse adr ->
    begin
      match info_ast_to_info adr with
      |InfoVar(_,t,_,_) -> AstType.Adresse adr, Pointeur t
      |_ -> failwith "InternalError"
    end

(* analyse_type_instruction : AstTds.instruction -> AstType.instruction *)
(* Paramètre i : l'instruction à analyser *)
(* Vérifie la bonne utilisation des types et tranforme l'instruction
en une instruction de type AstType.instruction *)
(* Erreur si mauvaise utilisation des types *)
let rec analyse_type_instruction i =
  match i with 
  | AstTds.Declaration(t,ia,e) ->
    let (ne, te) = analyse_type_expr e in
      if not (est_compatible t te) then raise (TypeInattendu (te, t))
      else modifier_type_variable t ia; AstType.Declaration(ia,ne)
    
  | AstTds.Affectation(a,e) ->
    let (na,ta) = analyse_type_affectable a in 
    let (ne,te) = analyse_type_expr e in 
      if est_compatible te ta then AstType.Affectation(na,ne)
      else raise (TypeInattendu(te,ta))
  | AstTds.Affichage(e) -> 
    let (ne,te) = analyse_type_expr e in
      begin
        match te with 
          | Int -> AstType.AffichageInt (ne)
          | Rat -> AstType.AffichageRat (ne)
          | Bool -> AstType.AffichageBool (ne)
          | Pointeur _ -> AstType.AffichagePointeur (ne)
          | _ -> raise (TypeInattendu (te,te))
      end

  | AstTds.Conditionnelle(e,b1,b2) ->
    let (ne,te) = analyse_type_expr e in
    if (est_compatible te Bool)
    then AstType.Conditionnelle(ne, analyse_type_bloc b1, analyse_type_bloc b2)
    else raise (TypeInattendu(te,Bool))
  | AstTds.Conditionnelle_opt(e,b) ->
      let (ne,te) = analyse_type_expr e in
      if (est_compatible te Bool)
      then AstType.Conditionnelle_opt(ne, analyse_type_bloc b)
      else raise (TypeInattendu(te,Bool))
  | AstTds.TantQue(e,b) ->
    let (ne,te) = analyse_type_expr e in
      if (est_compatible te Bool)
      then AstType.TantQue(ne, analyse_type_bloc b)
      else raise (TypeInattendu(te,Bool))

  | AstTds.Retour(e,i) -> let (ne, te) = analyse_type_expr e in
  begin
    match info_ast_to_info i with
      |InfoFun(_,t,_) -> if (est_compatible t te) then AstType.Retour(ne,i)
      else raise (TypeInattendu(te,t))
      | _ -> raise MauvaiseUtilisationType
  end
  | AstTds.BoucleID (ia, b) -> AstType.BoucleID (ia, analyse_type_bloc b)
  | AstTds.Boucle (ia,b) -> AstType.Boucle (ia,analyse_type_bloc b)
  | AstTds.Empty -> AstType.Empty
  | AstTds.Break (ia) -> AstType.Break (ia)
  | AstTds.Continue (ia) -> AstType.Continue (ia)
  | AstTds.BreakID (ia) -> AstType.BreakID (ia)
  | AstTds.ContinueID (ia) -> AstType.ContinueID (ia)
 
(* analyse_type_bloc : AstTds.bloc -> AstType.bloc *)
(* Paramètre li : liste d'instructions à analyser *)
(* Vérifie la bonne utilisation des types et tranforme le bloc en un bloc de type AstType.bloc *)
(* Erreur si mauvaise utilisation des types *)
and analyse_type_bloc li = List.map analyse_type_instruction li


(* analyse_type_fonction : AstTds.fonction -> AstType.fonction *)
(* Paramètre : la fonction à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme la fonction
en une fonction de type AstTds.fonction *)
(* Erreur si mauvaise utilisation des identifiants *)
let analyse_type_fonction (AstTds.Fonction(t,ia,lp,li)) = 
  let tp,lia = List.split lp in 
  modifier_type_fonction t tp ia ;
  let _ = List.map2 modifier_type_variable tp lia in 
  AstType.Fonction(ia,lia,analyse_type_bloc li) 
  
  
(* Vérifie la bonne utilisation des types et tranforme le programme
(* Paramètre : le programme à analyser *)
en un programme de type AstType.programme *)
(* Erreur si mauvaise utilisation des types *)
let analyser (AstTds.Programme (fonctions,prog)) =
  let nf = List.map analyse_type_fonction fonctions in
  let nb = analyse_type_bloc prog in
  AstType.Programme (nf,nb)
