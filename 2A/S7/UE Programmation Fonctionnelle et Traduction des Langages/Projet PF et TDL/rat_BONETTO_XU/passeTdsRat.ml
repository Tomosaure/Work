(* Module de la passe de gestion des identifiants *)
(* doit être conforme à l'interface Passe *)
open Tds
open Exceptions
open Ast

type t1 = Ast.AstSyntax.programme
type t2 = Ast.AstTds.programme

(* analyse_tds_affectable : tds -> AstSyntax.affectable -> bool -> AstTds.expression *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre a : l'affectable à analyser *)
(* Paramètre modif : true s'il s'agit d'un affectation, false sinon *)
(* Vérifie la bonne utilisation des identifiants et tranforme l'affectable'
en un affectable de type AstTds.affectable *)
(* Erreur si mauvaise utilisation des identifiants *)
let rec analyse_tds_affectable tds a modif =
  match a with
    |AstSyntax.Deref v -> AstTds.Deref (analyse_tds_affectable tds v false)
    |AstSyntax.Ident n ->
      match chercherGlobalement (filtrerTds tds) n with
      | None ->
        (* L'identifiant n'est pas trouvé dans la tds globale. *)
        raise (IdentifiantNonDeclare n)
      |Some info ->
        (* L'identifiant est trouvé dans la tds globale,
        il a donc déjà été déclaré. L'information associée est récupérée. *)
        match info_ast_to_info info with
        |InfoVar _ -> AstTds.Ident info
        |InfoConst _ -> if modif then raise (MauvaiseUtilisationIdentifiant n)
                      else AstTds.Ident info
        |_ -> raise (MauvaiseUtilisationIdentifiant n)



(* analyse_tds_expression : tds -> AstSyntax.expression -> AstTds.expression *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre e : l'expression à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme l'expression
en une expression de type AstTds.expression *)
(* Erreur si mauvaise utilisation des identifiants *)
let rec analyse_tds_expression tds e =
  match e with
    | AstSyntax.AppelFonction (nom, list_expression) ->
      begin
        match (chercherGlobalementFonctions tds nom) with
        | [] -> if (chercherGlobalement tds nom) = None then raise (IdentifiantNonDeclare nom)
        else raise (MauvaiseUtilisationIdentifiant nom)
        | l -> AstTds.AppelFonction(l, List.map (analyse_tds_expression tds) list_expression)
      end
    | AstSyntax.Affectable a -> AstTds.Affectable (analyse_tds_affectable tds a false)
    | AstSyntax.Booleen (booleen) -> AstTds.Booleen(booleen)
    | AstSyntax.Entier (valeur) -> AstTds.Entier(valeur)
    | AstSyntax.Unaire (op_unaire, expression) -> AstTds.Unaire(op_unaire, analyse_tds_expression tds expression)
    | AstSyntax.Binaire (op_binaire, expression1, expression2) -> AstTds.Binaire(op_binaire, analyse_tds_expression tds expression1, analyse_tds_expression tds expression2)
    | AstSyntax.Ternaire (expression1, expression2, expression3) ->
      (* Analyse de la condition *)
      let ne1 = analyse_tds_expression tds expression1 in
      (* Analyse de la valeur si condition vraie *)
      let ne2 = analyse_tds_expression tds expression2 in
      (* Analyse de la valeur si condition fausse *)
      let ne3 = analyse_tds_expression tds expression3 in
      (* Renvoie la nouvelle structure de la conditionnelle ternaire *)
      AstTds.Ternaire(ne1, ne2, ne3)
    | AstSyntax.Null -> AstTds.Null
    | AstSyntax.New t -> AstTds.New t
    | AstSyntax.Adresse adr ->
      begin
        match chercherLocalement (filtrerTds tds) adr with
        | Some info ->
          begin
            match info_ast_to_info info with
              | InfoVar _ -> AstTds.Adresse info
              | _ -> raise (MauvaiseUtilisationIdentifiant adr)
          end
        | None ->
          begin
            match chercherGlobalement tds adr with
              | Some info ->
                begin
                  match info_ast_to_info info with
                    | InfoVar _ -> AstTds.Adresse info
                    | _ -> raise (MauvaiseUtilisationIdentifiant adr)
                end
              | None -> raise (IdentifiantNonDeclare adr)
          end
        end

(* analyse_tds_instruction : tds -> info_ast option -> AstSyntax.instruction -> AstTds.instruction *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre oia : None si l'instruction i est dans le bloc principal,
                   Some ia où ia est l'information associée à la fonction dans laquelle est l'instruction i sinon *)
(* Paramètre i : l'instruction à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme l'instruction
en une instruction de type AstTds.instruction *)
(* Erreur si mauvaise utilisation des identifiants *)
let rec analyse_tds_instruction tds oia i =
  match i with
  | AstSyntax.Declaration (t, n, e) ->
      begin
        match chercherLocalement (filtrerTds tds) n with
        | None ->
            (* L'identifiant n'est pas trouvé dans la tds locale,
            il n'a donc pas été déclaré dans le bloc courant *)
            (* Vérification de la bonne utilisation des identifiants dans l'expression *)
            (* et obtention de l'expression transformée *)
            let ne = analyse_tds_expression tds e in
            (* Création de l'information associée à l'identfiant *)
            let info = InfoVar (n,Undefined, 0, "") in
            (* Création du pointeur sur l'information *)
            let ia = info_to_info_ast info in
            (* Ajout de l'information (pointeur) dans la tds *)
            ajouter tds n ia;
            (* Renvoie de la nouvelle déclaration où le nom a été remplacé par l'information
            et l'expression remplacée par l'expression issue de l'analyse *)
            AstTds.Declaration (t, ia, ne)
        | Some _ ->
            (* L'identifiant est trouvé dans la tds locale,
            il a donc déjà été déclaré dans le bloc courant *)
            raise (DoubleDeclaration n)
      end
  | AstSyntax.Affectation (a,e) ->
    let na = analyse_tds_affectable tds a true in 
    let ne = analyse_tds_expression tds e in 
    AstTds.Affectation (na, ne)
  | AstSyntax.Constante (n,v) ->
      begin
        match chercherLocalement (filtrerTds tds) n with
        | None ->
          (* L'identifiant n'est pas trouvé dans la tds locale,
             il n'a donc pas été déclaré dans le bloc courant *)
          (* Ajout dans la tds de la constante *)
          ajouter tds n (info_to_info_ast (InfoConst (n,v)));
          (* Suppression du noeud de déclaration des constantes devenu inutile *)
          AstTds.Empty
        | Some _ ->
          (* L'identifiant est trouvé dans la tds locale,
          il a donc déjà été déclaré dans le bloc courant *)
          raise (DoubleDeclaration n)
      end
  | AstSyntax.Affichage e ->
      (* Vérification de la bonne utilisation des identifiants dans l'expression *)
      (* et obtention de l'expression transformée *)
      let ne = analyse_tds_expression tds e in
      (* Renvoie du nouvel affichage où l'expression remplacée par l'expression issue de l'analyse *)
      AstTds.Affichage (ne)
  | AstSyntax.Conditionnelle (c,t,e) ->
      (* Analyse de la condition *)
      let nc = analyse_tds_expression tds c in
      (* Analyse du bloc then *)
      let tast = analyse_tds_bloc tds oia t in
      (* Analyse du bloc else *)
      let east = analyse_tds_bloc tds oia e in
      (* Renvoie la nouvelle structure de la conditionnelle *)
      AstTds.Conditionnelle (nc, tast, east)
  | AstSyntax.Conditionnelle_opt(c,t) ->
      (* Analyse de la condition *)
      let nc = analyse_tds_expression tds c in
      (* Analyse du bloc then *)
      let tast = analyse_tds_bloc tds oia t in
      (* Renvoie la nouvelle structure de la conditionnelle optionelle *)
      AstTds.Conditionnelle_opt (nc, tast)
  | AstSyntax.TantQue (c,b) ->
      (* Analyse de la condition *)
      let nc = analyse_tds_expression tds c in
      (* Analyse du bloc *)
      let bast = analyse_tds_bloc tds oia b in
      (* Renvoie la nouvelle structure de la boucle *)
      AstTds.TantQue (nc, bast)
  | AstSyntax.Retour (e) ->
      begin
      (* On récupère l'information associée à la fonction à laquelle le return est associée *)
      match oia with
        (* Il n'y a pas d'information -> l'instruction est dans le bloc principal : erreur *)
      | None -> raise RetourDansMain
        (* Il y a une information -> l'instruction est dans une fonction *)
      | Some ia ->
        (* Analyse de l'expression *)
        let ne = analyse_tds_expression tds e in
        AstTds.Retour (ne,ia)
      end
  | AstSyntax.BoucleID (n,b) ->
    (* Pour gérer les boucles imbriquées, on stocke dans l'info Boucle *)
    (* l'information associé à la fonction dans laquelle elle se trouve *)
    let oi = match oia with
      | None -> None
      | Some ia -> Some (info_ast_to_info ia)
    in
    let info = InfoBoucle (n,"","", oi) in
    let ia = info_to_info_ast info in
    ajouter tds n ia;
    let nb = analyse_tds_bloc tds (Some ia) b in
    AstTds.BoucleID(ia,nb)
  | AstSyntax.Boucle (b) ->
    let oi = match oia with
    | None -> None
    | Some ia -> Some (info_ast_to_info ia)
  in
    let info = InfoBoucle ("","","", oi) in
    let ia = info_to_info_ast info in
    ajouter tds "" ia;
    let nb = analyse_tds_bloc tds (Some ia) b in
    AstTds.Boucle(ia,nb)
  | AstSyntax.BreakID (n) ->
    (* fonction qui permet d'ajouter le break avec identifiant dans l'ast et dans la tds *)
    (* vérifiant avant cela qu'il n'existe pas déja un break ou un continue portant le même nom *)
    (* si c'est le cas une exception est levée *)
    let creerBreak ia = 
      begin
        match chercherLocalement (filtrerTdsContinueBreak tds) n with 
        | Some ia2 -> 
          begin
            match info_ast_to_info ia2 with
            | InfoBreak _ -> raise (DoubleDeclaration n)
            | _ -> 
                (* Création de l'information associée au break *)
                let info = InfoBreak (n) in
                (* Création du pointeur sur l'information *)
                let iab = info_to_info_ast info in
                (* Ajout de l'information (pointeur) dans la tds *)
                ajouter tds n iab;
                AstTds.BreakID ia
            end
        | None ->
        (* Création de l'information associée au break *)
        let info = InfoBreak (n) in
        (* Création du pointeur sur l'information *)
        let iab = info_to_info_ast info in
        (* Ajout de l'information (pointeur) dans la tds *)
        ajouter tds n iab;
        AstTds.BreakID ia
      end

    in

     begin
      (* On vérifie d'abord que le break n'est pas dans le main *)
      match oia with 
      | None -> raise BreakExterieurBoucle
      | Some ia -> 
        begin 
          (* On vérifie que le break n'est pas dans une fonction mais bien dans une boucle*)
          match info_ast_to_info ia with
          (* le break est dans au moins une boucle *)
          (* on commence par la boucle la plus interne *)
          | InfoBoucle (nom,_,_,boia) -> 
              (* Si le nom de la boucle correspond, le break est bien placé et s'applique donc à celle-ci *)
              if nom = n then
                creerBreak ia
              (* Sinon il faut remonter les différentes boucles pour trouver celle qui correspond au nom*)
              else
                  begin
                    (* On cherche la boucle dans les potentielles boucles imbriquées*)
                    match (chercherBoucle boia n) with
                    (* On a trouvé une boucle avec un nom correspondant *)
                    | Some ia2 -> begin
                      (* Cette étape est nécessaire pour renvoyer la véritable information de la boucle *)
                      (* présente dans la tds et non une copie renvoyée par chercherBoucle *)
                      (* Lors de la modification des étiquettes à la génération de code, si l'information *)
                      (* de la boucle que l'on a fourni au break est une copie, elle ne sera pas modifiée *)
                      (* en même temps que l'original et les étiquettes resterons vides, on aura donc un jump *)
                      (* sans label ce qui lève une erreur de syntaxe pour le code assembleur *)
                      match trouverDansTds n (Some ia2) tds with
                      | None -> raise (IdentifiantNonDeclare n)
                      | Some ia3 ->
                          creerBreak ia3
                      end
                    (* On a pas trouvé de boucle portant ce nom *)
                    (* Le break fait appel à une boucle non déclarée*)
                    | None -> raise (IdentifiantNonDeclare n)
                    end
          | _ -> raise BreakExterieurBoucle
        end
    end
  | AstSyntax.ContinueID (n) ->
    let creerContinue ia = 
      begin
        match chercherLocalement (filtrerTdsContinueBreak tds) n with 
        | Some ia2 -> 
          begin
            match info_ast_to_info ia2 with
            | InfoContinue _ -> raise (DoubleDeclaration n)
            | _ -> 
                (* Création de l'information associée au break *)
                let info = InfoContinue (n) in
                (* Création du pointeur sur l'information *)
                let iab = info_to_info_ast info in
                (* Ajout de l'information (pointeur) dans la tds *)
                ajouter tds n iab;
                AstTds.ContinueID ia
            end
        | None ->
        (* Création de l'information associée au break *)
        let info = InfoContinue (n) in
        (* Création du pointeur sur l'information *)
        let iab = info_to_info_ast info in
        (* Ajout de l'information (pointeur) dans la tds *)
        ajouter tds n iab;
        AstTds.ContinueID ia
      end

    in

    (* même fonctionnement que pour les break *)
     begin
      match oia with 
      | None -> raise ContinueExterieurBoucle
      | Some ia -> 
        begin 

          match info_ast_to_info ia with
          | InfoBoucle (nom,_,_,coia) -> 
              if nom = n then
                creerContinue ia
              else
                  begin
                    match (chercherBoucle coia n) with
                    | Some ia2 -> begin
                      match trouverDansTds n (Some ia2) tds with
                      | None -> raise (IdentifiantNonDeclare n)
                      | Some ia3 ->
                          creerContinue ia3
                      end
                    | None -> raise (IdentifiantNonDeclare n)
                    end
          | _ -> raise ContinueExterieurBoucle
        end
    end
    (* Pour les break sans identifiant, ils seront toujours appliqués à la boucle *)
    (* la plus interne, il n'y a donc pas besoin de remonter les boucles imbriquées*)
  | AstSyntax.Break ->
    begin
      (* On vérifie d'abord que le break n'est pas dans le main *)
      match oia with 
        | None -> raise BreakExterieurBoucle
        | Some ia -> 
          begin 
            (* On vérifie que le break n'est pas dans une fonction mais bien dans une boucle *)
            match info_ast_to_info ia with
            | InfoBoucle _ -> 
                AstTds.Break ia
            | _ -> raise BreakExterieurBoucle
          end
    end
    (* même fonctionnement que pour les break *)
  | AstSyntax.Continue ->
    begin
      match oia with 
        | None -> raise ContinueExterieurBoucle
        | Some ia -> 
          begin 
            match info_ast_to_info ia with
            | InfoBoucle _ -> 
                AstTds.Continue ia
            | _ -> raise ContinueExterieurBoucle
          end
    end

(* analyse_tds_bloc : tds -> info_ast option -> AstSyntax.bloc -> AstTds.bloc *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre oia : None si le bloc li est dans le programme principal,
                   Some ia où ia est l'information associée à la fonction dans laquelle est le bloc li sinon *)
(* Paramètre li : liste d'instructions à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme le bloc en un bloc de type AstTds.bloc *)
(* Erreur si mauvaise utilisation des identifiants *)
and analyse_tds_bloc tds oia li =
  (* Entrée dans un nouveau bloc, donc création d'une nouvelle tds locale
  pointant sur la table du bloc parent *)
  let tdsbloc = creerTDSFille tds in
  (* Analyse des instructions du bloc avec la tds du nouveau bloc.
     Cette tds est modifiée par effet de bord *)
   let nli = List.map (analyse_tds_instruction tdsbloc oia) li in
   (* afficher_locale tdsbloc ; *) (* décommenter pour afficher la table locale *)
   nli



let creation_tds_fonction maintds (AstSyntax.Fonction(t,n,lp,li)) = 
  (* Création de la tds et des infos de la fonction*)
  let tdsf = creerTDSFille maintds in
  let info = InfoFun (n, t, (List.map fst lp)) in
  (* Ajout de l'info dans la tds *)
  let ia = info_to_info_ast info in
  ajouter maintds n ia;
  (* Paramètre de la fonction *)
  let nlp = List.map (fun (typ, name) ->
     begin
      (* On regarde d'abord si le paramètre n'existe pas déjà*)
       match chercherLocalement tdsf name with
       | Some _ -> raise (DoubleDeclaration name)
       | None ->
         let ia = info_to_info_ast (InfoVar (name, Undefined, 0, "")) in
         ajouter tdsf name ia;
         (typ, ia)
     end) lp in
  AstTds.Fonction(t, ia, nlp, analyse_tds_bloc tdsf (Some ia) li)


(* analyse_tds_fonction : tds -> AstSyntax.fonction -> AstTds.fonction *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre : la fonction à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme la fonction
en une fonction de type AstTds.fonction *)
(* Erreur si mauvaise utilisation des identifiants *)
let analyse_tds_fonction maintds (AstSyntax.Fonction(t,n,lp,li)) = begin
  match chercherLocalement (filtrerTds maintds) n with
  | Some ria -> 
    begin
      match info_ast_to_info ria with
      | InfoFun(_,_,lt) -> 
        if (not (Type.est_compatible_list (List.map fst lp) lt)) then
          creation_tds_fonction maintds (AstSyntax.Fonction(t,n,lp,li))
        else
          raise (DoubleDeclaration n) 
      | _ -> raise (MauvaiseUtilisationIdentifiant n)
    end
  | None -> creation_tds_fonction maintds (AstSyntax.Fonction(t,n,lp,li))
  end


(* analyser : AstSyntax.programme -> AstTds.programme *)
(* Paramètre : le programme à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme le programme
en un programme de type AstTds.programme *)
(* Erreur si mauvaise utilisation des identifiants *)
let analyser (AstSyntax.Programme (fonctions,prog)) =
  let tds = creerTDSMere () in
  let nf = List.map (analyse_tds_fonction tds) fonctions in
  let nb = analyse_tds_bloc tds None prog in
  AstTds.Programme (nf,nb)
