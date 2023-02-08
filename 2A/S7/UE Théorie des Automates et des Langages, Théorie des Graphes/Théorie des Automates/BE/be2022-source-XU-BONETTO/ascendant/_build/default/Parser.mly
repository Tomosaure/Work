%{

(* Partie recopiee dans le fichier CaML genere. *)
(* Ouverture de modules exploites dans les actions *)
(* Declarations de types, de constantes, de fonctions, d'exceptions exploites dans les actions *)

%}

/* Declaration des unites lexicales et de leur type si une valeur particuliere leur est associee */

(* A COMPLETER *)
%token UL_ACCFER
%token UL_ACCOUV
%token UL_AFFECT
%token UL_PTVIRG
/* Defini le type des donnees associees a l'unite lexicale */

(* A COMPLETER *)
%token <string> UL_IDENT
%token <string> UL_NAME
%token <int> UL_ENTIER
/* Unite lexicale particuliere qui represente la fin du fichier */

%token UL_FIN

/* Type renvoye pour le nom terminal document */
%type <unit> record

/* Le non terminal document est l'axiome */
%start record

%% /* Regles de productions */

record : valeur UL_FIN { (print_endline "record : valeur UL_FIN") }

valeur : UL_ACCOUV sous_valeur UL_ACCFER | UL_IDENT | UL_ENTIER { (print_endline "valeur : UL_ACCOUV sous_valeur UL_ACCFER | UL_IDENT | UL_ENTIER") }

sous_valeur : /* empty */ { (print_endline "sous_valeur : empty ") }
| sous_valeur_bis { (print_endline "sous_valeur : sous_valeur_bis ") }

sous_valeur_bis: UL_NAME UL_AFFECT valeur sous_sous_valeur { (print_endline "sous_valeur_bis : UL_NAME UL_EGAL valeur sous_sous_valeur ") }

sous_sous_valeur : /* empty */ { (print_endline "sous_sous_valeur : empty ") }
| UL_PTVIRG sous_valeur_bis { (print_endline "sous_sous_valeur : UL_NAME UL_EGAL valeur sous_valeur_bis ") }
%%
