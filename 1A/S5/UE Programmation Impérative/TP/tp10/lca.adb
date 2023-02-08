--with Ada.Text_IO;            use Ada.Text_IO;
with SDA_Exceptions;         use SDA_Exceptions;
with Ada.Unchecked_Deallocation;

package body LCA is

	procedure Free is
            new Ada.Unchecked_Deallocation (Object => T_Cellule	, Name => T_LCA);


	procedure Initialiser(Sda: out T_LCA) is
	begin
		Sda := null;
	end Initialiser;


	function Est_Vide (Sda : T_LCA) return Boolean is
	begin
		return Sda = Null;
	end Est_Vide;


     function Taille (Sda : in T_LCA) return Integer is
     begin
        if Sda = Null then
            return 0;
        else
            return 1 + Taille(Sda.all.Suivant);
        end if;
	end Taille;

    -- Modifie la donnée de la clé si déja exisitante, dans le cas échéant rajoute la nouvelle clé et sa donnée à la fin de la Sda
    procedure Enregistrer (Sda : in out T_LCA ; Cle : in T_Cle ; Donnee : in T_Donnee) is
        courant, noeud: T_LCA;
    begin
        noeud := new T_Cellule'(Cle,Donnee,Null);
        if Sda = Null then
            Sda := noeud;

        else
            courant := Sda;
            while courant /= Null loop
                if courant.all.Cle = Cle then
                    courant.all.Donnee := Donnee;
                    courant := Null;
                else
                    if courant.all.Suivant = Null then
                        courant.all.Suivant := noeud;
                        courant := Null;
                    else
                        courant := courant.all.Suivant;
                    end if;
                end if;
            end loop;
        end if;

    end Enregistrer;



	function Cle_Presente (Sda : in T_LCA ; Cle : in T_Cle) return Boolean is
    begin
        if Sda = Null then
            return False;
        else
            if Sda.all.Cle = Cle then
                return True;
            else
                return Cle_Presente(Sda.all.Suivant, Cle);
            end if;
        end if;
    end Cle_Presente;


	function La_Donnee (Sda : in T_LCA ; Cle : in T_Cle) return T_Donnee is
    begin
        if Sda = Null then
            raise Cle_Absente_Exception;
        else
            if Sda.all.Cle = Cle then
                return Sda.all.Donnee;
            else
                return La_Donnee(Sda.all.Suivant, Cle);
                end if;
        end if;
	end La_Donnee;


     procedure Supprimer (Sda : in out T_LCA ; Cle : in T_Cle) is
     Detruire : T_LCA;
     begin
        if Sda = Null then
            raise Cle_Absente_Exception;
        elsif Sda.all.Cle = Cle then
            Detruire := Sda;
            Sda := Sda.all.Suivant;
            Free(Detruire);
        else
            Supprimer(Sda.all.Suivant, Cle);
        end if;
     end Supprimer;


	procedure Vider (Sda : in out T_LCA) is
	begin
        if Sda /= Null then
            Vider(Sda.all.Suivant);
		   Free(Sda);
	    else
		   Null;
        end if;
	end Vider;

     procedure Pour_Chaque(Sda : T_LCA) is
     begin
        if Sda = Null then
            Null;
        else
            Traiter(Sda.all.Cle, Sda.all.Donnee);
            Pour_Chaque(Sda.all.Suivant);
        end if;

    exception
        when others =>
            Pour_Chaque(Sda.all.Suivant);
    end Pour_Chaque;

end LCA;
