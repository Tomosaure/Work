with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with SDA_Exceptions; 		use SDA_Exceptions;
with LCA_projet;

procedure Test_LCA_projet is

	package LCA_Integer is
		new LCA_projet (T_Donnee => Integer);
	use LCA_Integer;


	Nb_Cles : constant Integer := 7;
	Cles : constant array (1..Nb_Cles) of Integer
			:= (1, 2, 3, 4, 5, 10, 7);


	Donnees : constant array (1..Nb_Cles) of Integer
			:= (1, 2, 3, 4, 5, 10, 7);

	procedure Construire_Exemple_Sujet (Annuaire : out T_LCA) is
	begin
		Initialiser (Annuaire);
		pragma Assert (Est_Vide (Annuaire));
		pragma Assert (Taille (Annuaire) = 0);

		for I in 1..Nb_Cles loop
			Enregistrer(Annuaire, Cles (I), Donnees (I));
            Put("Après insertion de la clé : ");
            Put(Cles(I),1);
		    Afficher(Annuaire); New_Line;

            pragma Assert (not Est_Vide (Annuaire));
			pragma Assert (Taille (Annuaire) = I);

			for J in 1..I loop
                pragma Assert (La_Donnee (Annuaire, Cles (J)) = Donnees (J));
			end loop;

			for J in I+1..Nb_Cles loop
                pragma Assert (not Cle_Presente (Annuaire, Cles (J)));
			end loop;

		end loop;
	end Construire_Exemple_Sujet;   
    
    
	procedure Tester_Exemple_Sujet is
		Annuaire : T_LCA;
	begin
		Construire_Exemple_Sujet (Annuaire);
		Vider (Annuaire);
	end Tester_Exemple_Sujet;


	-- Tester suppression en commençant les les premiers éléments ajoutés
	procedure Tester_Supprimer_Premier is
		Annuaire, C : T_LCA;
	begin
		Put_Line ("=== Tester_Supprimer..."); New_Line;

		Construire_Exemple_Sujet (Annuaire);
		for I in 1..Nb_Cles loop
			Put_Line ("Suppression du 1er élément");
			Supprimer_Premier(Annuaire);
			Afficher (Annuaire); New_Line;
            pragma Assert (Taille(Annuaire) = Nb_Cles - I);
        end loop;
		Vider (Annuaire);
	end Tester_Supprimer_Premier;


	procedure Tester_Supprimer_Erreur is
		Annuaire : T_LCA;
	begin
		begin
			Put_Line ("=== Tester_Supprimer_Erreur..."); New_Line;

			Initialiser(Annuaire);
			Supprimer_Premier(Annuaire);

		exception
			when Cle_Absente_Exception =>
				Null;
			when others =>
				pragma Assert (False);
		end;
		Vider (Annuaire);
	end Tester_Supprimer_Erreur;


    
    procedure Tester_Premier_Deuxieme is
        Annuaire, C : T_LCA;
    begin 
        Construire_Exemple_Sujet(Annuaire);
        pragma Assert(Premier(Annuaire) = 1);
        pragma Assert(Deuxieme(Annuaire) = 2);
        Supprimer_Premier(Annuaire);
        Supprimer_Premier(Annuaire);
        pragma Assert(Premier(Annuaire) = 3);
        pragma Assert(Deuxieme(Annuaire) = 4);
        Vider(Annuaire);
    end Tester_Premier_Deuxieme;  

    


begin
    Tester_Exemple_Sujet;
    Put("ok"); New_line;
    Tester_Supprimer_Premier;
    Put("ok");
    Tester_Supprimer_Erreur;
    Put("ok");
    Tester_Premier_Deuxieme;
	Put_Line ("Fin des tests : OK.");
end Test_LCA_projet;
