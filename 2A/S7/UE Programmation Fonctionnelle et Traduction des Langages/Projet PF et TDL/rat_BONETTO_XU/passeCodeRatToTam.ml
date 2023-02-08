(* Module de la passe de génération de code *)
(* doit être conforme à l'interface Passe *)
open Tds
open Exceptions
open Ast
open Type
open AstPlacement
open AstType
open Tam
open Code

type t1 = Ast.AstPlacement.programme
type t2 = string

(* analyse_code_affectable : AstTds.affectable -> bool -> string*typ *)
(* Paramètre a : l'affectable à analyser *)
(* Paramètre modif : true s'il s'agit d'un affectation, false sinon *)
(* Vérifie la bonne génération de code et tranforme l'affectable
en un affectable de type string*typ *)
(* Erreur si mauvaise génération de code *)
let rec analyse_code_affectable a modif =
  match a with
  |Ident info ->
    begin
    match (info_ast_to_info info) with
      |InfoVar(_, t, depl, reg) -> if modif then store (getTaille t) depl reg,t 
                                else load (getTaille t) depl reg,t
      |InfoConst (_,i) -> loadl_int i, Int
      |_ -> failwith "InternalError"
    end
  |Deref a -> let str, t = analyse_code_affectable a false in
    match t with
      |Pointeur _ -> if modif then str^storei (getTaille t),t
                          else str^loadi (getTaille t), t
      |_ -> failwith "InternalError"


(* analyse_code_expr : AstTds.expression -> string *)
(* Paramètre e : l'expression à analyser *)
(* Vérifie la bonne génération de code et tranforme l'expression sous forme de string *)
(* Erreur si mauvaise génération de code *)
let rec analyse_code_expr e =
  match e with
    |AppelFonction(info,lc) ->
      begin
        match (info_ast_to_info info) with
        |InfoFun(name,_,_) -> String.concat "" (List.map analyse_code_expr lc)^ call "ST" name
        |_ -> failwith "InternalError"
    end
    |Booleen b -> if b then loadl_int 1
                else loadl_int 0
    |Entier i -> loadl_int i
    |Unaire(op,e1) ->
      begin
      analyse_code_expr e1 ^
      match op with
        |Numerateur -> pop 0 1
        |Denominateur -> pop 1 1
      end
    |Binaire(op, e1, e2) ->
      let c1 = analyse_code_expr e1 in
      let c2 = analyse_code_expr e2 in
      begin
        match op with
          | Fraction -> c1^c2^(call "ST" "norm")
          | PlusInt -> c1^c2^(subr "IAdd")
          | PlusRat -> c1^c2^(call "ST" "RAdd")
          | MultInt -> c1^c2^(subr "IMul")
          | MultRat -> c1^c2^(call "ST" "RMUl")
          | EquInt  -> c1^c2^(subr "IEq")
          | EquBool -> c1^c2^(subr "IEq")
          | Inf -> c1^c2^(subr "ILss")
      end
    |Ternaire(e1,e2,e3) ->
      let sinon = getEtiquette() in
      let finSi = getEtiquette() in
      analyse_code_expr e1
      ^ jumpif 0 sinon
      ^ analyse_code_expr e2
      ^ jump finSi
      ^ label sinon
      ^ analyse_code_expr e3
      ^ label finSi
    |Affectable a -> let str, _ = analyse_code_affectable a false in str
    |Null -> loadl_int 1^subr "Malloc"
    |New t -> loadl_int (getTaille t)^subr "Malloc"
    |Adresse info ->
      match info_ast_to_info info with
        |InfoVar(_,_,depl,reg) -> loada depl reg
        |_ -> failwith "InternalError"


(* analyse_code_instr : AstTds.instruction -> string *)
(* Paramètre i : l'instruction à analyser *)
(* Vérifie la bonne génération de code et tranforme l'instruction sous forme de string *)
(* Erreur si mauvaise génération de code *)      
let rec analyse_code_instr i =
  match i with
  | AstPlacement.Declaration (info,e) ->
    begin
      match info_ast_to_info info with
        | InfoVar(_,t,depl,reg) ->
          push (getTaille t)
          ^ analyse_code_expr e
          ^ store (getTaille t) depl reg
        | _ -> raise MauvaiseUtilisationType
    end
  | Affectation(a,e) ->
      let na, _ = analyse_code_affectable a true in 
      let ne = analyse_code_expr e in
      ne^na
  | AffichageInt e ->
    analyse_code_expr e ^ subr "IOut"
  | AffichageBool e ->
    analyse_code_expr e ^ subr "BOut"
  | AffichageRat e ->
    analyse_code_expr e ^ call "ST" "ROut"
  | AffichagePointeur e ->
    analyse_code_expr e ^ subr "IOut"
  | Conditionnelle(e,b1,b2) ->
    let sinon = getEtiquette() in
    let finSi = getEtiquette() in
    analyse_code_expr e
    ^ jumpif 0 sinon
    ^ analyse_code_bloc b1
    ^ jump finSi
    ^ label sinon
    ^ analyse_code_bloc b2
    ^ label finSi
    | Conditionnelle_opt(e,b) ->
      let finSi = getEtiquette() in
      analyse_code_expr e
      ^ jumpif 0 finSi
      ^ analyse_code_bloc b
      ^ label finSi
  | TantQue (e,b) ->
    let tantQue = getEtiquette() in
    let finTantQue = getEtiquette() in
    label tantQue
    ^ analyse_code_expr e
    ^ jumpif 0 finTantQue
    ^ analyse_code_bloc b
    ^ jump tantQue
    ^ label finTantQue
  | Retour(e,tr,tp) ->
              (analyse_code_expr e) ^ return tr tp

  | Empty -> ""
  | BoucleID (ia,b) | Boucle (ia,b) ->
    let boucle = getEtiquette () in
    let finBoucle = getEtiquette () in
    (* On stock les étiquettes dans l'info de la boucle *)
    (* pour que les break et les continue associés puissent y avoir accés *)
    modifier_eti boucle finBoucle ia;
    label boucle 
    ^ analyse_code_bloc b
    ^ jump boucle
    ^ label finBoucle 
  | BreakID (ia) | Break (ia) -> 
    begin
      match info_ast_to_info ia with
      (* On récupère l'étiquette de fin de boucle*)
      | InfoBoucle (_,_,finBoucle,_) ->
        jump finBoucle
      | _ -> failwith "InternalError"
    end 
  | ContinueID (ia) | Continue (ia) -> 
    begin
      match info_ast_to_info ia with
      (* On récupère l'étiquette de début de boucle*)
      | InfoBoucle (_,boucle,_,_) ->
        jump boucle
      | _ -> failwith "InternalError"
    end 

(* analyse_code_bloc : AstTds.bloc -> string *)
(* Paramètre bloc : le bloc à analyser *)
(* Vérifie la bonne génération de code et tranforme le bloc sous forme de string*)
(* Erreur si mauvaise génération de code *)
and analyse_code_bloc (li,taille) =
  String.concat "" (List.map analyse_code_instr li) ^ (pop 0 taille)

let analyse_code_fonction (AstPlacement.Fonction(ia,_,nli)) =
  match info_ast_to_info ia with
  | InfoFun(name,_,_) ->
    name ^ "\n" ^ analyse_code_bloc nli ^ halt
  | _ -> raise MauvaiseUtilisationType


(* analyser : AstPlacement.programme -> string *)
(* Paramètre : le programme à analyser *)
(* Tranforme le programme en une suite d'instruction sous forme d'une string *)
(* Erreur si mauvaise génération de code *)
let analyser (AstPlacement.Programme(fonctions, bloc)) =
  getEntete()
  ^ String.concat "" (List.map analyse_code_fonction fonctions)
  ^ label "main"
  ^ analyse_code_bloc bloc
  ^ halt
