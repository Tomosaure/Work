
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | UL_PTVIRG
    | UL_NAME of (
# 20 "Parser.mly"
       (string)
# 16 "Parser.ml"
  )
    | UL_IDENT of (
# 19 "Parser.mly"
       (string)
# 21 "Parser.ml"
  )
    | UL_FIN
    | UL_ENTIER of (
# 21 "Parser.mly"
       (int)
# 27 "Parser.ml"
  )
    | UL_AFFECT
    | UL_ACCOUV
    | UL_ACCFER
  
end

include MenhirBasics

# 1 "Parser.mly"
  

(* Partie recopiee dans le fichier CaML genere. *)
(* Ouverture de modules exploites dans les actions *)
(* Declarations de types, de constantes, de fonctions, d'exceptions exploites dans les actions *)


# 45 "Parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState00 : ('s, _menhir_box_record) _menhir_state
    (** State 00.
        Stack shape : .
        Start symbol: record. *)

  | MenhirState03 : (('s, _menhir_box_record) _menhir_cell1_UL_ACCOUV, _menhir_box_record) _menhir_state
    (** State 03.
        Stack shape : UL_ACCOUV.
        Start symbol: record. *)

  | MenhirState05 : (('s, _menhir_box_record) _menhir_cell1_UL_NAME, _menhir_box_record) _menhir_state
    (** State 05.
        Stack shape : UL_NAME.
        Start symbol: record. *)

  | MenhirState07 : ((('s, _menhir_box_record) _menhir_cell1_UL_NAME, _menhir_box_record) _menhir_cell1_valeur, _menhir_box_record) _menhir_state
    (** State 07.
        Stack shape : UL_NAME valeur.
        Start symbol: record. *)


and ('s, 'r) _menhir_cell1_valeur = 
  | MenhirCell1_valeur of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_UL_ACCOUV = 
  | MenhirCell1_UL_ACCOUV of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_UL_NAME = 
  | MenhirCell1_UL_NAME of 's * ('s, 'r) _menhir_state * (
# 20 "Parser.mly"
       (string)
# 79 "Parser.ml"
)

and _menhir_box_record = 
  | MenhirBox_record of (unit) [@@unboxed]

let _menhir_action_01 =
  fun () ->
    (
# 34 "Parser.mly"
                       ( (print_endline "record : valeur UL_FIN") )
# 90 "Parser.ml"
     : (unit))

let _menhir_action_02 =
  fun () ->
    (
# 43 "Parser.mly"
                               ( (print_endline "sous_sous_valeur : empty ") )
# 98 "Parser.ml"
     : (unit))

let _menhir_action_03 =
  fun () ->
    (
# 44 "Parser.mly"
                            ( (print_endline "sous_sous_valeur : UL_NAME UL_EGAL valeur sous_valeur_bis ") )
# 106 "Parser.ml"
     : (unit))

let _menhir_action_04 =
  fun () ->
    (
# 38 "Parser.mly"
                          ( (print_endline "sous_valeur : empty ") )
# 114 "Parser.ml"
     : (unit))

let _menhir_action_05 =
  fun () ->
    (
# 39 "Parser.mly"
                  ( (print_endline "sous_valeur : sous_valeur_bis ") )
# 122 "Parser.ml"
     : (unit))

let _menhir_action_06 =
  fun () ->
    (
# 41 "Parser.mly"
                                                           ( (print_endline "sous_valeur_bis : UL_NAME UL_EGAL valeur sous_sous_valeur ") )
# 130 "Parser.ml"
     : (unit))

let _menhir_action_07 =
  fun () ->
    (
# 36 "Parser.mly"
                                                                ( (print_endline "valeur : UL_ACCOUV sous_valeur UL_ACCFER | UL_IDENT | UL_ENTIER") )
# 138 "Parser.ml"
     : (unit))

let _menhir_action_08 =
  fun () ->
    (
# 36 "Parser.mly"
                                                                ( (print_endline "valeur : UL_ACCOUV sous_valeur UL_ACCFER | UL_IDENT | UL_ENTIER") )
# 146 "Parser.ml"
     : (unit))

let _menhir_action_09 =
  fun () ->
    (
# 36 "Parser.mly"
                                                                ( (print_endline "valeur : UL_ACCOUV sous_valeur UL_ACCFER | UL_IDENT | UL_ENTIER") )
# 154 "Parser.ml"
     : (unit))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | UL_ACCFER ->
        "UL_ACCFER"
    | UL_ACCOUV ->
        "UL_ACCOUV"
    | UL_AFFECT ->
        "UL_AFFECT"
    | UL_ENTIER _ ->
        "UL_ENTIER"
    | UL_FIN ->
        "UL_FIN"
    | UL_IDENT _ ->
        "UL_IDENT"
    | UL_NAME _ ->
        "UL_NAME"
    | UL_PTVIRG ->
        "UL_PTVIRG"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37-39"]
  
  let rec _menhir_run_13 : type  ttv_stack. ttv_stack -> _ -> _menhir_box_record =
    fun _menhir_stack _tok ->
      match (_tok : MenhirBasics.token) with
      | UL_FIN ->
          let _v = _menhir_action_01 () in
          MenhirBox_record _v
      | _ ->
          _eRR ()
  
  let rec _menhir_run_03 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_record) _menhir_state -> _menhir_box_record =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_UL_ACCOUV (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_NAME _v ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState03
      | UL_ACCFER ->
          let _ = _menhir_action_04 () in
          _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_04 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_record) _menhir_state -> _menhir_box_record =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_UL_NAME (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_AFFECT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_IDENT _ ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_08 () in
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState05 _tok
          | UL_ENTIER _ ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_09 () in
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState05 _tok
          | UL_ACCOUV ->
              _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState05
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_06 : type  ttv_stack. ((ttv_stack, _menhir_box_record) _menhir_cell1_UL_NAME as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_record) _menhir_state -> _ -> _menhir_box_record =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_valeur (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UL_PTVIRG ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_NAME _v ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState07
          | _ ->
              _eRR ())
      | UL_ACCFER ->
          let _ = _menhir_action_02 () in
          _menhir_goto_sous_sous_valeur _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_goto_sous_sous_valeur : type  ttv_stack. ((ttv_stack, _menhir_box_record) _menhir_cell1_UL_NAME, _menhir_box_record) _menhir_cell1_valeur -> _ -> _ -> _menhir_box_record =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let MenhirCell1_valeur (_menhir_stack, _, _) = _menhir_stack in
      let MenhirCell1_UL_NAME (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _ = _menhir_action_06 () in
      _menhir_goto_sous_valeur_bis _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
  
  and _menhir_goto_sous_valeur_bis : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_record) _menhir_state -> _menhir_box_record =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      match _menhir_s with
      | MenhirState03 ->
          _menhir_run_10_spec_03 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MenhirState07 ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_10_spec_03 : type  ttv_stack. (ttv_stack, _menhir_box_record) _menhir_cell1_UL_ACCOUV -> _ -> _ -> _menhir_box_record =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _ = _menhir_action_05 () in
      _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer
  
  and _menhir_run_11 : type  ttv_stack. (ttv_stack, _menhir_box_record) _menhir_cell1_UL_ACCOUV -> _ -> _ -> _menhir_box_record =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_UL_ACCOUV (_menhir_stack, _menhir_s) = _menhir_stack in
      let _v = _menhir_action_07 () in
      _menhir_goto_valeur _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_valeur : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_record) _menhir_state -> _ -> _menhir_box_record =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState00 ->
          _menhir_run_13 _menhir_stack _tok
      | MenhirState05 ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_08 : type  ttv_stack. ((ttv_stack, _menhir_box_record) _menhir_cell1_UL_NAME, _menhir_box_record) _menhir_cell1_valeur -> _ -> _ -> _menhir_box_record =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _ = _menhir_action_03 () in
      _menhir_goto_sous_sous_valeur _menhir_stack _menhir_lexbuf _menhir_lexer
  
  let rec _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_record =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_IDENT _ ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _ = _menhir_action_08 () in
          _menhir_run_13 _menhir_stack _tok
      | UL_ENTIER _ ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _ = _menhir_action_09 () in
          _menhir_run_13 _menhir_stack _tok
      | UL_ACCOUV ->
          _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | _ ->
          _eRR ()
  
end

let record =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_record v = _menhir_run_00 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v

# 45 "Parser.mly"
  

# 320 "Parser.ml"
