
generic
	type T_Donnee;
    type T_Tableau_Generique;

package Tableau is


    function Est_Vide (Tableau : in T_Tableau_Generique) return Boolean;


	generic
		with procedure Afficher_Element (Donnee: in T_Donnee);
	procedure Afficher_Tab (Tableau : T_Tableau_Generique);


end Tableau;
