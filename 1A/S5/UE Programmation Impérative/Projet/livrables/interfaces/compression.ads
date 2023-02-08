with Piles;
with Arbre; use Arbre;
with LCA_projet;
with Tableau; use Tableau;

package compression is

    -- Construire le tableau de Huffman
    function Construire_Tab_Huff(Tab_binaire : in T_Tab_symbole; Tab_octet : in T_Tab; Nb_symbole : in Integer) return  T_Tab_Huff;

    -- Construire l'arbre de Huffman
    function Construire_Arbre_Huff(Tab_freq : in T_Tab) return T_Arbre;

    -- Créer la liste des symboles en tant qu'octet par parcours infixe
    procedure Construire_Liste_octet(Arbre: in T_Arbre; Tab_freq : in out T_Tab; Tab_octet: in out T_Tab);

    -- Créer l'arbre représentation binaire par parcours infixe
    procedure Construire_Liste_binaire(Arbre : in T_Arbre; Tab_binaire: in out T_Tab_symbole);

    -- Créer la liste des symboles pour le fichier compressé
    function Construire_Liste_octet_compress (Tab_octet: in T_Tab) return T_Tab;

    -- Inverser les piles, élements du tableau T_Tab_Huff
    procedure Construire_Arbre_Huff_Inverse (Tab_Huff: in out T_Tab_Huff);

    -- Créer une liste de '0' et de '1' correspondant à la liste des sympboles en tant qu'octet
    function Construire_Liste_octet_fichier (Tab_octet_compress : in T_Tab) return T_Tab_symbole;

    -- Découper le tableau en paquet de 8 et transformer en octet
    function Transformer_Tab_binaire_octet (Tab: in T_Tab_symbole) return T_Tab;
end compression;
