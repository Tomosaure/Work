with Piles;

package Tableau is

    package Pile_Caractere is
            new Piles (Capacite => 257, T_Element => Character);
    use Pile_Caractere;

    type T_Tab_character is array(1..50000) of character;

    type T_Tab_symbole is record
        Elements : T_Tab_character; -- les éléments du tableau
        Nb_Elements : Integer;      -- Nombre d'éléments dans le tableau
    end record;

    type T_Tab_integer is array (1..50000) of Integer;

    type T_Tab is record
        Elements : T_Tab_integer;  -- les éléments du tableau
        Nb_Elements : Integer;     -- Nombre d'éléments dans le tableau
    end record;

    type T_char is
        record
            char: Integer;
            binaire: T_Pile;
        end record;

    type T_Tab_Huff_char is array(1..257) of T_char;

    type T_Tab_Huff is record
        Elements : T_Tab_Huff_char;  -- les éléments du tableau (T_char)
        Nb_Elements : Integer;       -- Nombre d'éléments dans le tableau
    end record;

    procedure Afficher_Tab_Huff(Tableau : in T_Tab_Huff);
    procedure Afficher_Tab(Tableau : in T_Tab);
    procedure Afficher_Tab_symbole(Tableau : in T_Tab_symbole);

end Tableau;
