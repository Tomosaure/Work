with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;
with OpenFile; use OpenFile;
with Tableau; use Tableau;
with decompression; use decompression;
with compression; use compression;
with Arbre; use Arbre;
with Ada.Command_Line;     use Ada.Command_Line;

procedure decompresser is
    File_Name : String := Argument(1);
    Tab_Texte :T_Tab_symbole;
    Tab_octet :T_Tab;
    Tab_arbre : T_Tab_symbole;
    Tab_Huff: T_Tab_Huff;
    Arbre : T_Arbre;
    compteur : Integer := 1;
    Texte: T_Tab_symbole;
begin
    lecture(Tab_Texte, Tab_octet, Tab_arbre,File_Name);
    Reconstruire_Liste_octet(Tab_octet);
    Tab_Huff := Construire_Tab_Huff(Tab_arbre, Tab_octet, Tab_octet.Nb_Elements-1);
    Construire_Tab_Huff_Inverse(Tab_Huff);
    Initialiser(Arbre,0);
    Reconstruire_Arbre_Huff(Tab_Huff, Arbre, compteur);
    Texte := Reconstruire_Tab_text_decompress(Tab_Texte, Arbre);
    ecriture_decompress(Texte,File_Name);
    Vider(Arbre);
end decompresser;
