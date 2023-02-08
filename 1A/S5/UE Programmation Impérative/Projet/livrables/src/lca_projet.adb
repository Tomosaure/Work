with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with SDA_Exceptions;         use SDA_Exceptions;
with Ada.Unchecked_Deallocation;

package body LCA_projet is

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


    procedure Enregistrer (Sda : in out T_LCA ; Cle : in Integer ; Donnee : in T_Donnee) is
        courant, copie, noeud: T_LCA;
        a : Boolean;
    begin
        a := False;
        noeud := new T_Cellule'(Cle,Donnee,Null);
        courant :=Sda;
        if Sda = Null then
            Sda := noeud;
        else
            if Sda.all.Cle >= Cle then
                noeud.all.Suivant := Sda;
                Sda := noeud;
            else
                while courant.all.Suivant /= Null and not a loop
                    if courant.all.Suivant.Cle <= Cle then
                        courant := courant.all.Suivant;
                    else
                        copie := courant.all.Suivant;
                        courant.all.Suivant := noeud;
                        courant.all.Suivant.Suivant := copie;
                        a := True;
                    end if;
                end loop;
                if not a then
                    courant.all.Suivant := noeud;
                end if;
            end if;
        end if;
    end Enregistrer;

    function Premier (Sda : in T_LCA) return T_Donnee is
    begin
        return Sda.all.Donnee;
    end Premier;


    function Deuxieme (Sda : in T_LCA) return T_Donnee is
    begin
        return Premier(Sda.all.Suivant);
    end Deuxieme;


	function Cle_Presente (Sda : in T_LCA ; Cle : in Integer) return Boolean is
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


	function La_Donnee (Sda : in T_LCA ; Cle : in Integer) return T_Donnee is
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


     procedure Supprimer_Premier (Sda : in out T_LCA) is
     Detruire : T_LCA;
     begin
        if Sda = Null then
            raise Cle_Absente_Exception;
        else
            Detruire := Sda;
            Sda := Sda.all.Suivant;
            Free(Detruire);
        end if;
     end Supprimer_Premier;


	procedure Vider (Sda : in out T_LCA) is
	begin
        if Sda /= Null then
            Vider(Sda.all.Suivant);
		   Free(Sda);
	    else
		   Null;
        end if;
    end Vider;

    procedure Afficher(Sda: in T_LCA) is
        courant : T_LCA;
    begin
        if Sda = Null then
            Put("Sda vide");
        else
            courant := Sda;
            Put(" Sda : [ ");
            while courant.all.Suivant /= Null loop
                Put(courant.all.Cle,1);
                Put(" , ");
                courant := courant.all.Suivant;
            end loop;
            Put(courant.all.Cle,1);
            Put(" ]");
        end if;
    end Afficher;
end LCA_projet;
