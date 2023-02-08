with Ada.Text_IO;            use Ada.Text_IO;
with LCA_projet;
with Arbre;    use Arbre;
with Piles;
with Tableau;  use Tableau;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;


package body compression is

    procedure Afficher_Pile is new Pile_Caractere.Afficher(Put);

    package LCA_projet_new is
            new LCA_projet ( T_Donnee => T_Arbre);
    use LCA_projet_new;


    function Construire_Tab_Huff (Tab_binaire: in T_Tab_symbole; Tab_octet: in T_Tab; Nb_symbole : in Integer ) return  T_Tab_Huff is
        Tab_Huff: T_Tab_Huff;
        i: Integer := 1;
        cpt: Integer := 1;
        Tab_binaire_new: T_Tab_symbole;
        arret: boolean := False;
    begin
        Tab_binaire_new.Elements := Tab_binaire.Elements;
        Tab_binaire_new.Nb_Elements := Nb_symbole + 1;    -- Lors du calcul de Nb_symbole, "\$" n'était pas prise en compte
        Tab_Huff.Nb_Elements := Nb_symbole + 1;

        for j in 1..Nb_symbole + 1 loop
            Pile_Caractere.Initialiser(Tab_Huff.Elements(j).binaire);

        end loop;

        while cpt <= (Nb_symbole + 1) and i <= Tab_binaire.Nb_Elements loop
            if Tab_octet.Elements(cpt) = -1 then
                Tab_Huff.Elements(cpt).char := -1;
            else
                Tab_Huff.Elements(cpt).char := Tab_octet.Elements(cpt);

            end if;

            if Tab_binaire_new.Elements(i) = '0' then
                Pile_Caractere.Empiler(Tab_Huff.Elements(cpt).binaire, '0');
                i := i + 1;

            elsif Tab_binaire_new.Elements(i) = 'm' then
                Pile_Caractere.Empiler(Tab_Huff.Elements(cpt).binaire, '1');
                i := i + 1;


            elsif Tab_binaire_new.Elements(i) = 'x' then
                i := i + 1;

            elsif Tab_binaire_new.Elements(i) = '1' then
                cpt := cpt +1;
                Tab_binaire_new.Elements(i) := 'm';  -- 'm' pour garder l’ancien '1' en mémoire
                while Tab_binaire_new.Elements(i-1) /= '0' loop
                    Tab_binaire_new.Elements(i-1) := 'x';    -- 'x' signifie chiffre supprimé
                    i := i-1;
                end loop;
                Tab_binaire_new.Elements(i-1) := 'x';
                i := 1;

            end if;


        end loop;
        return Tab_Huff;

    end Construire_Tab_Huff;


    function Construire_Arbre_Huff(Tab_freq : in T_Tab) return T_Arbre is
        Sda : T_LCA;
        Arbre : T_Arbre;
        Sous_Arbre : T_Arbre;
    begin
        Initialiser(Sda);
        Initialiser(Arbre, 0); -- Enregistrer la feuille correspond à “\$”
        Enregistrer(Sda, 0, Arbre) ;  --Fonction enregistrer du mini projet avec relation d’ordre pour trier automatiquement

        for i in 1..256 loop
            if Tab_Freq.Elements(i) /= 0 then
                Initialiser(Arbre, Tab_Freq.Elements(i));
                Enregistrer(Sda, Tab_Freq.Elements(i), Arbre);
            end if;
        end loop;
        while Taille(Sda) /= 1 loop
            Sous_arbre := Fusion(Premier(Sda), Deuxieme(Sda));
            Enregistrer(Sda, Frequence(Premier(Sda))+Frequence(Deuxieme(Sda)), Sous_arbre);
            Supprimer_Premier(Sda); --Supprime le 1er élément d’une SDA
            Supprimer_Premier(Sda);
        end loop;
        return Premier(Sda);
    end Construire_Arbre_Huff;



    procedure Construire_Liste_octet(Arbre: in T_Arbre; Tab_freq : in out T_Tab; Tab_octet: in out T_Tab) is
    BOOL : Boolean := False;
    begin
        if Est_Feuille(Arbre) then
            if Frequence(Arbre) = 0 then
                Tab_octet.Elements(Tab_octet.Nb_Elements+1) := -1;
                Tab_octet.Nb_Elements := Tab_octet.Nb_Elements + 1;
            else
                for i in 1..256 loop
                    if Tab_freq.Elements(i) = Frequence(Arbre) and not BOOL then
                        Tab_octet.Elements(Tab_octet.Nb_Elements+1) := i-1;
                        Tab_octet.Nb_Elements := Tab_octet.Nb_Elements + 1;
                        Tab_freq.Elements(i) := 0;
                        BOOL := True;
                    end if;
                end loop;
            end if;
        elsif not Est_Vide(Arbre_Gauche(Arbre)) then
            Construire_Liste_octet(Arbre_Gauche(Arbre), Tab_freq, Tab_octet);
            Construire_Liste_octet(Arbre_Droit(Arbre), Tab_freq, Tab_octet);
        end if;
    end Construire_Liste_octet;


    procedure Construire_Liste_binaire(Arbre: in T_Arbre; Tab_binaire: in out T_Tab_symbole) is
    begin
        if not Est_Vide(Arbre_Gauche(Arbre)) then
            Tab_binaire.Elements(Tab_binaire.Nb_Elements+1) := '0';
            Tab_binaire.Nb_Elements := Tab_binaire.Nb_Elements + 1;
            Construire_Liste_binaire(Arbre_Gauche(Arbre), Tab_binaire);

        end if;

        if not Est_Vide(Arbre_Droit(Arbre)) then
            Tab_binaire.Elements(Tab_binaire.Nb_Elements+1) := '1';
            Tab_binaire.Nb_Elements := Tab_binaire.Nb_Elements + 1;
            Construire_Liste_binaire(Arbre_Droit(Arbre), Tab_binaire);
        end if;

    end Construire_Liste_binaire;

    function Construire_Liste_octet_compress (Tab_octet: in T_Tab) return T_Tab is
        Tab_octet_compress: T_tab;
        indice: Integer := 1;
    begin
        Tab_octet_compress := Tab_octet;
        while Tab_octet_compress.Elements(indice) /= -1 loop
            indice := indice + 1;
        end loop;

        for i in 0..indice-2  loop
            Tab_octet_compress.Elements(indice-i) := Tab_octet_compress.Elements(indice-i-1);
        end loop;

        Tab_octet_compress.Elements(1) := indice;
        Tab_octet_compress.Elements(Tab_octet_compress.Nb_Elements+1) := Tab_octet_compress.Elements(Tab_octet_compress.Nb_Elements);
        Tab_octet_compress.Nb_Elements := Tab_octet_compress.Nb_Elements + 1;

        return Tab_octet_compress;
    end Construire_Liste_octet_compress;

    procedure Construire_Tab_Huff_Inverse (Tab_Huff: in out T_Tab_Huff) is
    begin
        for i in 1..Tab_Huff.Nb_Elements loop
            Pile_Caractere.Inverser(Tab_Huff.Elements(i).binaire);
        end loop;
    end Construire_Tab_Huff_Inverse;

    function Construire_Liste_octet_fichier (Tab_octet_compress : in T_Tab) return T_Tab_symbole is
        courant: Integer;
        pile : Pile_Caractere.T_Pile;
        Tableau : T_Tab_symbole;
        cpt : Integer := 1;
    begin
        Tableau.Nb_Elements := 0;
        Pile_Caractere.Initialiser(pile);
        for i in 1..Tab_octet_compress.Nb_Elements loop
            courant := Tab_octet_compress.Elements(i);
            for j in 1..8 loop
                if (courant mod 2) = 1 then
                    Pile_Caractere.Empiler(pile, '1');
                else
                    Pile_Caractere.Empiler(pile, '0');
                end if;
                courant := courant / 2;
            end loop;
            while not Pile_Caractere.Est_Vide(pile) loop
                Tableau.Elements(cpt) := Pile_Caractere.Sommet(pile);
                Pile_Caractere.Depiler(pile);
                Tableau.Nb_Elements := Tableau.Nb_Elements + 1;
                cpt := cpt + 1;
            end loop;
        end loop;
        return Tableau;
    end Construire_Liste_octet_fichier;

    function Transformer_Tab_binaire_octet (Tab: in T_Tab_symbole) return T_Tab is
        courant : Integer := 0;
        Tableau: T_Tab;
        cpt_tab : Integer := 1;
        cpt_tableau : Integer := 1;

    begin
        Tableau.Nb_Elements := 0;
        while cpt_tab <= Tab.Nb_Elements loop
            for j in 0..7 loop
                if Tab.Elements(cpt_tab) = '1' then
                    courant := courant + 2**(7-j);
                else
                    null;
                end if;
                cpt_tab := cpt_tab + 1;
            end loop;
            Tableau.Elements(cpt_tableau) := courant;
            cpt_tableau := cpt_tableau + 1;
            Tableau.Nb_Elements := Tableau.Nb_Elements + 1;
            courant := 0;
        end loop;
        return Tableau;
    end Transformer_Tab_binaire_octet;

end compression;
