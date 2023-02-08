%{

(* Partie recopiee dans le fichier CaML genere. *)
(* Ouverture de modules exploites dans les actions *)
(* Declarations de types, de constantes, de fonctions, d'exceptions exploites dans les actions *)

%}

/* Declaration des unites lexicales et de leur type si une valeur particuliere leur est associee */

%token UL_PAROUV UL_PARFER
%token UL_PT UL_VIRG
%token UL_FAIL
%token UL_COUPURE
%token UL_DEDUCTION
%token UL_NEGATION

/* Defini le type des donnees associees a l'unite lexicale */

%token <string> UL_SYMBOLE
%token <string> UL_VARIABLE

/* Unite lexicale particuliere qui represente la fin du fichier */

%token UL_FIN

/* Type renvoye pour le nom terminal document */
%type <unit> programme

/* Le non terminal document est l'axiome */
%start programme

%% /* Regles de productions */

programme :/*Vide*/{(print_endline "programme vide")}  
            | regle programme UL_FIN { (print_endline "programme : regle suite_regle FIN ") }

regle : axiome | deduction { (print_endline "regle : A COMPLETER") }

axiome : predicat UL_PT { (print_endline "axiome : predicat POINT ") }

deduction : predicat UL_DEDUCTION deduction_aux UL_PT { (print_endline "deduction  : predicat")}

deduction_aux : deduction_aux1 | deduction_aux1 UL_VIRG deduction_aux { (print_endline "deduction_aux")}

deduction_aux1 : deduction_aux2 | UL_FAIL | UL_COUPURE { ( print_endline "deduction_aux1")}

deduction_aux2 : predicat | UL_NEGATION predicat { ( print_endline "deduction_aux2")}

predicat : UL_SYMBOLE UL_PAROUV predicat_aux UL_PARFER { (print_endline "predicat : UL_SYMBOLE UL_PAROUV liste_termes UL_PARFER ") }

predicat_aux : predicat_aux2 | predicat_aux2 UL_VIRG predicat_aux { ( print_endline "predicat_aux")}

predicat_aux2 : terme | UL_VARIABLE { ( print_endline "predicat_aux2")}

terme : UL_SYMBOLE | predicat  { ( print_endline "terme")}

%%
