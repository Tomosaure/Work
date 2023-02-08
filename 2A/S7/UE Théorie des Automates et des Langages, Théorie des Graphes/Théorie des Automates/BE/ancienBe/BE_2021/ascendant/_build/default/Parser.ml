
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | UL_VIRG
    | UL_UPIDENT of (
# 29 "Parser.mly"
       (string)
# 16 "Parser.ml"
  )
    | UL_TO
    | UL_SYSTEM
    | UL_PTVIRG
    | UL_POINT
    | UL_PAROUV
    | UL_PARFER
    | UL_OUT
    | UL_MODEL
    | UL_INT
    | UL_IN
    | UL_IDENT of (
# 30 "Parser.mly"
       (string)
# 31 "Parser.ml"
  )
    | UL_FROM
    | UL_FLOW
    | UL_FLOAT
    | UL_FIN
    | UL_ENTIER of (
# 31 "Parser.mly"
       (int)
# 40 "Parser.ml"
  )
    | UL_DEUXPT
    | UL_CROOUV
    | UL_CROFER
    | UL_BOOLEAN
    | UL_BLOCK
    | UL_ACCOUV
    | UL_ACCFER
  
end

include MenhirBasics

# 1 "Parser.mly"
  

(* Partie recopiee dans le fichier CaML genere. *)
(* Ouverture de modules exploites dans les actions *)
(* Declarations de types, de constantes, de fonctions, d'exceptions exploites dans les actions *)


# 62 "Parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState03 : ('s _menhir_cell0_UL_UPIDENT, _menhir_box_modele) _menhir_state
    (** State 03.
        Stack shape : UL_UPIDENT.
        Start symbol: modele. *)

  | MenhirState05 : (('s, _menhir_box_modele) _menhir_cell1_UL_SYSTEM _menhir_cell0_UL_UPIDENT, _menhir_box_modele) _menhir_state
    (** State 05.
        Stack shape : UL_SYSTEM UL_UPIDENT.
        Start symbol: modele. *)

  | MenhirState06 : (('s _menhir_cell0_UL_UPIDENT, _menhir_box_modele) _menhir_cell1_UL_PAROUV, _menhir_box_modele) _menhir_state
    (** State 06.
        Stack shape : UL_UPIDENT UL_PAROUV.
        Start symbol: modele. *)

  | MenhirState17 : (('s, _menhir_box_modele) _menhir_cell1_UL_IDENT _menhir_cell0_sub_port _menhir_cell0_sub_types, _menhir_box_modele) _menhir_state
    (** State 17.
        Stack shape : UL_IDENT sub_port sub_types.
        Start symbol: modele. *)

  | MenhirState19 : (('s, _menhir_box_modele) _menhir_cell1_UL_ENTIER, _menhir_box_modele) _menhir_state
    (** State 19.
        Stack shape : UL_ENTIER.
        Start symbol: modele. *)

  | MenhirState27 : (('s, _menhir_box_modele) _menhir_cell1_port, _menhir_box_modele) _menhir_state
    (** State 27.
        Stack shape : port.
        Start symbol: modele. *)

  | MenhirState30 : ((('s, _menhir_box_modele) _menhir_cell1_UL_SYSTEM _menhir_cell0_UL_UPIDENT, _menhir_box_modele) _menhir_cell1_parametres, _menhir_box_modele) _menhir_state
    (** State 30.
        Stack shape : UL_SYSTEM UL_UPIDENT parametres.
        Start symbol: modele. *)

  | MenhirState38 : (('s, _menhir_box_modele) _menhir_cell1_UL_FLOW _menhir_cell0_UL_IDENT _menhir_cell0_sub_sub_flot _menhir_cell0_UL_IDENT, _menhir_box_modele) _menhir_state
    (** State 38.
        Stack shape : UL_FLOW UL_IDENT sub_sub_flot UL_IDENT.
        Start symbol: modele. *)

  | MenhirState44 : (('s, _menhir_box_modele) _menhir_cell1_sub_flot2, _menhir_box_modele) _menhir_state
    (** State 44.
        Stack shape : sub_flot2.
        Start symbol: modele. *)

  | MenhirState50 : (('s, _menhir_box_modele) _menhir_cell1_UL_BLOCK _menhir_cell0_UL_UPIDENT, _menhir_box_modele) _menhir_state
    (** State 50.
        Stack shape : UL_BLOCK UL_UPIDENT.
        Start symbol: modele. *)

  | MenhirState56 : (('s, _menhir_box_modele) _menhir_cell1_sous_system, _menhir_box_modele) _menhir_state
    (** State 56.
        Stack shape : sous_system.
        Start symbol: modele. *)

  | MenhirState64 : (('s, _menhir_box_modele) _menhir_cell1_sous_modele, _menhir_box_modele) _menhir_state
    (** State 64.
        Stack shape : sous_modele.
        Start symbol: modele. *)


and ('s, 'r) _menhir_cell1_parametres = 
  | MenhirCell1_parametres of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_port = 
  | MenhirCell1_port of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_sous_modele = 
  | MenhirCell1_sous_modele of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_sous_system = 
  | MenhirCell1_sous_system of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_sub_flot2 = 
  | MenhirCell1_sub_flot2 of 's * ('s, 'r) _menhir_state * (unit)

and 's _menhir_cell0_sub_port = 
  | MenhirCell0_sub_port of 's * (unit)

and 's _menhir_cell0_sub_sub_flot = 
  | MenhirCell0_sub_sub_flot of 's * (unit)

and 's _menhir_cell0_sub_types = 
  | MenhirCell0_sub_types of 's * (unit)

and ('s, 'r) _menhir_cell1_UL_BLOCK = 
  | MenhirCell1_UL_BLOCK of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_UL_ENTIER = 
  | MenhirCell1_UL_ENTIER of 's * ('s, 'r) _menhir_state * (
# 31 "Parser.mly"
       (int)
# 157 "Parser.ml"
)

and ('s, 'r) _menhir_cell1_UL_FLOW = 
  | MenhirCell1_UL_FLOW of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_UL_IDENT = 
  | MenhirCell1_UL_IDENT of 's * ('s, 'r) _menhir_state * (
# 30 "Parser.mly"
       (string)
# 167 "Parser.ml"
)

and 's _menhir_cell0_UL_IDENT = 
  | MenhirCell0_UL_IDENT of 's * (
# 30 "Parser.mly"
       (string)
# 174 "Parser.ml"
)

and ('s, 'r) _menhir_cell1_UL_PAROUV = 
  | MenhirCell1_UL_PAROUV of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_UL_SYSTEM = 
  | MenhirCell1_UL_SYSTEM of 's * ('s, 'r) _menhir_state

and 's _menhir_cell0_UL_UPIDENT = 
  | MenhirCell0_UL_UPIDENT of 's * (
# 29 "Parser.mly"
       (string)
# 187 "Parser.ml"
)

and _menhir_box_modele = 
  | MenhirBox_modele of (unit) [@@unboxed]

let _menhir_action_01 =
  fun () ->
    (
# 55 "Parser.mly"
                                                ( (print_endline "bloc : UL_BLOCK UL_IDENT parametres UL_PTVIRG") )
# 198 "Parser.ml"
     : (unit))

let _menhir_action_02 =
  fun () ->
    (
# 87 "Parser.mly"
                                                        ( (print_endline "entier_virg : UL_ENTIER | UL_ENTIER UL_VIRG entier_virg") )
# 206 "Parser.ml"
     : (unit))

let _menhir_action_03 =
  fun () ->
    (
# 87 "Parser.mly"
                                                        ( (print_endline "entier_virg : UL_ENTIER | UL_ENTIER UL_VIRG entier_virg") )
# 214 "Parser.ml"
     : (unit))

let _menhir_action_04 =
  fun () ->
    (
# 89 "Parser.mly"
                                                                               ( (print_endline "flot : UL_FLOW UL_IDENT UL_FROM UL_IDENT UL_TO UL_IDENT UL_PTVIRG") )
# 222 "Parser.ml"
     : (unit))

let _menhir_action_05 =
  fun () ->
    (
# 97 "Parser.mly"
                                                    ( (print_endline "sub_flot : sub_flot2 | sub_flot2 UL_VIRG sub_flot") )
# 230 "Parser.ml"
     : (unit))

let _menhir_action_06 =
  fun () ->
    (
# 97 "Parser.mly"
                                                    ( (print_endline "sub_flot : sub_flot2 | sub_flot2 UL_VIRG sub_flot") )
# 238 "Parser.ml"
     : (unit))

let _menhir_action_07 =
  fun () ->
    (
# 45 "Parser.mly"
                                                                     ( (print_endline "modele : UL_MODEL IDENT { ... } UL_FIN ") )
# 246 "Parser.ml"
     : (unit))

let _menhir_action_08 =
  fun () ->
    (
# 67 "Parser.mly"
                                           ( (print_endline "parametres UL_PAROUV port_virg UL_PARFER") )
# 254 "Parser.ml"
     : (unit))

let _menhir_action_09 =
  fun () ->
    (
# 72 "Parser.mly"
                                         ( (print_endline "port : UL_UPIDENT UL_DEUXPT type") )
# 262 "Parser.ml"
     : (unit))

let _menhir_action_10 =
  fun () ->
    (
# 69 "Parser.mly"
                 ( (print_endline "port_virg : port") )
# 270 "Parser.ml"
     : (unit))

let _menhir_action_11 =
  fun () ->
    (
# 70 "Parser.mly"
                         ( (print_endline "port_virg : port | port UL_VIRG port_virg") )
# 278 "Parser.ml"
     : (unit))

let _menhir_action_12 =
  fun () ->
    (
# 51 "Parser.mly"
     ( (print_endline "sous_modele : bloc") )
# 286 "Parser.ml"
     : (unit))

let _menhir_action_13 =
  fun () ->
    (
# 52 "Parser.mly"
         ( (print_endline "sous_modele : system") )
# 294 "Parser.ml"
     : (unit))

let _menhir_action_14 =
  fun () ->
    (
# 53 "Parser.mly"
       ( (print_endline "sous_modele : flot") )
# 302 "Parser.ml"
     : (unit))

let _menhir_action_15 =
  fun () ->
    (
# 47 "Parser.mly"
                           ( (print_endline "sous_modeles : /* empty */ ") )
# 310 "Parser.ml"
     : (unit))

let _menhir_action_16 =
  fun () ->
    (
# 48 "Parser.mly"
                           ( (print_endline "sous_modeles : sous_modele sous_modeles") )
# 318 "Parser.ml"
     : (unit))

let _menhir_action_17 =
  fun () ->
    (
# 63 "Parser.mly"
     ( (print_endline "sous_modele : bloc") )
# 326 "Parser.ml"
     : (unit))

let _menhir_action_18 =
  fun () ->
    (
# 64 "Parser.mly"
         ( (print_endline "sous_modele : system") )
# 334 "Parser.ml"
     : (unit))

let _menhir_action_19 =
  fun () ->
    (
# 65 "Parser.mly"
       ( (print_endline "sous_modele : flot") )
# 342 "Parser.ml"
     : (unit))

let _menhir_action_20 =
  fun () ->
    (
# 59 "Parser.mly"
                          ( (print_endline "sous_system : /*empty */") )
# 350 "Parser.ml"
     : (unit))

let _menhir_action_21 =
  fun () ->
    (
# 60 "Parser.mly"
                           ( (print_endline "sous_system : sous_system sous_system") )
# 358 "Parser.ml"
     : (unit))

let _menhir_action_22 =
  fun () ->
    (
# 94 "Parser.mly"
                       ( (print_endline "sous_modeles : /* empty */ ") )
# 366 "Parser.ml"
     : (unit))

let _menhir_action_23 =
  fun () ->
    (
# 95 "Parser.mly"
           ( (print_endline "sub_flot : flot_aux") )
# 374 "Parser.ml"
     : (unit))

let _menhir_action_24 =
  fun () ->
    (
# 99 "Parser.mly"
                               ( (print_endline "sub_flot2 : UL_IDENT UL_POINT UL_IDENT UL_DEUXPT UL_IDENT UL_POINT UL_IDENT") )
# 382 "Parser.ml"
     : (unit))

let _menhir_action_25 =
  fun () ->
    (
# 101 "Parser.mly"
                      ( (print_endline "sous_modeles : /* empty */ ") )
# 390 "Parser.ml"
     : (unit))

let _menhir_action_26 =
  fun () ->
    (
# 102 "Parser.mly"
                      ( (print_endline "sub_flot3 : /*empty*/ | UL_IDENT UL_POINT") )
# 398 "Parser.ml"
     : (unit))

let _menhir_action_27 =
  fun () ->
    (
# 74 "Parser.mly"
                 ( (print_endline "sub_port : UL_IN") )
# 406 "Parser.ml"
     : (unit))

let _menhir_action_28 =
  fun () ->
    (
# 75 "Parser.mly"
         ( (print_endline "sub_port : UL_OUT") )
# 414 "Parser.ml"
     : (unit))

let _menhir_action_29 =
  fun () ->
    (
# 91 "Parser.mly"
                         ( (print_endline "sous_modeles : /* empty */ ") )
# 422 "Parser.ml"
     : (unit))

let _menhir_action_30 =
  fun () ->
    (
# 92 "Parser.mly"
                      ( (print_endline "sub_sub_flot : /*empty*/ | UL_IDENT UL_POINT") )
# 430 "Parser.ml"
     : (unit))

let _menhir_action_31 =
  fun () ->
    (
# 84 "Parser.mly"
                       ( (print_endline "sub_type : /* empty */ ") )
# 438 "Parser.ml"
     : (unit))

let _menhir_action_32 =
  fun () ->
    (
# 85 "Parser.mly"
                                  ( (print_endline "sub_type : UL_CROOUV entier_virg UL_CROFER") )
# 446 "Parser.ml"
     : (unit))

let _menhir_action_33 =
  fun () ->
    (
# 80 "Parser.mly"
         ( (print_endline "sub_types : UL_INT ") )
# 454 "Parser.ml"
     : (unit))

let _menhir_action_34 =
  fun () ->
    (
# 81 "Parser.mly"
             ( (print_endline "sub_types : UL_FLOAT ") )
# 462 "Parser.ml"
     : (unit))

let _menhir_action_35 =
  fun () ->
    (
# 82 "Parser.mly"
               ( (print_endline "sub_types : UL_BOOLEAN ") )
# 470 "Parser.ml"
     : (unit))

let _menhir_action_36 =
  fun () ->
    (
# 57 "Parser.mly"
                                                                           ( (print_endline "system : UL_SYSTEM UL_IDENT parametres UL_PTVIRG") )
# 478 "Parser.ml"
     : (unit))

let _menhir_action_37 =
  fun () ->
    (
# 77 "Parser.mly"
                           ( (print_endline "type : UL_INT | UL_FLOAT | UL_BOOLEAN | UL_IDENT") )
# 486 "Parser.ml"
     : (unit))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | UL_ACCFER ->
        "UL_ACCFER"
    | UL_ACCOUV ->
        "UL_ACCOUV"
    | UL_BLOCK ->
        "UL_BLOCK"
    | UL_BOOLEAN ->
        "UL_BOOLEAN"
    | UL_CROFER ->
        "UL_CROFER"
    | UL_CROOUV ->
        "UL_CROOUV"
    | UL_DEUXPT ->
        "UL_DEUXPT"
    | UL_ENTIER _ ->
        "UL_ENTIER"
    | UL_FIN ->
        "UL_FIN"
    | UL_FLOAT ->
        "UL_FLOAT"
    | UL_FLOW ->
        "UL_FLOW"
    | UL_FROM ->
        "UL_FROM"
    | UL_IDENT _ ->
        "UL_IDENT"
    | UL_IN ->
        "UL_IN"
    | UL_INT ->
        "UL_INT"
    | UL_MODEL ->
        "UL_MODEL"
    | UL_OUT ->
        "UL_OUT"
    | UL_PARFER ->
        "UL_PARFER"
    | UL_PAROUV ->
        "UL_PAROUV"
    | UL_POINT ->
        "UL_POINT"
    | UL_PTVIRG ->
        "UL_PTVIRG"
    | UL_SYSTEM ->
        "UL_SYSTEM"
    | UL_TO ->
        "UL_TO"
    | UL_UPIDENT _ ->
        "UL_UPIDENT"
    | UL_VIRG ->
        "UL_VIRG"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37-39"]
  
  let rec _menhir_run_61 : type  ttv_stack. ttv_stack _menhir_cell0_UL_UPIDENT -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_FIN ->
          let MenhirCell0_UL_UPIDENT (_menhir_stack, _) = _menhir_stack in
          let _v = _menhir_action_07 () in
          MenhirBox_modele _v
      | _ ->
          _eRR ()
  
  let rec _menhir_run_65 : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_sous_modele -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let MenhirCell1_sous_modele (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _ = _menhir_action_16 () in
      _menhir_goto_sous_modeles _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
  
  and _menhir_goto_sous_modeles : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      match _menhir_s with
      | MenhirState64 ->
          _menhir_run_65 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MenhirState03 ->
          _menhir_run_61 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _menhir_fail ()
  
  let rec _menhir_run_04 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_UL_SYSTEM (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_UPIDENT _v ->
          let _menhir_stack = MenhirCell0_UL_UPIDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_PAROUV ->
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState05
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_06 : type  ttv_stack. (ttv_stack _menhir_cell0_UL_UPIDENT as 'stack) -> _ -> _ -> ('stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_UL_PAROUV (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_IDENT _v ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState06
      | _ ->
          _eRR ()
  
  and _menhir_run_07 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_UL_IDENT (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_DEUXPT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_OUT ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_28 () in
              _menhir_goto_sub_port _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | UL_IN ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_27 () in
              _menhir_goto_sub_port _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_goto_sub_port : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_UL_IDENT -> _ -> _ -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _menhir_stack = MenhirCell0_sub_port (_menhir_stack, _v) in
      match (_tok : MenhirBasics.token) with
      | UL_INT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_33 () in
          _menhir_goto_sub_types _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | UL_FLOAT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_34 () in
          _menhir_goto_sub_types _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | UL_BOOLEAN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_35 () in
          _menhir_goto_sub_types _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_sub_types : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_UL_IDENT _menhir_cell0_sub_port -> _ -> _ -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _menhir_stack = MenhirCell0_sub_types (_menhir_stack, _v) in
      match (_tok : MenhirBasics.token) with
      | UL_CROOUV ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_ENTIER _v ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState17
          | _ ->
              _eRR ())
      | UL_PARFER | UL_VIRG ->
          let _ = _menhir_action_31 () in
          _menhir_goto_sub_type _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_18 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_VIRG ->
          let _menhir_stack = MenhirCell1_UL_ENTIER (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_ENTIER _v ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState19
          | _ ->
              _eRR ())
      | UL_CROFER ->
          let _ = _menhir_action_02 () in
          _menhir_goto_entier_virg _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_entier_virg : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      match _menhir_s with
      | MenhirState17 ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MenhirState19 ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_21 : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_UL_IDENT _menhir_cell0_sub_port _menhir_cell0_sub_types -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _ = _menhir_action_32 () in
      _menhir_goto_sub_type _menhir_stack _menhir_lexbuf _menhir_lexer _tok
  
  and _menhir_goto_sub_type : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_UL_IDENT _menhir_cell0_sub_port _menhir_cell0_sub_types -> _ -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let MenhirCell0_sub_types (_menhir_stack, _) = _menhir_stack in
      let _ = _menhir_action_37 () in
      let MenhirCell0_sub_port (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_UL_IDENT (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _v = _menhir_action_09 () in
      match (_tok : MenhirBasics.token) with
      | UL_VIRG ->
          let _menhir_stack = MenhirCell1_port (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_IDENT _v ->
              _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState27
          | _ ->
              _eRR ())
      | UL_PARFER ->
          let _ = _menhir_action_10 () in
          _menhir_goto_port_virg _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_port_virg : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      match _menhir_s with
      | MenhirState27 ->
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MenhirState06 ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_28 : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_port -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let MenhirCell1_port (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _ = _menhir_action_11 () in
      _menhir_goto_port_virg _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
  
  and _menhir_run_24 : type  ttv_stack. (ttv_stack _menhir_cell0_UL_UPIDENT, _menhir_box_modele) _menhir_cell1_UL_PAROUV -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_UL_PAROUV (_menhir_stack, _menhir_s) = _menhir_stack in
      let _v = _menhir_action_08 () in
      _menhir_goto_parametres _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_parametres : type  ttv_stack. (ttv_stack _menhir_cell0_UL_UPIDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_modele) _menhir_state -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState50 ->
          _menhir_run_51 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState05 ->
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_51 : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_UL_BLOCK _menhir_cell0_UL_UPIDENT -> _ -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      match (_tok : MenhirBasics.token) with
      | UL_PTVIRG ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell0_UL_UPIDENT (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_UL_BLOCK (_menhir_stack, _menhir_s) = _menhir_stack in
          let _ = _menhir_action_01 () in
          _menhir_goto_bloc _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_bloc : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok ->
      match _menhir_s with
      | MenhirState03 ->
          _menhir_run_67_spec_03 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState64 ->
          _menhir_run_67_spec_64 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState30 ->
          _menhir_run_59_spec_30 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState56 ->
          _menhir_run_59_spec_56 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_67_spec_03 : type  ttv_stack. ttv_stack _menhir_cell0_UL_UPIDENT -> _ -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let _v = _menhir_action_12 () in
      _menhir_run_64 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState03 _tok
  
  and _menhir_run_64 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_sous_modele (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UL_SYSTEM ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState64
      | UL_FLOW ->
          _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState64
      | UL_BLOCK ->
          _menhir_run_49 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState64
      | UL_ACCFER ->
          let _ = _menhir_action_15 () in
          _menhir_run_65 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_31 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_UL_FLOW (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_IDENT _v ->
          let _menhir_stack = MenhirCell0_UL_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_FROM ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | UL_UPIDENT _ ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | UL_POINT ->
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      let _v = _menhir_action_30 () in
                      _menhir_goto_sub_sub_flot _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
                  | _ ->
                      _eRR ())
              | UL_IDENT _ ->
                  let _v = _menhir_action_29 () in
                  _menhir_goto_sub_sub_flot _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_goto_sub_sub_flot : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_UL_FLOW _menhir_cell0_UL_IDENT -> _ -> _ -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _menhir_stack = MenhirCell0_sub_sub_flot (_menhir_stack, _v) in
      match (_tok : MenhirBasics.token) with
      | UL_IDENT _v_0 ->
          let _menhir_stack = MenhirCell0_UL_IDENT (_menhir_stack, _v_0) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_TO ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | UL_UPIDENT _ ->
                  _menhir_run_39 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState38
              | UL_PTVIRG ->
                  let _ = _menhir_action_22 () in
                  _menhir_run_47 _menhir_stack _menhir_lexbuf _menhir_lexer
              | UL_IDENT _ ->
                  let _ = _menhir_action_25 () in
                  _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState38 _tok
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_39 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_POINT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _ = _menhir_action_26 () in
          _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_41 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | UL_IDENT _ ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_24 () in
          (match (_tok : MenhirBasics.token) with
          | UL_VIRG ->
              let _menhir_stack = MenhirCell1_sub_flot2 (_menhir_stack, _menhir_s, _v) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | UL_UPIDENT _ ->
                  _menhir_run_39 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState44
              | UL_PTVIRG ->
                  let _ = _menhir_action_22 () in
                  _menhir_run_45 _menhir_stack _menhir_lexbuf _menhir_lexer
              | UL_IDENT _ ->
                  let _ = _menhir_action_25 () in
                  _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState44 _tok
              | _ ->
                  _eRR ())
          | UL_PTVIRG ->
              let _ = _menhir_action_05 () in
              _menhir_goto_flot_aux _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_45 : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_sub_flot2 -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let MenhirCell1_sub_flot2 (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _ = _menhir_action_06 () in
      _menhir_goto_flot_aux _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
  
  and _menhir_goto_flot_aux : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _ = _menhir_action_23 () in
      _menhir_goto_sub_flot _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
  
  and _menhir_goto_sub_flot : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      match _menhir_s with
      | MenhirState38 ->
          _menhir_run_47 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MenhirState44 ->
          _menhir_run_45 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_47 : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_UL_FLOW _menhir_cell0_UL_IDENT _menhir_cell0_sub_sub_flot _menhir_cell0_UL_IDENT -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell0_UL_IDENT (_menhir_stack, _) = _menhir_stack in
      let MenhirCell0_sub_sub_flot (_menhir_stack, _) = _menhir_stack in
      let MenhirCell0_UL_IDENT (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_UL_FLOW (_menhir_stack, _menhir_s) = _menhir_stack in
      let _ = _menhir_action_04 () in
      _menhir_goto_flot _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
  
  and _menhir_goto_flot : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok ->
      match _menhir_s with
      | MenhirState03 ->
          _menhir_run_66_spec_03 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState64 ->
          _menhir_run_66_spec_64 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState30 ->
          _menhir_run_58_spec_30 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState56 ->
          _menhir_run_58_spec_56 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_66_spec_03 : type  ttv_stack. ttv_stack _menhir_cell0_UL_UPIDENT -> _ -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let _v = _menhir_action_14 () in
      _menhir_run_64 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState03 _tok
  
  and _menhir_run_66_spec_64 : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_sous_modele -> _ -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let _v = _menhir_action_14 () in
      _menhir_run_64 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState64 _tok
  
  and _menhir_run_58_spec_30 : type  ttv_stack. ((ttv_stack, _menhir_box_modele) _menhir_cell1_UL_SYSTEM _menhir_cell0_UL_UPIDENT, _menhir_box_modele) _menhir_cell1_parametres -> _ -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let _v = _menhir_action_19 () in
      _menhir_run_56 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState30 _tok
  
  and _menhir_run_56 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_sous_system (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UL_SYSTEM ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState56
      | UL_FLOW ->
          _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState56
      | UL_BLOCK ->
          _menhir_run_49 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState56
      | UL_ACCFER ->
          let _ = _menhir_action_20 () in
          _menhir_run_57 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_49 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_UL_BLOCK (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_UPIDENT _v ->
          let _menhir_stack = MenhirCell0_UL_UPIDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_PAROUV ->
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState50
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_57 : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_sous_system -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let MenhirCell1_sous_system (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _ = _menhir_action_21 () in
      _menhir_goto_sous_systems _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
  
  and _menhir_goto_sous_systems : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      match _menhir_s with
      | MenhirState56 ->
          _menhir_run_57 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MenhirState30 ->
          _menhir_run_54 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_54 : type  ttv_stack. ((ttv_stack, _menhir_box_modele) _menhir_cell1_UL_SYSTEM _menhir_cell0_UL_UPIDENT, _menhir_box_modele) _menhir_cell1_parametres -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_parametres (_menhir_stack, _, _) = _menhir_stack in
      let MenhirCell0_UL_UPIDENT (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_UL_SYSTEM (_menhir_stack, _menhir_s) = _menhir_stack in
      let _ = _menhir_action_36 () in
      _menhir_goto_system _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
  
  and _menhir_goto_system : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_modele) _menhir_state -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok ->
      match _menhir_s with
      | MenhirState64 ->
          _menhir_run_60_spec_64 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState03 ->
          _menhir_run_60_spec_03 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState56 ->
          _menhir_run_53_spec_56 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState30 ->
          _menhir_run_53_spec_30 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_60_spec_64 : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_sous_modele -> _ -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let _v = _menhir_action_13 () in
      _menhir_run_64 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState64 _tok
  
  and _menhir_run_60_spec_03 : type  ttv_stack. ttv_stack _menhir_cell0_UL_UPIDENT -> _ -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let _v = _menhir_action_13 () in
      _menhir_run_64 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState03 _tok
  
  and _menhir_run_53_spec_56 : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_sous_system -> _ -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let _v = _menhir_action_18 () in
      _menhir_run_56 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState56 _tok
  
  and _menhir_run_53_spec_30 : type  ttv_stack. ((ttv_stack, _menhir_box_modele) _menhir_cell1_UL_SYSTEM _menhir_cell0_UL_UPIDENT, _menhir_box_modele) _menhir_cell1_parametres -> _ -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let _v = _menhir_action_18 () in
      _menhir_run_56 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState30 _tok
  
  and _menhir_run_58_spec_56 : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_sous_system -> _ -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let _v = _menhir_action_19 () in
      _menhir_run_56 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState56 _tok
  
  and _menhir_run_67_spec_64 : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_sous_modele -> _ -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let _v = _menhir_action_12 () in
      _menhir_run_64 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState64 _tok
  
  and _menhir_run_59_spec_30 : type  ttv_stack. ((ttv_stack, _menhir_box_modele) _menhir_cell1_UL_SYSTEM _menhir_cell0_UL_UPIDENT, _menhir_box_modele) _menhir_cell1_parametres -> _ -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let _v = _menhir_action_17 () in
      _menhir_run_56 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState30 _tok
  
  and _menhir_run_59_spec_56 : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_sous_system -> _ -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let _v = _menhir_action_17 () in
      _menhir_run_56 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState56 _tok
  
  and _menhir_run_29 : type  ttv_stack. ((ttv_stack, _menhir_box_modele) _menhir_cell1_UL_SYSTEM _menhir_cell0_UL_UPIDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_modele) _menhir_state -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_parametres (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UL_ACCOUV ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_SYSTEM ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState30
          | UL_FLOW ->
              _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState30
          | UL_BLOCK ->
              _menhir_run_49 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState30
          | UL_ACCFER ->
              let _ = _menhir_action_20 () in
              _menhir_run_54 _menhir_stack _menhir_lexbuf _menhir_lexer
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_20 : type  ttv_stack. (ttv_stack, _menhir_box_modele) _menhir_cell1_UL_ENTIER -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let MenhirCell1_UL_ENTIER (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _ = _menhir_action_03 () in
      _menhir_goto_entier_virg _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
  
  let rec _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_modele =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_MODEL ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_UPIDENT _v ->
              let _menhir_stack = MenhirCell0_UL_UPIDENT (_menhir_stack, _v) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | UL_ACCOUV ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | UL_SYSTEM ->
                      _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState03
                  | UL_FLOW ->
                      _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState03
                  | UL_BLOCK ->
                      _menhir_run_49 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState03
                  | UL_ACCFER ->
                      let _ = _menhir_action_15 () in
                      _menhir_run_61 _menhir_stack _menhir_lexbuf _menhir_lexer
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
end

let modele =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_modele v = _menhir_run_00 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v

# 103 "Parser.mly"
  


# 1137 "Parser.ml"
