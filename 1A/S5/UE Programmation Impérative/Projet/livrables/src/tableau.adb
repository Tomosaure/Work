with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;
with Piles;
package body Tableau is

    procedure Afficher_Pile is new Pile_Caractere.Afficher(Put);

    procedure Afficher_Tab_Huff(Tableau : in T_Tab_Huff) is
    begin
        Put ('[');
        if Tableau.Nb_Elements /= 0 then
            Put (" '");
            Put(Character'Val(Tableau.Elements(1).char));
            Put(''');
            Put("  --> ");
            Afficher_Pile(Tableau.Elements(1).binaire);
            for I in 2..Tableau.Nb_Elements loop
                New_line;
                Put("  ");
                if Tableau.Elements(I).char = -1 then
                    Put("'\$'");
                    Put(" --> ");
                    Afficher_Pile(Tableau.Elements(I).binaire);
                elsif Tableau.Elements(I).char = 10 then
                    Put("'\n'");
                    Put(" --> ");
                    Afficher_Pile(Tableau.Elements(I).binaire);
                else
                    Put(''');
                    Put(Character'Val(Tableau.Elements(I).char));
                    Put(''');
                    Put("  --> ");
                    Afficher_Pile(Tableau.Elements(I).binaire);
                end if;

            end loop;
        else
            Null;
        end if;
        Put (" ]");
    end Afficher_Tab_Huff;

    procedure Afficher_Tab(Tableau : in T_Tab) is
    begin
        Put ('[');
        if (Tableau.Nb_Elements /= 0) then
            Put (' ');
            Put(Tableau.Elements(1),1);
            for I in 2..Tableau.Nb_Elements loop
                Put (", ");
                Put(Tableau.Elements(I),1);
            end loop;
        else
            Null;
        end if;
        Put (" ]");
    end Afficher_Tab;

    procedure Afficher_Tab_symbole(Tableau : in T_Tab_symbole) is
    begin
        Put ('[');
        if (Tableau.Nb_Elements /= 0) then
            Put (' ');
            Put(Tableau.Elements(1));
            for i in 2..Tableau.Nb_Elements loop
                Put (", ");
                Put(Tableau.Elements(i));
            end loop;
        else
            Null;
        end if;
        Put (" ]");
    end Afficher_Tab_Symbole;
end Tableau;
