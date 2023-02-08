with compression;    use compression;
with Tableau; use Tableau;
with Ada.Text_IO; use Ada.Text_IO;

package OpenFile is

    procedure Afficher_Pile is new Pile_Caractere.Afficher(Put);
    type T_Octet is mod 2 ** 8;	-- sur 8 bits
    for T_Octet'Size use 8;

    --Ouvre le fichier contenant le texte à compresser et stock le texte dans un tableau
    function Stockage(File_Name : in String) return T_Tab_symbole;

    --Créer un tableau de taille 256 qui contient la fréquence de chaque symbole
    --présent dans le texte rangé à l'index correspondant à leur code ASCII
    function Tab_Frequence(Tab_Texte : in T_Tab_symbole) return T_Tab;

    --Retourne le nombre de symbole différent dans le texte
    function Nb_Symbole(Tab_Freq : in T_Tab) return Integer;

    function Tab_Symbole(Tab_Texte : in T_Tab_symbole; Nb_Symbole : Integer) return T_Tab_symbole;

    procedure ecriture(Tab_Huff : in T_Tab_Huff; Liste_binaire : in T_Tab_symbole; Tab_texte : in T_Tab_symbole; Tab_octet_compress : in T_tab);

    procedure lecture(Tab_Texte : out T_Tab_symbole; Tab_octet : out T_Tab; Tab_arbre :out T_Tab_symbole);

    procedure ecriture_decompress(texte : T_Tab_symbole);
end OpenFile;
