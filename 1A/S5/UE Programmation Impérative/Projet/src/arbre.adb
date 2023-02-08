with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;
with SDA_Exceptions;         use SDA_Exceptions;
with Ada.Unchecked_Deallocation;

package body Arbre is

    procedure Free is
            new Ada.Unchecked_Deallocation (Object => T_Noeud	, Name => T_Arbre);

    procedure Initialiser(arbre: out T_Arbre; Frequence : Integer) is
        noeud : T_Arbre;
    begin
        arbre := null;
        noeud := new T_Noeud'(Frequence,Null,Null);
        arbre := noeud;
    end Initialiser;


    function Est_Vide (arbre : T_Arbre) return Boolean is
    begin
        return arbre = null;
    end Est_Vide;

    function Est_Feuille (arbre : T_Arbre) return Boolean is
    begin
        return arbre.all.Droite = null;
    end Est_Feuille;


    function Arbre_Gauche (arbre : in T_Arbre) return T_Arbre is
    begin
        return arbre.all.Gauche;
    end Arbre_Gauche;

    function Arbre_Droit (arbre : in T_Arbre) return T_Arbre is
    begin
        return arbre.all.Droite;
    end Arbre_Droit;


    function Frequence(arbre : in T_Arbre) return Integer is
    begin
        return arbre.all.Frequence;
    end Frequence;

    function Taille (arbre : in T_Arbre) return Integer is
    begin
        if arbre = null then
            return 0;
        else
            return 1 + Taille(arbre.all.Gauche) + Taille(arbre.all.Droite);
        end if;
    end Taille;

    function Fusion(arbre1: in T_Arbre ; arbre2: in T_Arbre) return T_Arbre is
        arbre_fusion : T_Arbre;
    begin
        Initialiser(arbre_fusion, Frequence(arbre1) + Frequence(arbre2));
        arbre_fusion.all.Gauche := arbre1;
        arbre_fusion.all.Droite := arbre2;
        return arbre_fusion;
    end Fusion;

    procedure Afficher(Arbre : in T_Arbre; decalage : Integer ; direction : in String) is
    begin
        if not Est_Vide(Arbre) then
            for i in 1..decalage loop
                Put("|");
                Put("       ");
            end loop;
            if direction = "droite" then
                Put("\--1--");
            elsif direction = "gauche" then
                Put("\--0--");
            end if;
            Put("(");
            Put(Arbre.all.Frequence, 0);
            Put(")");
            New_Line;
            Afficher(Arbre.all.Droite, decalage + 1, "droite");
            Afficher(Arbre.all.Gauche, decalage + 1, "gauche");

        end if;
    end Afficher;

    procedure Vider (arbre : in out T_Arbre) is
    begin
        if arbre /= Null then
            Vider(arbre.all.Droite);
            Vider(arbre.all.Gauche);
            Free(arbre);
        else
            Null;
        end if;
    end Vider;

    procedure Modifier_Frequence(Arbre: in out T_Arbre; freq: in Integer) is
    begin
        Arbre.all.Frequence := freq;
    end Modifier_Frequence;

    procedure Enregistrer_Gauche(Arbre: in out T_Arbre; freq: in Integer) is
        noeud: T_Arbre;
        courant : T_Arbre;
    begin
        courant := Arbre;
        noeud := new T_Noeud;
        courant.all.Gauche := noeud;
        courant.all.Gauche.Frequence := freq;
    end Enregistrer_Gauche;

    procedure Enregistrer_Droit(Arbre: in out T_Arbre; freq: in Integer) is
        noeud: T_Arbre;
        courant : T_Arbre;
    begin
        courant := Arbre;
        noeud := new T_Noeud;
        courant.all.Droite := noeud;
        courant.all.Droite.Frequence := freq;
    end Enregistrer_Droit;
end Arbre;
