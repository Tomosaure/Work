with Ada.Text_IO;            use Ada.Text_IO;
with LCA_projet;
with Arbre;    use Arbre;
with Piles;
with Tableau;  use Tableau;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;


package body decompression is

    procedure Afficher_Pile is new Pile_Caractere.Afficher(Put);

    package LCA_projet_new is
            new LCA_projet ( T_Donnee => T_Arbre);
    use LCA_projet_new;

    procedure Reconstruire_Liste_octet(Tab_octet : in out T_Tab) is
        indice: Integer;
    begin
        indice := Tab_octet.Elements(1);
        for i in 1..indice-1 loop
            Tab_octet.Elements(i) := Tab_octet.Elements(i+1);
        end loop;
        Tab_octet.Elements(indice) := -1;
    end Reconstruire_Liste_octet;


    procedure Reconstruire_Arbre_Gauche(Tab_Huff: in T_Tab_Huff; Arbre: in out T_Arbre; compteur: in out Integer) is
        existence : boolean := False;    -- variable d'existence de sous-arbre
        arret : boolean := False;        -- variabla d'arret si la feuille est créee
        Tab_Huff_copie : T_Tab_Huff;
        pointeur: T_Arbre;

    begin
        Tab_Huff_copie := Tab_Huff;

        for i in 1..Tab_Huff_copie.Nb_Elements loop
            if not Pile_Caractere.Est_Vide(Tab_Huff_copie.Elements(i).binaire) then
                if Pile_Caractere.Sommet(Tab_Huff_copie.Elements(i).binaire) = '0'  then
                    Pile_Caractere.Depiler(Tab_Huff_copie.Elements(i).binaire);
                    existence := True;
                end if;
            end if;
        end loop;


        if existence and not arret then
            Enregistrer_Gauche(Arbre, 0);
        end if;

        if Pile_Caractere.Est_Vide(Tab_Huff_copie.Elements(compteur).binaire) then
            if Tab_Huff_copie.Elements(compteur).char = -1 then
                Enregistrer_Gauche(Arbre, -1);
                arret := True;
                compteur := compteur + 1;
            else
                Enregistrer_Gauche(Arbre, Tab_Huff_copie.Elements(compteur).char);
                arret := True;
                compteur := compteur + 1;
            end if;
        end if;

        if not arret then
            pointeur := Arbre_Gauche(Arbre);
            Reconstruire_Arbre_Huff(Tab_Huff_copie, pointeur,compteur);
        end if;
    end Reconstruire_Arbre_Gauche;

    procedure Reconstruire_Arbre_Droit(Tab_Huff: in T_Tab_Huff; Arbre: in out T_Arbre; compteur: in out Integer) is
        existence : boolean := False;    -- variable d'existence de sous-arbre
        arret : boolean := False;        -- variabla d'arret si la feuille est créee
        Tab_Huff_copie : T_Tab_Huff;
        pointeur: T_Arbre;
    begin

        Tab_Huff_copie := Tab_Huff;

        for i in 1..Tab_Huff_copie.Nb_Elements loop
            if not Pile_Caractere.Est_Vide(Tab_Huff_copie.Elements(i).binaire) then
                if Pile_Caractere.Sommet(Tab_Huff_copie.Elements(i).binaire) = '1'  then
                    Pile_Caractere.Depiler(Tab_Huff_copie.Elements(i).binaire);
                    existence := True;
                end if;
            end if;
        end loop;
        if existence then
            Enregistrer_Droit(Arbre, 0);
        end if;

        if Pile_Caractere.Est_Vide(Tab_Huff_copie.Elements(compteur).binaire)  then
            if Tab_Huff_copie.Elements(compteur).char = -1 then
                Enregistrer_Droit(Arbre, -1);
                arret := True;
                compteur := compteur + 1;

            else
                Enregistrer_Droit(Arbre, Tab_Huff_copie.Elements(compteur).char);
                arret := True;
                compteur := compteur + 1;

            end if;
        end if;
        if not arret then
            pointeur := Arbre_Droit(Arbre);
            Reconstruire_Arbre_Huff(Tab_Huff_copie, pointeur,compteur);
        end if;
    end Reconstruire_Arbre_Droit;

    procedure Reconstruire_Arbre_Huff(Tab_Huff : in T_Tab_Huff; Arbre : in out T_Arbre; compteur: in out Integer) is
    begin
        Reconstruire_Arbre_Gauche(Tab_Huff, Arbre, compteur);
        Reconstruire_Arbre_Droit(Tab_Huff,Arbre, compteur);
    end Reconstruire_Arbre_Huff;

    function Reconstruire_Tab_text_decompress(Tab_Text: T_Tab_symbole; Arbre: in T_Arbre) return T_Tab_symbole is
        compteur_text : Integer := 1;
        courant: T_Arbre;
        Text : T_Tab_symbole;
        arret : boolean := False;
    begin
        Text.Nb_Elements := 0;
        courant := Arbre;
        while compteur_text <= Tab_Text.Nb_Elements and not arret loop
            while not Est_Feuille(courant) loop
                if Tab_Text.Elements(compteur_text) = '0' then
                    courant := Arbre_Gauche(courant);
                    compteur_text := compteur_text + 1;
                else
                    courant := Arbre_Droit(courant);
                    compteur_text := compteur_text + 1;
                end if;
            end loop;
            if Frequence(courant) = -1 then
                arret := True;
            else
                Text.Elements(Text.Nb_Elements+1) := Character'Val(Frequence(courant));
                Text.Nb_Elements := Text.Nb_Elements + 1;
            end if;
            courant := Arbre;
        end loop;
        return Text;
    end Reconstruire_Tab_text_decompress;

end decompression;

