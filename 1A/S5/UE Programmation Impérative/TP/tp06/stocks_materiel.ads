
-- Auteur: 
-- Gérer un stock de matériel informatique.

package Stocks_Materiel is


    CAPACITE : constant Integer := 10;      -- nombre maximum de matériels dans un stock

    type T_Nature is (UNITE_CENTRALE, DISQUE, ECRAN, CLAVIER, IMPRIMANTE);
    type T_Etat is (FONCTIONNEMENT, DEFECTUEUX)
    type T_Element is private;
    type T_Stock is limited private;
    

    -- Créer un stock vide.
    --
    -- paramètres
    --     Stock : le stock à créer
    --
    -- Assure
    --     Nb_Materiels (Stock) = 0
    --
    procedure Creer (Stock : out T_Stock) with
        Post => Nb_Materiels (Stock) = 0;


    -- Obtenir le nombre de matériels dans le stock Stock.
    --
    -- Paramètres
    --    Stock : le stock dont ont veut obtenir la taille
    --
    -- Nécessite
    --     Vrai
    --
    -- Assure
    --     Résultat >= 0 Et Résultat <= CAPACITE
    --
    function Nb_Materiels (Stock: in T_Stock) return Integer with
        Post => Nb_Materiels'Result >= 0 and Nb_Materiels'Result <= CAPACITE;


    -- Enregistrer un nouveau métériel dans le stock.  Il est en
    -- fonctionnement.  Le stock ne doit pas être plein.
    -- 
    -- Paramètres
    --    Stock : le stock à compléter
    --    Numero_Serie : le numéro de série du nouveau matériel
    --    Nature       : la nature du nouveau matériel
    --    Annee_Achat  : l'année d'achat du nouveau matériel
    -- 
    -- Nécessite
    --    Nb_Materiels (Stock) < CAPACITE
    -- 
    -- Assure
    --    Nouveau matériel ajouté
    --    Nb_Materiels (Stock) = Nb_Materiels (Stock)'Avant + 1
    procedure Enregistrer (
            Stock        : in out T_Stock;
            Numero_Serie : in     Integer;
            Nature       : in     T_Nature;
            Annee_Achat  : in     Integer
        ) with
            Pre => Nb_Materiels (Stock) < CAPACITE,
            Post => Nb_Materiels (Stock) = Nb_Materiels (Stock)'Old + 1;
    
    -- Obtenir le nombre de matériels qui sont défectueux 
    -- Paramètres : Stock : le stock de matériel 
    -- Type retour : Un entier indiquant le nombre de matériels défectueux
    -- Necessite : Nb_Materiels(Stock) /= 0
    -- Assure : Resultat = Nb_fonctionnement(Stock)
    function Nb_fonctionnement  (Stock : in T_Stock) return Integer with
            Pre => Nb_Materiels(Stock) /= 0;
    
    
    --Mets à jour l'état du matériel à partir de son numéro de série
    --Paramètres : Stock, Numero_Serie
    --Necessite :
    procedure maj (Stock : in out T_Stock, Numero_Serie : in Integer) with;
            
    --Supprime un matériel du stock à partir de son numéro de série
    --Paramètres : Stock, Numero_Serie
    --Necessite :
    procedure supr (Stock : in out T_Stock, Numero_Serie : in Integer) with;
    
    --Affiche tous les matériels du stock 
    --Paramètre : Stock
    -- Nécéssite : Nb_Materiels (Stock) /= 0
    procedure affichage (Stock : in T_Stock) with
            Pre => Nb_Materiels(Stocks) /=0;
    
    --Supprimer tous les matériels qui ne sont pas en état de fonctionnement
    --Paramètres : Stock 
    --Néccéssite: Nb_Materiels (Stock) /= 0
    procedure supr_defectueux (Stock : in T_Stock) with
            Pre => Nb_Materiels(Stocks) /=0;
    
private 
    
    Type T_Stock is 
        record
            Tableau : T_tableau
            Nb_Elements : Integer
        end record;
        
    Type T_tableau is array (1..CAPACITE) of T_Element;
    Type T_Element is
        record
            Numero_Serie : Integer;
            Nature : T_nature;
            Anne_Achat : Integer;
            Etat : T_Etat;
        end record;
    
   
            
    
    
    
    
    
    
end Stocks_Materiel;
