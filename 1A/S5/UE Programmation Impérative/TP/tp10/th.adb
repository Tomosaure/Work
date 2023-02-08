with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
package body TH is

	procedure Initialiser_TH(Sda:out T_TH) is
    begin
        for i in 1..Capacite loop
            Initialiser(Sda(i));
        end loop;
	end Initialiser_TH;


	function Est_Vide_TH(Sda : T_TH) return Boolean is
    begin
        for i in 1..Capacite loop
            if not Est_Vide(Sda(i)) then
                return False;
            end if;
        end loop;
        return True;
	end Est_Vide_TH;


     function Taille_TH (Sda : in T_TH) return Integer is
     taille_th : Integer;
     begin
        taille_th := 0;
        for i in 1..Capacite loop
                taille_th := taille_th + Taille(Sda(i));
        end loop;
     return taille_th;
    end Taille_TH;



    procedure Enregistrer_TH (Sda : in out T_TH ; Cle : in T_Cle ; Donnee : in T_Donnee) is
    indice : Integer;
    begin
        indice := Hachage(Cle) mod Capacite + 1;
        Enregistrer(Sda(indice), Cle, Donnee);
    end Enregistrer_TH;



	function Cle_Presente_TH (Sda : in T_TH ; Cle : in T_Cle) return Boolean is
    begin
        for i in 1..Capacite loop
            if Cle_Presente(Sda(i), Cle) then
                return True;
            end if;
        end loop;
    return False;
    end Cle_Presente_TH;


	function La_Donnee_TH(Sda : in T_TH ; Cle : in T_Cle) return T_Donnee is
    indice : Integer;
    begin
        indice := Hachage(Cle) mod Capacite + 1;
        return La_Donnee(Sda(indice), Cle);
	end La_Donnee_TH;


     procedure Supprimer_TH (Sda : in out T_TH ; Cle : in T_Cle) is
     indice : Integer;
     begin
        indice := Hachage(Cle) mod Capacite + 1;
        Supprimer(Sda(indice), Cle);
     end Supprimer_TH;


	procedure Vider_TH(Sda : in out T_TH) is
	begin
        for i in 1..Capacite loop
            Vider(Sda(i));
        end loop;
	end Vider_TH;

    procedure Pour_Chaque_TH(Sda : in T_TH) is

		procedure Afficher_Sda is
			new Pour_Chaque(Traiter);

    begin
        for i in 1..Capacite loop
            Put(i,1);
            Put(" --> ");
            if Est_Vide(Sda(i)) then
                Put("Null");
            else
                Afficher_Sda(Sda(i));
            end if;
			New_Line;
		end loop;
	end Pour_Chaque_TH;

end TH;
