with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Piles;

-- Programme de test du module Pile.
procedure Test_Piles is

    package Pile_Integer is
            new Piles (Capacite => 3, T_Element => Integer);
    use Pile_Integer;

    procedure Afficher_Entier (N: in Integer) is
    begin
        Put(N, 1);
    end Afficher_Entier;

    procedure Afficher is new Pile_Integer.Afficher (Afficher_Entier);

    procedure Initialiser_Avec_12 (Pile : out T_Pile) is
    begin
        Initialiser (Pile);
        Empiler (Pile, 1);
        Empiler (Pile, 2);
        Afficher(Pile);
        New_Line;
    end Initialiser_Avec_12;


    procedure Tester_Est_Vide is
        Pile1, Pile2 : T_Pile;
    begin
        Initialiser (Pile1);
        pragma Assert (Est_Vide (Pile1));

        Empiler (Pile1, 3);
        pragma Assert (not Est_Vide (Pile1));

        Initialiser_Avec_12 (Pile2);
        pragma Assert (not Est_Vide (Pile2));
    end Tester_Est_Vide;


    procedure Tester_Empiler is
        Pile1 : T_Pile;
    begin
        Initialiser_Avec_12 (Pile1);
        pragma Assert (not Est_Pleine (Pile1));

        Empiler (Pile1, 4);
        Afficher(Pile1); New_line;
        pragma Assert (4 = Sommet (Pile1));
        pragma Assert (Est_Pleine (Pile1));
    end Tester_Empiler;


    procedure Tester_Depiler is
        Pile1 : T_Pile;
    begin
        Initialiser_Avec_12 (Pile1);
        Depiler (Pile1);
        Afficher(Pile1); New_line;
        pragma Assert (1 = Sommet (Pile1));
        Depiler (Pile1);
        Afficher(Pile1); New_line;
        pragma Assert (Est_Vide (Pile1));
    end Tester_Depiler;

    procedure Tester_Inverser is
        Pile1 : T_Pile;
    begin
        New_line;
        Initialiser_Avec_12 (Pile1);
        Inverser (Pile1);
        Afficher(Pile1); New_line;
        pragma Assert (1 = Sommet (Pile1));
        Depiler (Pile1);
        pragma Assert (2 = Sommet (Pile1));
    end Tester_Inverser;


begin
    Tester_Est_Vide;
    Put_Line("OK_Est_Vide"); New_line;
    Tester_Empiler;
    Put_Line("OK_Empiler"); New_line;
    Tester_Depiler;
    Put_Line("OK_Depiler");
    Tester_Inverser;
    Put_Line("OK_Inverser"); New_line;
end Test_Piles;
