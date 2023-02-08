with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Tableau; use Tableau;
with compression; use compression;

package body openfile is
    File      : Ada.Streams.Stream_IO.File_Type;	-- car il y a aussi Ada.Text_IO.File_Type

    function Stockage(File_Name : in String) return T_Tab_Symbole is
        S         : Stream_Access;
        Octet     : T_Octet;
        Symbole : T_Tab_Symbole;
    begin
        Open(File, In_File, File_Name);
        S := Stream(File);
        Symbole.Nb_Elements:= 0;
        while not End_Of_File(File) loop
            Octet := T_Octet'Input(S);
            Symbole.Nb_Elements := Symbole.Nb_Elements + 1;
            Symbole.Elements(Symbole.Nb_Elements) := Character'Val(Octet);
        end loop;
        --   Fermer le fichier
        Close (File);
        return Symbole;
    end Stockage;


    function Tab_Frequence(Tab_Texte : in T_Tab_symbole) return T_Tab is
        Tab_Freq : T_Tab;
        i : Integer := 1;
    begin
        for j in 1..256 loop
            Tab_Freq.Elements(j) := 0;
        end loop;

        while i /=Tab_Texte.Nb_Elements loop
            for j in 1..256 loop
                if Tab_Texte.Elements(i) = Character'Val(j-1) then
                    Tab_Freq.Elements(j) := Tab_Freq.Elements(j) + 1;
                end if;
            end loop;
            i := i + 1;
        end loop;
        return Tab_Freq;
    end Tab_Frequence;

    function Nb_Symbole(Tab_Freq : in T_Tab) return Integer is
        Nb : Integer;
    begin
        Nb := 0;
        for i in 1..256 loop
            if Tab_Freq.Elements(i) /= 0 then
                Nb := Nb + 1;
            end if;
        end loop;
        return Nb;
    end Nb_Symbole;

    function Tab_Symbole(Tab_Texte : in T_Tab_symbole; Nb_Symbole : Integer) return T_Tab_Symbole is
        Tab : T_Tab_Symbole ;
        bool : Boolean;
    begin
        Tab.Nb_Elements := 1;
        bool := False;
        for i in 1..Tab_Texte.Nb_Elements loop
            for j in 1..Nb_Symbole loop
                if Tab.Elements(j) = Tab_Texte.Elements(i) then
                    bool := True;
                end if;
            end loop;
            if not bool then
                Tab.Elements(Tab.Nb_Elements) := Tab_Texte.Elements(i);
                Tab.Nb_Elements := Tab.Nb_Elements +1;
            end if;
            bool := False;
        end loop;
        Tab.Nb_Elements := Tab.Nb_Elements -1;
        return Tab;
    end Tab_Symbole;

    procedure ecriture(Tab_Huff : in T_Tab_Huff; Liste_binaire : in T_Tab_symbole; Tab_texte : in T_Tab_symbole; Tab_octet_compress : in T_tab; File_Name : in String) is
        Tableau : T_Tab_symbole;
        Tableau_2 : T_Tab;
        Tab_octet : T_Tab_symbole;
        S : Stream_Access;
        Pile : Pile_Caractere.T_Pile;
        reste : Integer;
    begin
        Tableau.Nb_Elements := 1;

        Tab_octet := Construire_Liste_octet_fichier(Tab_octet_compress);
        for i in 1..Tab_octet.Nb_Elements loop
            Tableau.Elements(Tableau.Nb_Elements) := Tab_octet.Elements(i);
            Tableau.Nb_Elements := Tableau.Nb_Elements + 1;
        end loop;

        for i in 1..Liste_binaire.Nb_Elements loop
            Tableau.Elements(Tableau.Nb_Elements) := Liste_binaire.Elements(i);
            Tableau.Nb_Elements := Tableau.Nb_Elements + 1;
        end loop;

        for i in 1..Tab_texte.Nb_Elements loop
            for j in 1..Tab_Huff.Nb_Elements loop
                if  Character'Pos(Tab_texte.Elements(i)) = Tab_Huff.Elements(j).char then
                    Pile := Tab_Huff.Elements(j).binaire;
                    for k in 1..Pile_Caractere.Taille(Tab_Huff.Elements(j).binaire) loop
                        Tableau.Elements(Tableau.Nb_Elements) := (Pile_Caractere.Sommet(Pile));
                        Pile_Caractere.Depiler(Pile);
                        Tableau.Nb_Elements := Tableau.Nb_Elements + 1;
                    end loop;
                end if;
            end loop;
        end loop;
        for i in 1..Tab_Huff.Nb_Elements loop
            if Tab_Huff.Elements(i).char = -1 then
                Pile := Tab_Huff.Elements(i).binaire;
                for k in 1..Pile_Caractere.Taille(Tab_Huff.Elements(i).binaire) loop
                    Tableau.Elements(Tableau.Nb_Elements) := (Pile_Caractere.Sommet(Pile));
                    Pile_Caractere.Depiler(Pile);
                    Tableau.Nb_Elements := Tableau.Nb_Elements + 1;
                end loop;
            end if;
        end loop;
        Tableau.Nb_Elements := Tableau.Nb_Elements-1;
        Put("Tableau binaire du texte : "); New_line;
        Afficher_Tab_symbole(Tableau);
        New_line;
        New_line;
        reste := Tableau.Nb_Elements mod 8;
        if  reste /= 0 then
            for i in 1..reste loop
                Tableau.Elements(Tableau.Nb_Elements) := '0';
                Tableau.Nb_Elements := Tableau.Nb_Elements+1;
            end loop;
        end if;
        Tableau_2 := Transformer_Tab_binaire_octet(Tableau);
        Create (File, Out_File, File_Name);
        S := Stream (File);
        for i in 1..Tableau_2.Nb_Elements loop
            T_Octet'Write(S,T_Octet(Tableau_2.Elements(i)));
        end loop;
        Afficher_Tab(Tableau_2);
        close(File);
    end ecriture;

    procedure lecture(Tab_Texte : out T_Tab_symbole; Tab_octet : out T_Tab; Tab_arbre : out T_Tab_symbole; File_Name : in String) is
        S         : Stream_Access;
        Octet     : T_Octet;
        Tab_recep_octet : T_Tab;
        cpt : Integer;
        Tab_recep_symbole : T_Tab_symbole;
        compteur_1 : Integer;
        Tab_Symbole : T_Tab_symbole;
    begin
        Tab_Texte.Nb_Elements := 0;
        Tab_arbre.Nb_Elements := 0;
        Tab_Symbole.Nb_Elements := 0;
        Tab_octet.Nb_Elements := 0;
        Tab_recep_octet.Nb_Elements := 0;
        Open(File, In_File, File_Name);
        S := Stream(File);

        while not End_Of_File(File) loop
            Octet := T_Octet'Input(S);
            Tab_recep_octet.Elements(Tab_recep_octet.Nb_Elements+1) := Integer'Value(T_Octet'Image(Octet));
            Tab_recep_octet.Nb_Elements := Tab_recep_octet.Nb_Elements + 1;
        end loop;

        cpt := 1;
        while Tab_recep_octet.Elements(cpt) /= Tab_recep_octet.Elements(cpt+1) loop
            Tab_octet.Elements(cpt) := Tab_recep_octet.Elements(cpt);
            Tab_octet.Nb_Elements := Tab_octet.Nb_Elements + 1;
            cpt := cpt+1;
        end loop;
        Tab_octet.Elements(cpt) := Tab_recep_octet.Elements(cpt);
        Tab_octet.Nb_Elements := Tab_octet.Nb_Elements + 1;
        Tab_recep_symbole := Construire_Liste_octet_fichier(Tab_recep_octet);

        for i in 1..(Tab_recep_octet.Nb_Elements-Tab_octet.Nb_Elements-1)*8 loop
            Tab_Symbole.Elements(Tab_Symbole.Nb_Elements+1) := Tab_recep_symbole.Elements(i+(Tab_octet.Nb_Elements+1)*8);
            Tab_Symbole.Nb_Elements := Tab_Symbole.Nb_Elements + 1;
        end loop;

        compteur_1 := 1;
        while compteur_1 /= Tab_octet.Nb_Elements loop
            Tab_arbre.Elements(Tab_arbre.Nb_Elements+1) := Tab_Symbole.Elements(Tab_arbre.Nb_Elements+1);
            if Tab_Symbole.Elements(Tab_arbre.Nb_Elements+1) = '1' then
                compteur_1 := compteur_1 + 1;
            end if;
            Tab_arbre.Nb_Elements := Tab_arbre.Nb_Elements +1;
        end loop;

        for i in Tab_arbre.Nb_Elements+1..Tab_Symbole.Nb_Elements loop
            Tab_Texte.Elements(Tab_Texte.Nb_Elements+1) := Tab_Symbole.Elements(i);
            Tab_Texte.Nb_Elements := Tab_Texte.Nb_Elements +1;
        end loop;
        Close(File);
    end lecture;

    procedure ecriture_decompress(texte : T_Tab_symbole; File_Name : String) is
        S  : Stream_Access;
    begin
        Create (File, Out_File, File_Name);
        S := Stream(File);
        for i in 1..texte.Nb_Elements loop
            T_Octet'Write(S,T_Octet(Character'Pos(texte.Elements(i))));
        end loop;
        Close (File);
    end ecriture_decompress;
end openfile;
