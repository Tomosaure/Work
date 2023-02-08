with Piles;

-- Programme de test du module Pile.
procedure Test_Piles is

    package Pile_Caractere is
        new Piles (Capacite => 3, T_Element => Integer);
    use Pile_Caractere;

    procedure Initialiser_Avec_12 (Pile : out T_Pile) is
    begin
        Initialiser (Pile);
        Empiler (Pile, 1);
        Empiler (Pile, 2);
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
        pragma Assert (4 = Sommet (Pile1));
        pragma Assert (Est_Pleine (Pile1));
    end Tester_Empiler;


    procedure Tester_Depiler is
        Pile1 : T_Pile;
    begin
        Initialiser_Avec_12 (Pile1);
        Depiler (Pile1);
        pragma Assert (1 = Sommet (Pile1));
        Depiler (Pile1);
        pragma Assert (Est_Vide (Pile1));
    end Tester_Depiler;

    procedure Tester_Inverse is
        Pile1 : T_Pile;-
    begin
        Initialiser_Avec_12 (Pile1);
        Inverse (Pile1);
        pragma Assert (1 = Sommet (Pile1));
        Depiler (Pile1);
        pragma Assert (2 = Sommet (Pile1));
    end Tester_Depiler;


begin
    Tester_Est_Vide;
    Tester_Empiler;
    Tester_Depiler;
    Tester_Inverse;
end Test_Piles;
