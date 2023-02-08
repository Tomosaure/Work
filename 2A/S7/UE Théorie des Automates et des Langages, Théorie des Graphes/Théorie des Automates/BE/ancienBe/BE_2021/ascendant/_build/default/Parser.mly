%{

(* Partie recopiee dans le fichier CaML genere. *)
(* Ouverture de modules exploites dans les actions *)
(* Declarations de types, de constantes, de fonctions, d'exceptions exploites dans les actions *)

%}

/* Declaration des unites lexicales et de leur type si une valeur particuliere leur est associee */

%token UL_MODEL
%token UL_BLOCK
%token UL_SYSTEM
%token UL_FLOW
%token UL_FROM
%token UL_TO
%token UL_IN
%token UL_OUT
%token UL_INT
%token UL_FLOAT 
%token UL_BOOLEAN
%token UL_ACCOUV UL_ACCFER
%token UL_VIRG UL_PTVIRG UL_DEUXPT UL_POINT   
%token UL_PAROUV UL_PARFER
%token UL_CROOUV UL_CROFER

/* Defini le type des donnees associees a l'unite lexicale */

%token <string> UL_UPIDENT
%token <string> UL_IDENT
%token <int> UL_ENTIER

/* Unite lexicale particuliere qui represente la fin du fichier */

%token UL_FIN

/* Type renvoye pour le nom terminal document */
%type <unit> modele

/* Le non terminal document est l'axiome */
%start modele

%% /* Regles de productions */

modele : UL_MODEL UL_UPIDENT UL_ACCOUV sous_modeles UL_ACCFER UL_FIN { (print_endline "modele : UL_MODEL IDENT { ... } UL_FIN ") }

sous_modeles : /* empty */ { (print_endline "sous_modeles : /* empty */ ") }
| sous_modele sous_modeles { (print_endline "sous_modeles : sous_modele sous_modeles") }

sous_modele : 
bloc { (print_endline "sous_modele : bloc") }
| system { (print_endline "sous_modele : system") }
| flot { (print_endline "sous_modele : flot") }

bloc : UL_BLOCK UL_UPIDENT parametres UL_PTVIRG { (print_endline "bloc : UL_BLOCK UL_IDENT parametres UL_PTVIRG") }

system : UL_SYSTEM UL_UPIDENT parametres UL_ACCOUV sous_systems UL_ACCFER  { (print_endline "system : UL_SYSTEM UL_IDENT parametres UL_PTVIRG") }

sous_systems : /*empty */ { (print_endline "sous_system : /*empty */") }
| sous_system sous_systems { (print_endline "sous_system : sous_system sous_system") }

sous_system : 
bloc { (print_endline "sous_modele : bloc") }
| system { (print_endline "sous_modele : system") }
| flot { (print_endline "sous_modele : flot") }

parametres : UL_PAROUV port_virg UL_PARFER { (print_endline "parametres UL_PAROUV port_virg UL_PARFER") }

port_virg : port { (print_endline "port_virg : port") }
| port UL_VIRG port_virg { (print_endline "port_virg : port | port UL_VIRG port_virg") }

port : UL_IDENT UL_DEUXPT sub_port types { (print_endline "port : UL_UPIDENT UL_DEUXPT type") }

sub_port : UL_IN { (print_endline "sub_port : UL_IN") }
| UL_OUT { (print_endline "sub_port : UL_OUT") }

types : sub_types sub_type { (print_endline "type : UL_INT | UL_FLOAT | UL_BOOLEAN | UL_IDENT") }

sub_types : 
  UL_INT { (print_endline "sub_types : UL_INT ") }
  | UL_FLOAT { (print_endline "sub_types : UL_FLOAT ") }
  | UL_BOOLEAN { (print_endline "sub_types : UL_BOOLEAN ") }

sub_type : /* empty */ { (print_endline "sub_type : /* empty */ ") }
| UL_CROOUV entier_virg UL_CROFER { (print_endline "sub_type : UL_CROOUV entier_virg UL_CROFER") }

entier_virg : UL_ENTIER | UL_ENTIER UL_VIRG entier_virg { (print_endline "entier_virg : UL_ENTIER | UL_ENTIER UL_VIRG entier_virg") }

flot : UL_FLOW UL_IDENT UL_FROM sub_sub_flot UL_IDENT UL_TO sub_flot UL_PTVIRG { (print_endline "flot : UL_FLOW UL_IDENT UL_FROM UL_IDENT UL_TO UL_IDENT UL_PTVIRG") }

sub_sub_flot : /*empty*/ { (print_endline "sous_modeles : /* empty */ ") }
| UL_UPIDENT UL_POINT { (print_endline "sub_sub_flot : /*empty*/ | UL_IDENT UL_POINT") }

sub_flot : /* empty */ { (print_endline "sous_modeles : /* empty */ ") }
| flot_aux { (print_endline "sub_flot : flot_aux") }

flot_aux :   sub_flot2 | sub_flot2 UL_VIRG sub_flot { (print_endline "sub_flot : sub_flot2 | sub_flot2 UL_VIRG sub_flot") }

sub_flot2 : sub_flot3 UL_IDENT { (print_endline "sub_flot2 : UL_IDENT UL_POINT UL_IDENT UL_DEUXPT UL_IDENT UL_POINT UL_IDENT") }

sub_flot3 : /*empty*/ { (print_endline "sous_modeles : /* empty */ ") }
| UL_UPIDENT UL_POINT { (print_endline "sub_flot3 : /*empty*/ | UL_IDENT UL_POINT") }
%%

