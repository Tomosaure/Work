
-- Définition de structures de données associatives sous forme d'une liste
-- chaînée associative (LCA)
-- On reprend le package LCA du mini projet en modifiant la fonction supprimer car seul la supression du 
-- premier élément nous intéresse et on modifie supprimer qui n'effectue plus exactement les même actions
generic
	type T_Donnee is private;

package LCA_projet is

	type T_LCA is limited private;

	-- Initialiser une Sda.  La Sda est vide.
	procedure Initialiser(Sda: out T_LCA) with
		Post => Est_Vide (Sda);


	-- Est-ce qu'une Sda est vide ?
	function Est_Vide (Sda : T_LCA) return Boolean;


	-- Obtenir le nombre d'éléments d'une Sda. 
	function Taille (Sda : in T_LCA) return Integer with
		Post => Taille'Result >= 0
			and (Taille'Result = 0) = Est_Vide (Sda);


	-- Enregistrer une Donnée associée à une Clé dans une Sda.
	-- Si la clé est déjà présente dans la Sda, sa donnée est changée.
	procedure Enregistrer (Sda : in out T_LCA ; Cle : in Integer ; Donnee : in T_Donnee) with
		Post => Cle_Presente (Sda, Cle) and (La_Donnee (Sda, Cle) = Donnee)   -- donnée insérée
				and (not (Cle_Presente (Sda, Cle)'Old) or Taille (Sda) = Taille (Sda)'Old)
				and (Cle_Presente (Sda, Cle)'Old or Taille (Sda) = Taille (Sda)'Old + 1);

	-- Supprimer la Donnée associée à une Clé dans une Sda.
	-- Exception : Cle_Absente_Exception si Clé n'est pas utilisée dans la Sda
	procedure Supprimer_Premier (Sda : in out T_LCA) with
		Post =>  Taille (Sda) = Taille (Sda)'Old - 1; -- un élément de moins


	-- Savoir si une Clé est présente dans une Sda.
	function Cle_Presente (Sda : in T_LCA ; Cle : in Integer) return Boolean;

    -- Renvoie le 1er élément d'une Sda
    function Premier (Sda : in T_LCA) return T_Donnee;
    
     -- Renvoie le 2ème élément d'une Sda
    function Deuxieme (Sda : in T_LCA) return T_Donnee;
    
	-- Obtenir la donnée associée à une Cle dans la Sda.
	-- Exception : Cle_Absente_Exception si Clé n'est pas utilisée dans l'Sda
	function La_Donnee (Sda : in T_LCA ; Cle : in Integer) return T_Donnee;


	-- Supprimer tous les éléments d'une Sda.
	procedure Vider (Sda : in out T_LCA) with
		Post => Est_Vide (Sda);
    
    -- Affiche les clés de la Sda
    procedure Afficher (Sda: in T_LCA);

private

	type T_Cellule; -- Cellule de la liste

	type T_LCA is access T_Cellule;   -- Le pointeur sur T_Cellule

	type T_Cellule is
		record
			Cle : Integer;      -- Une clé  
			Donnee : T_Donnee;  -- L'élément générique contenu dans la cellule 
			Suivant : T_LCA;    -- La cellule suivante
		end record;

end LCA_projet;
