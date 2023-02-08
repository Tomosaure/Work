with Piles;
with Arbre; use Arbre;
with LCA_projet;
with Tableau; use Tableau;

package decompression is

    -- Reconstruire la liste d'octet non modifié
    procedure Reconstruire_Liste_octet(Tab_octet : in out T_Tab);

    -- Reconstruire l'arbre de Huffman
    procedure Reconstruire_Arbre_Huff(Tab_Huff : in T_Tab_Huff; Arbre : in out T_Arbre; compteur: in out Integer);

    function Reconstruire_Tab_text_decompress(Tab_Text: T_Tab_symbole; Arbre: in T_Arbre) return T_Tab_symbole;
end decompression;
