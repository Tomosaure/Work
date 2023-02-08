with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;
with OpenFile; use OpenFile;
with Tableau; use Tableau;
with decompression; use decompression;
with compression; use compression;
with Arbre; use Arbre;

procedure test_decompression is
    Tab_Texte :T_Tab_symbole;
    Tab_octet :T_Tab;
    Tab_arbre : T_Tab_symbole;
    Tab_Huff: T_Tab_Huff;
    Arbre : T_Arbre;
    compteur : Integer := 1;
    pointeur1 : T_Arbre;
    pointeur2: T_Arbre;
    Texte: T_Tab_symbole;
begin
    lecture(Tab_Texte, Tab_octet, Tab_arbre);
    New_line; New_line;
    Afficher_Tab(Tab_octet);

    New_line;New_line;
    Afficher_Tab_symbole(Tab_arbre);

    New_line;New_line;
    Afficher_Tab_symbole(Tab_Texte);
    New_Line;
    New_Line;
    Reconstruire_Liste_octet(Tab_octet);
    Afficher_Tab(Tab_octet);
    New_Line;
    New_Line;
    Tab_Huff := Construire_Tab_Huff(Tab_arbre, Tab_octet, Tab_octet.Nb_Elements-1);
    Afficher_Tab_Huff(Tab_Huff);
    New_Line;
    New_Line;

    Put("Table de Huffman inversé : "); New_line;
    Construire_Arbre_Huff_Inverse(Tab_Huff);
    Afficher_Tab_Huff(Tab_Huff);

    Initialiser(Arbre,0);
    Reconstruire_Arbre_Huff(Tab_Huff, Arbre, compteur);
    New_line;
    New_line;
    Afficher(Arbre, -1, "test");
    New_line;
    New_line;


    Texte := Reconstruire_Tab_text_decompress(Tab_Texte, Arbre);
    Afficher_Tab_symbole(Texte);

    ecriture_decompress(Texte);
end test_decompression;
