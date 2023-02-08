with LCA;
generic
    Capacite : Integer;
	type T_Cle is private;
	type T_Donnee is private;
    with function Hachage(Cle : in T_Cle) return Integer; --fonction de hachage sur la taille de la clé

package TH is

	type T_TH is limited private;

	-- Initialiser une Sda.  La Sda est vide.
	procedure Initialiser_TH(Sda: out T_TH) with
		Post => Est_Vide_TH(Sda);


	-- Est-ce qu'une Sda est vide ?
	function Est_Vide_TH (Sda : T_TH) return Boolean;


	-- Obtenir le nombre d'éléments d'une Sda.
	function Taille_TH (Sda : in T_TH) return Integer with
		Post => Taille_TH'Result >= 0
			and (Taille_TH'Result = 0) = Est_Vide_TH (Sda);


	-- Enregistrer une Donnée associée à une Clé dans une Sda.
	-- Si la clé est déjà présente dans la Sda, sa donnée est changée.
	procedure Enregistrer_TH (Sda : in out T_TH ; Cle : in T_Cle ; Donnee : in T_Donnee) with
		Post => Cle_Presente_TH (Sda, Cle) and (La_Donnee_TH (Sda, Cle) = Donnee)   -- donnée insérée
				and (not (Cle_Presente_TH (Sda, Cle)'Old) or Taille_TH (Sda) = Taille_TH (Sda)'Old)
				and (Cle_Presente_TH (Sda, Cle)'Old or Taille_TH (Sda) = Taille_TH (Sda)'Old + 1);

	-- Supprimer la Donnée associée à une Clé dans une Sda.
	-- Exception : Cle_Absente_Exception si Clé n'est pas utilisée dans la Sda
	procedure Supprimer_TH (Sda : in out T_TH ; Cle : in T_Cle) with
		Post =>  Taille_TH (Sda) = Taille_TH (Sda)'Old - 1 -- un élément de moins
			and not Cle_Presente_TH (Sda, Cle);         -- la clé a été supprimée


	-- Savoir si une Clé est présente dans une Sda.
    function Cle_Presente_TH (Sda : in T_TH ; Cle : in T_Cle) return Boolean;


	-- Obtenir la donnée associée à une Cle dans la Sda.
	-- Exception : Cle_Absente_Exception si Clé n'est pas utilisée dans l'Sda
	function La_Donnee_TH (Sda : in T_TH ; Cle : in T_Cle) return T_Donnee;


	-- Supprimer tous les éléments d'une Sda.
	procedure Vider_TH (Sda : in out T_TH) with
		Post => Est_Vide_TH(Sda);


	-- Appliquer un traitement (Traiter) pour chaque couple d'une Sda.
      generic
		with procedure Traiter (Cle : in T_Cle; Donnee: in T_Donnee);
      procedure Pour_Chaque_TH(Sda : in T_TH);

private
package LCA_new is new LCA (T_Cle, T_Donnee);
    use LCA_new;
    type T_TH is array (1..Capacite) of T_LCA;


end TH;
