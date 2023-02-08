{

  open TokenJava
(*  open String *)
(*  open Str *)
  exception LexicalError

}

(* Macro-definitions *)
let minuscule = ['a'-'z']
let majuscule = ['A'-'Z']
let chiffre = ['0'-'9']
let alphabet = minuscule | majuscule
let alphanum = alphabet | chiffre | '_'
let commentaireBloc = (* A COMPLETER *) "/*" _* "*/" 
let commentaireLigne = "//" [^'\n']* '\n'
let underscore = '_'
let underscores = underscore underscore*

let BinaryDigit = '0' | '1'
let BinaryDigitOrUnderscore = underscore | BinaryDigit
let BinaryDigitsAndUnderscores = BinaryDigitOrUnderscore BinaryDigitOrUnderscore*
let BinaryDigits = BinaryDigit | BinaryDigit BinaryDigitsAndUnderscores? BinaryDigit
let BinaryNumeral = '0' ('b' | 'B') BinaryDigits

let OctalDigit = ['0'-'7']
let OctalDigitOrUnderscore = OctalDigit | underscore
let OctalDigitAndUnderscores = OctalDigitOrUnderscore OctalDigitOrUnderscore*
let OctalDigits = OctalDigit | OctalDigit OctalDigitAndUnderscores? OctalDigit
let OctalNumeral = 0 (OctalDigits | underscores OctalDigits)

let HexDigit = chiffre | ['a'-'f'] | ['A'-'F']
let HexDigitOrUnderscore = HexDigit | underscore
let HexDigitsAndUnderscores = HexDigitOrUnderscore (HexDigitOrUnderscore)*
let HexDigits = HexDigit | HexDigit HexDigitsAndUnderscores? HexDigit
let HexNumeral = '0' ('x' | 'X') HexDigits

let NonZeroDigit = ['1'-'9']
let Digit = '0' | NonZeroDigit
let DigitOrUnderscore = Digit | underscore
let DigitsAndUnderscores = DigitOrUnderscore DigitOrUnderscore*
let Digits = Digit | Digit DigitsAndUnderscores? Digit
let DecimalNumeral = 0 | NonZeroDigit Digits? | NonZeroDigit underscores Digits

(* Analyseur lexical : expression reguliere { action CaML } *)
rule lexer = parse
(* Espace, tabulation, passage a ligne, etc : consommes par l'analyse lexicale *)
  | ['\n' '\t' ' ']+    { lexer lexbuf }
(* Commentaires consommes par l'analyse lexicale *)
  | commentaireBloc  	{ lexer lexbuf }
  | commentaireLigne	{ lexer lexbuf }
(* Structures de blocs *)
  | "("                 { PAROUV }
  | ")"                 { PARFER }
  | "["                 { CROOUV }
  | "]"                 { CROFER }
  | "{"                 { ACCOUV }
  | "}"                 { ACCFER }
(* Separateurs *)
  | ","                 { VIRG }
  | ";"                 { PTVIRG }
(* Operateurs booleens *)
  | "||"                { OPOU }
  | "&&"                { OPET }
  | "!"                 { OPNON }
(* Operateurs comparaisons *)
  | "=="                { OPEG }
  | "!="                { OPNONEG }
  | "<="                { OPSUPEG }
  | "<"                 { OPSUP }
  | ">="                { OPINFEG }
  | ">"                 { OPINF }
(* Operateurs arithmetiques *)
  | "+"                 { OPPLUS }
  | "-"                 { OPMOINS }
  | "*"                 { OPMULT }
  | "/"                 { OPDIV }
  | "%"                 { OPMOD }
  | "."                 { OPPT }
  | "="                 { ASSIGN }
  | "new"               { NOUVEAU }
(* Mots cles : types *)
  | "bool"              { BOOL }
  | "char"              { CHAR }
  | "float"             { FLOAT }
  | "int"               { INT }
  | "String"            { STRING }
  | "void"              { VOID }
(* Mots cles : instructions *)
  | "while"		{ TANTQUE }
  | "if"		{ SI }
  | "else"		{ SINON }
  | "return"		{ RETOUR }
(* Mots cles : constantes *)
  | "true"		{ (BOOLEEN true) }
  | "false"		{ (BOOLEEN false) }
  | "null"		{ VIDE }
(* Nombres entiers : A COMPLETER *)
  | 
(* Nombres flottants : A COMPLETER *)
  | (chiffre+ "." chiffre+) as texte     { (FLOTTANT (float_of_string texte)) }
(* Caracteres : A COMPLETER *)
  | "'" [^"'""\"] "'" as texte                   { CARACTERE texte.[1] }
(* Chaines de caracteres : A COMPLETER *)
  | '"' _* '"' as texte                  { CHAINE texte }
(* Identificateurs *)
  | majuscule alphanum* as texte              { TYPEIDENT texte }
  | minuscule alphanum* as texte              { IDENT texte }
  | eof                                       { FIN }
  | _                                         { raise LexicalError }

{

}
