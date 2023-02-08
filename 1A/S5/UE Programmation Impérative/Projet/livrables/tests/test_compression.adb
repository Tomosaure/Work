with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;
with Openfile; use Openfile;
with compression; use compression;
with Arbre; use Arbre;
with Tableau; use Tableau;

procedure test_compression is

    File_Name: String :=  "exemple_fichier.out";
    Tab_text: T_Tab_symbole;
    Tab_Freq: T_Tab;
    Tab_Freq_copie: T_Tab;
    Nombre_Symbole: Integer;
    Tab_Huff: T_Tab_Huff;
    Arbre_Huff: T_Arbre;
    Liste_octet: T_Tab;
    Liste_octet_compress: T_Tab;
    Liste_binaire: T_Tab_symbole;
    trouve_0: boolean := False;
    trouve_octet: boolean := False;
    Tableau_binaire: T_Tab_symbole;
    Tableau_octet: T_Tab;
begin
    Liste_binaire.Nb_Elements := 0;
    Liste_octet.Nb_Elements := 0;
    Tab_text := Stockage(File_Name);
    Tab_Freq := Tab_Frequence(Tab_text);
    Nombre_Symbole := Nb_Symbole(Tab_Freq);

    Put("Arbre de Huffman : ");
    New_Line;
    Arbre_Huff := Construire_Arbre_Huff(Tab_Freq);
    Afficher(Arbre_Huff, -1, "test"); New_line;

    Tab_freq_copie := Tab_Freq;
    Put("Liste octet : ");
    New_line;
    Construire_Liste_octet(Arbre_Huff, Tab_Freq_copie, Liste_octet);
    Afficher_Tab(Liste_octet); New_line;
    New_Line;

    Put("Liste binaire : ");
    New_Line;
    Construire_Liste_binaire(Arbre_Huff, Liste_binaire);
    Afficher_Tab_symbole(Liste_binaire);
    New_Line;
    New_Line;

    Put("Liste binaire du fichier compressé : ");
    New_Line;
    Liste_octet_compress := Construire_Liste_octet_compress(Liste_octet);
    Afficher_Tab(Liste_octet_compress);
    New_Line;
    New_Line;

    Put("Table de Huffman : "); New_line;
    Tab_Huff := Construire_Tab_Huff(Liste_binaire, Liste_octet, Nombre_Symbole);
    Afficher_Tab_Huff(Tab_Huff);
    New_Line;
    New_Line;

    Put("Table de Huffman inversé: "); New_line;
    Construire_Arbre_Huff_Inverse(Tab_Huff);
    Afficher_Tab_Huff(Tab_Huff);
    New_Line;
    New_Line;

    Put("Tableau binaire pour le fichier: ");
    New_Line;
    Tableau_binaire := Construire_Liste_octet_fichier(Liste_octet_compress);
    Afficher_Tab_symbole(Tableau_binaire);
    New_Line;
    New_Line;

    Put("Tableau d'octet du précédent tableau : ");
    New_Line;
    Tableau_octet := Transformer_Tab_binaire_octet(Tableau_binaire);
    Afficher_Tab(Tableau_octet);
    New_Line;

    ecriture(Tab_Huff, Liste_binaire, Tab_text, Liste_octet_compress);
end test_compression;
