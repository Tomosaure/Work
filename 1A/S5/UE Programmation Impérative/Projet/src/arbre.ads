
-- Définition de structures de données associatives sous forme d'un arbre
-- Arbre binaire.


package Arbre is

    type T_Arbre is private;

    -- Créer un noeud avec une fréquence donnée
    procedure Initialiser(Arbre : out T_Arbre; Frequence : in Integer) with
            Post => Est_Vide(Arbre_Gauche(Arbre)) and Est_Vide(Arbre_Droit(Arbre));

    -- Est-ce qu'un arbre est vide ?
    function Est_Vide(Arbre : in T_Arbre) return Boolean;

    -- Est-ce qu'un noeud est une feuille?
    function Est_Feuille(Arbre : in T_Arbre) return Boolean;

    -- Sous arbre gauche de Arbre
    function Arbre_Gauche(Arbre: in T_Arbre) return T_Arbre with
            Pre => not Est_Vide(Arbre);


    -- Sous arbre droite de Arbre
    function Arbre_Droit(Arbre: in T_Arbre) return T_Arbre with
            Pre => not Est_Vide(Arbre);


    -- Retourne la fréquence du noeud de l'arbre
    function Frequence(Arbre: in T_Arbre) return Integer;


    -- Retourne le nombre de noeud dans l'arbre
    function Taille(Arbre : in T_Arbre) return Integer;


    --fusion de deux sous arbres en un arbre principal
    function Fusion(Arbre1: in T_Arbre ; Arbre2: in T_Arbre) return T_Arbre with
            Post => Frequence(Fusion'Result) = Frequence(Arbre1)+Frequence(Arbre2)
            and Arbre_Gauche(Fusion'Result) = Arbre1 and Arbre_Droit(Fusion'Result) = Arbre2;

    -- Modifier la fréquence d'un noeud
    procedure Modifier_Frequence(Arbre: in out T_Arbre; freq: in Integer);

    -- Créer une cellule à gauche et enregistre freq
    procedure Enregistrer_Gauche(Arbre: in out T_Arbre;freq: in Integer);

    -- Créer une cellule à droite et enregistre freq
    procedure Enregistrer_Droit(Arbre: in out T_Arbre ; freq: in Integer);

    -- Afficher l'arbre de Huffman
    procedure Afficher(Arbre : in T_Arbre; decalage : Integer; direction : String);

    -- Vide l'arbre
    procedure Vider(Arbre : in out T_Arbre) with
            Post => Est_Vide (Arbre);

private

    type T_Noeud;  -- Noeud d'un arbre

    type T_Arbre is access T_Noeud; -- Le pointeur sur T_Noeud

    type T_Noeud is record
        Frequence: Integer; -- Fréquence de l'arbre
        Gauche: T_Arbre;    -- Sous arbre gauche
        Droite: T_Arbre;    -- Sous arbre droit
    end record;



end Arbre;
