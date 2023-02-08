open Tokens

(* Type du résultat d'une analyse syntaxique *)
type parseResult =
  | Success of inputStream
  | Failure
;;

(* accept : token -> inputStream -> parseResult *)
(* Vérifie que le premier token du flux d'entrée est bien le token attendu *)
(* et avance dans l'analyse si c'est le cas *)
let accept expected stream =
  match (peekAtFirstToken stream) with
    | token when (token = expected) ->
      (Success (advanceInStream stream))
    | _ -> Failure
;;

let acceptIdent stream =
  match (peekAtFirstToken stream) with
    | UL_IDENT _ -> (Success (advanceInStream stream))
    | _ -> Failure
;;

let acceptUpIdent stream =
  match (peekAtFirstToken stream) with
    | UL_UPIDENT _ -> (Success (advanceInStream stream))
    | _ -> Failure

let acceptEntier stream =
  match (peekAtFirstToken stream) with
    | UL_ENTIER _ -> (Success (advanceInStream stream))
    | _ -> Failure
(* Définition de la monade  qui est composée de : *)
(* - le type de donnée monadique : parseResult  *)
(* - la fonction : inject qui construit ce type à partir d'une liste de terminaux *)
(* - la fonction : bind (opérateur >>=) qui combine les fonctions d'analyse. *)

(* inject inputStream -> parseResult *)
(* Construit le type de la monade à partir d'une liste de terminaux *)
let inject s = Success s;;

(* bind : 'a m -> ('a -> 'b m) -> 'b m *)
(* bind (opérateur >>=) qui combine les fonctions d'analyse. *)
(* ici on utilise une version spécialisée de bind :
   'b  ->  inputStream
   'a  ->  inputStream
    m  ->  parseResult
*)
(* >>= : parseResult -> (inputStream -> parseResult) -> parseResult *)
let (>>=) result f =
  match result with
    | Success next -> f next
    | Failure -> Failure
;;


(* parseMachine : inputStream -> parseResult *)
(* Analyse du non terminal Programme *)
let rec parseR stream =
  (print_string "R -> ...");
  (match (peekAtFirstToken stream) with
    | UL_MODEL -> 
      (print_string "model");
      (inject stream >>=
      accept UL_MODEL >>= 
      acceptUpIdent >>=
      accept UL_ACCOUV >>=
      parseSE >>=
      accept UL_ACCFER )
    | _ -> Failure)

and parseSE stream =
  (print_string "SE -> ...");
  (match (peekAtFirstToken stream) with
    | UL_ACCFER -> 
      (print_string "{");
      (inject stream )
    | UL_BLOCK | UL_SYSTEM | UL_FLOW ->
      (print_string "b|s|f ");
      (inject stream >>=
      parseE >>=
      parseSE )
    | _ -> Failure)

and parseE stream = 
  (print_string "E -> ...");
  (match (peekAtFirstToken stream) with
    | UL_BLOCK -> 
      (print_string "block");
      (inject stream >>=
      accept UL_BLOCK >>=
      acceptUpIdent >>=
      parseP >>=
      accept UL_PTVIRG)
    | UL_SYSTEM -> 
      (print_string "system");
      (inject stream >>=
      accept UL_SYSTEM >>=
      acceptUpIdent >>=
      parseP >>=
      accept UL_ACCOUV >>=
      parseSE >>=
      accept UL_ACCFER)
    | UL_FLOW -> 
      (print_string "flows");
      (inject stream >>=
      accept UL_FLOW >>=
      acceptIdent >>=
      accept UL_FROM >>=
      parseNQ >>=
      accept UL_TO >>=
      parseLN >>=
      accept UL_PTVIRG )
    | _ -> Failure)

and parseNQ stream = 
  (print_string "NQ -> ...");
  (match (peekAtFirstToken stream) with
    | UL_IDENT _ -> 
      (print_string "ident");
      (inject stream >>=
      acceptIdent)
    | UL_UPIDENT _ ->
      (print_string "Ident");
      (inject stream >>=
      acceptUpIdent >>=
      accept UL_PT >>=
      acceptIdent)

    | _ -> Failure)

and parseLN stream =
  (print_string "LN -> ...");
  (match (peekAtFirstToken stream) with
    | UL_PTVIRG -> 
      (print_string ";");
      (inject stream)
    | UL_UPIDENT _ | UL_IDENT _ ->
      (print_string "Ident");
      (inject stream >>=
      parseNQ >>=
      parseSN)
    | _ -> Failure)

and parseSN stream =
  (print_string "SN -> ...");
  (match (peekAtFirstToken stream) with
    | UL_PTVIRG -> 
      (print_string ";");
      (inject stream)
    | UL_VIRG ->
      (print_string ",");
      (inject stream >>=
      accept UL_VIRG >>=
      parseNQ >>=
      parseSN)
    | _ -> Failure)

and parseP stream =
  (print_string "P -> ...");
  (match (peekAtFirstToken stream) with
    | UL_PAROUV -> 
      (print_string "(");
      (inject stream >>=
      accept UL_PAROUV >>=
      parseLP >>=
      accept UL_PARFER)
    | _ -> Failure)

and parseLP stream =
  (print_string "LP -> ...");
  (match (peekAtFirstToken stream) with
    | UL_IDENT _ ->
      (print_string "Ident");
      (inject stream >>=
      parseDP >>=
      parseSP)
    | _ -> Failure)

and parseSP stream =
  (print_string "SP -> ...");
  (match (peekAtFirstToken stream) with
    | UL_PARFER -> 
      (print_string ")");
      (inject stream)
    | UL_VIRG ->
      (print_string ",");
      (inject stream >>=
      accept UL_VIRG >>=
      parseDP >>=
      parseSP)
    | _ -> Failure)

and parseDP stream =
  (print_string "DP -> ...");
  (match (peekAtFirstToken stream) with
    | UL_IDENT _ -> 
      (print_string "Ident");
      (inject stream >>=
      acceptIdent >>=
      accept UL_DEUXPT >>=
      parseM >>=
      parseT >>=
      parseOT)
    | _ -> Failure)

and parseM stream =
  (print_string "M -> ...");
  (match (peekAtFirstToken stream) with
    | UL_IN -> 
      (print_endline "in");
      (inject stream >>=
      accept UL_IN)
    | UL_OUT ->
      (print_endline "out");
      (inject stream >>=
      accept UL_OUT)
    | _f -> Failure)

and parseT stream =
  (print_string "T -> ...");
  (match (peekAtFirstToken stream) with
    | UL_INT -> 
      (print_string "int");
      (inject stream >>=
      accept UL_INT)
    | UL_BOOLEAN ->
      (print_string "boolean");
      (inject stream >>=
      accept UL_BOOLEAN)
    | UL_FLOAT ->
      (print_string "float");
      (inject stream >>=
      accept UL_FLOAT)
    | _ -> Failure)

and parseOT stream =
  (print_string "OT -> ...");
  (match (peekAtFirstToken stream) with
    | UL_PARFER | UL_VIRG -> 
      (print_string ")");
      (inject stream)
    | UL_CROUV -> 
      (print_string "[");
      (inject stream >>=
      accept UL_CROUV >>=
      acceptEntier>>=
      parseSV >>=
      accept UL_CROFER)
    | _ -> Failure)

and parseSV stream =
  (print_string "SV -> ...");
  (match (peekAtFirstToken stream) with
    | UL_CROFER -> 
      (print_string "]");
      (inject stream)
    | UL_VIRG ->
      (print_string ",");
      (inject stream >>=
      accept UL_VIRG >>=
      acceptEntier >>=
      parseSV)
    | _ -> Failure)
;;

