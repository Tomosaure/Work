/* Imports. */

%{

open Type
open Ast.AstSyntax
%}


%token <int> ENTIER
%token <string> ID
%token RETURN
%token PV
%token AO
%token AF
%token PF
%token PO
%token EQUAL
%token CONST
%token PRINT
%token IF
%token ELSE
%token WHILE
%token BOOL
%token INT
%token RAT
%token CALL 
%token CO
%token CF
%token SLASH
%token NUM
%token DENOM
%token TRUE
%token FALSE
%token PLUS
%token MULT
%token INF
%token EOF
%token PI
%token DP
%token LOOP
%token BREAK
%token CONTINUE
%token ADR
%token NEW
%token NULL

(* Type de l'attribut synthétisé des non-terminaux *)
%type <programme> prog
%type <instruction list> bloc
%type <fonction> fonc
%type <instruction> i
%type <typ> typ
%type <typ*string> param
%type <expression> e 
%type <affectable> affect

(* Type et définition de l'axiome *)
%start <Ast.AstSyntax.programme> main

%%

main : lfi=prog EOF     {lfi}

prog : lf=fonc* ID li=bloc  {Programme (lf,li)}

fonc : t=typ n=ID PO lp=param* PF li=bloc {Fonction(t,n,lp,li)}

param : t=typ n=ID  {(t,n)}

bloc : AO li=i* AF      {li}

i :
| t=typ n=ID EQUAL e1=e PV          {Declaration (t,n,e1)}
| CONST n=ID EQUAL e=ENTIER PV      {Constante (n,e)}
| PRINT e1=e PV                     {Affichage (e1)}
| IF exp=e li1=bloc ELSE li2=bloc   {Conditionnelle (exp,li1,li2)}
| IF exp=e li1=bloc                 {Conditionnelle_opt (exp,li1)}
| WHILE exp=e li=bloc               {TantQue (exp,li)}
| RETURN exp=e PV                   {Retour (exp)}
| LOOP li=bloc                      {Boucle (li)}
| n=ID DP LOOP li=bloc              {BoucleID (n,li)}
| BREAK PV                          {Break}
| BREAK n=ID PV                     {BreakID (n)}
| CONTINUE PV                       {Continue}
| CONTINUE n=ID PV                  {ContinueID (n)}
| a=affect EQUAL e1=e PV            {Affectation (a,e1)}


typ :
| BOOL              {Bool}
| INT               {Int}
| RAT               {Rat}
| t=typ MULT        {Pointeur (t)}
| PO t=typ PF      {t}

e : 
| CALL n=ID PO lp=e* PF   {AppelFonction (n,lp)}
| CO e1=e SLASH e2=e CF   {Binaire(Fraction,e1,e2)}
| TRUE                    {Booleen true}
| FALSE                   {Booleen false}
| e=ENTIER                {Entier e}
| NUM e1=e                {Unaire(Numerateur,e1)}
| DENOM e1=e              {Unaire(Denominateur,e1)}
| PO e1=e PLUS e2=e PF    {Binaire (Plus,e1,e2)}
| PO e1=e MULT e2=e PF    {Binaire (Mult,e1,e2)}
| PO e1=e EQUAL e2=e PF   {Binaire (Equ,e1,e2)}
| PO e1=e INF e2=e PF     {Binaire (Inf,e1,e2)}
| PO exp=e PF             {exp}
| PO e1=e PI e2=e DP e3=e PF {Ternaire (e1,e2,e3)}
| NULL                    {Null}
| PO NEW t=typ PF         {New t}
| ADR n=ID                {Adresse n}
| a=affect                {Affectable (a)}

affect :
| n=ID                    {Ident n}
| PO MULT a=affect PF     {Deref (a)}
