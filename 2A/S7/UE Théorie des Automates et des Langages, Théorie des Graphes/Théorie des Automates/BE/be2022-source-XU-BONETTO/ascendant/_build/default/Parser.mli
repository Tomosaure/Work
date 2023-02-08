
(* The type of tokens. *)

type token = 
  | UL_PTVIRG
  | UL_NAME of (string)
  | UL_IDENT of (string)
  | UL_FIN
  | UL_ENTIER of (int)
  | UL_AFFECT
  | UL_ACCOUV
  | UL_ACCFER

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val record: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (unit)
