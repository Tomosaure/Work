with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with arbre; use arbre;
with LCA_projet;
procedure Test_Arbre is

    package LCA is
            new LCA_projet (T_Donnee => T_Arbre);
    use LCA;

    Nb_Noeuds : constant Integer := 5;
    Tab_Freq : constant array (1..Nb_Noeuds) of Integer
            := (1,2,3,4,5);
    --(15)
    -- \--0--(5)
    -- |
    -- \--1--(3)
    --        \--0--(2)
    --        \--1--(1)

    procedure Construire_Exemple_Arbre (Arbre : out T_Arbre) is
        Sda : T_LCA;
        Arbre_Fusion : T_Arbre;
    begin
        LCA.Initialiser(Sda);
        for i in 1..Nb_Noeuds loop
            Initialiser(Arbre, Tab_Freq(i));
            LCA.Enregistrer(Sda, Tab_Freq(i), Arbre);
            Afficher(Sda); New_line;
        end loop;
        for I in 1..Nb_Noeuds-1 loop
            Arbre_Fusion := Fusion(Premier(Sda), Deuxieme(Sda));
            Supprimer_Premier(Sda);
            Supprimer_Premier(Sda);
            Enregistrer(Sda,Frequence(Arbre_Fusion),Arbre_Fusion);
        end loop;
        Arbre := Premier(Sda);
        Afficher(Arbre, -1, "test");
    end Construire_Exemple_Arbre;


    procedure Tester_Exemple_Arbre is
        Arbre : T_Arbre;
    begin
        Construire_Exemple_Arbre (Arbre);
        Vider(Arbre);
    end Tester_Exemple_Arbre;

    procedure Tester_Arbre_Gauche_Droit is
        Arbre : T_Arbre;
        Sous_Arbre : T_Arbre;
        Nouveau_Arbre: T_Arbre;
    begin
        Construire_Exemple_Arbre (Arbre);
        Initialiser(Sous_Arbre, 30);
        Nouveau_Arbre := Fusion(Arbre, Sous_Arbre);
        pragma assert(Arbre_Gauche(Nouveau_Arbre) = Sous_Arbre);
        pragma assert(Arbre_Droit(Nouveau_Arbre) = Arbre);
        Vider(Nouveau_Arbre);
    end Tester_Arbre_Gauche_Droit;

    procedure Tester_Frequence is
        Arbre : T_Arbre;
    begin
        Construire_Exemple_Arbre (Arbre);
        pragma assert(1 = Frequence(Arbre_Gauche(Arbre_Gauche(Arbre))));
        Vider(Arbre);
    end Tester_Frequence;

    procedure Tester_Taille is
        Arbre : T_Arbre;
    begin
        Construire_Exemple_Arbre(Arbre);
        pragma assert (5 = Taille(Arbre));
        Vider(Arbre);
    end Tester_Taille;

    procedure Tester_Fusion is
        Arbre1 : T_Arbre;
        Arbre2 : T_Arbre;
        Arbre_Fusion : T_Arbre;
    begin
        Initialiser(Arbre1, 0);
        Initialiser(Arbre2, 5);
        Arbre_Fusion := Fusion(Arbre1, Arbre2);
        Afficher(Arbre_Fusion, -1 , "test");
        pragma assert (7 = Frequence(Arbre_Fusion));
        pragma assert (Arbre1 = Arbre_Gauche(Arbre_Fusion));
        pragma assert (Arbre2 = Arbre_Droit(Arbre_Fusion));
        Vider(Arbre_Fusion);
    end Tester_Fusion;



    Nb_Noeuds2 : constant Integer := 10;
    Tab_Freq2 : constant array (1..Nb_Noeuds2) of Integer
            := (1,2,3,4,5,6,7,8,9,10);

    procedure Construire_Exemple_Arbre2(Arbre : out T_Arbre) is
        Sda : T_LCA;
        Arbre_Fusion : T_Arbre;
    begin
        LCA.Initialiser(Sda);
        for i in 1..Nb_Noeuds2 loop
            Initialiser(Arbre, Tab_Freq2(i));
            LCA.Enregistrer(Sda, Tab_Freq2(i), Arbre);
            Afficher(Sda); New_line;
        end loop;
        for I in 1..Nb_Noeuds2-1 loop
            Arbre_Fusion := Fusion(Premier(Sda), Deuxieme(Sda));
            Supprimer_Premier(Sda);
            Supprimer_Premier(Sda);
            Enregistrer(Sda,Frequence(Arbre_Fusion),Arbre_Fusion);
        end loop;
        Arbre := Premier(Sda);
        Afficher(Arbre, -1, "test");
    end Construire_Exemple_Arbre2;

    procedure Tester_Exemple_Arbre2 is
        Arbre : T_Arbre;
    begin
        Construire_Exemple_Arbre2(Arbre);
        Vider(Arbre);
    end Tester_Exemple_Arbre2;

    procedure Tester_Enregistrer is
        Arbre: T_Arbre;
    begin
        Initialiser(Arbre, 0);
        Afficher(Arbre, -1, "test");
        Enregistrer_Gauche(Arbre, 0);
        Enregistrer_Droit(Arbre, 1);
        pragma assert (Frequence(Arbre_Gauche(Arbre)) = 0);
        pragma assert (Frequence(Arbre_Droit(Arbre)) = 1);
        Afficher(Arbre, -1, "test");
    end Tester_Enregistrer;
    -- procedure Tester_Modifier_Frequence is
    --   Arbre : T_Arbre;
    -- aux : T_Arbre;
    -- begin
    --   aux := Arbre_Gauche(Arbre_Gauche(Arbre));
    --   Construire_Exemple_Arbre(Arbre);
    --   pragma assert(1 = Frequence(Arbre_Gauche(Arbre_Gauche(Arbre))));
    --   Modifier_Frequence(aux, 8);
    --     pragma assert(8 = Frequence(Arbre_Gauche(Arbre_Gauche(Arbre))));
    -- end Tester_Modifier_Frequence;


begin
    Tester_Exemple_Arbre;
    Put_Line("ok exemple arbre");
    Tester_Arbre_Gauche_Droit;
    Put_Line("ok arbre gauche et droit");
    Tester_Frequence;
    Put_Line("ok frequence");
    --Tester_Modifier_Frequence;
    --Put_Line("ok modifier frequence");
    Tester_Fusion;
    Put_Line("ok Fusion");
    Tester_Taille;
    Put_Line("ok taille");
    Tester_Exemple_Arbre2;
    Put_Line("ok exemple arbre 2");
    Tester_Enregistrer;
    Put_Line("ok enregistrer ");
    Put_Line ("Fin des tests : OK.");
end Test_Arbre;
