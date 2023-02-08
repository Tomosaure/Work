with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
	--! Les Unbounded_String ont une capacité variable, contrairement au String
	--! pour lesquelles une capacité doit être fixée.
with LCA;
with SDA_Exceptions; use SDA_Exceptions;

procedure lca_sujet is

	package LCA_String_Integer is
		new LCA (T_Cle => Unbounded_String, T_Donnee => Integer);
	use LCA_String_Integer;
    Sda : T_LCA;
    procedure Traiter (Cle : in Unbounded_String; Donnee : in Integer) is

        procedure Afficher_Cle(Cle : in Unbounded_String) is
        begin
            Put(To_String(CLe));
            Put(" : ");
        end Afficher_Cle;

        procedure Afficher_Donnee(Donnee : in Integer) is
        begin
            Put(Donnee,1);
            New_line;
        end Afficher_Donnee;

    begin
        Afficher_Cle(Cle);
        Afficher_Donnee(Donnee);
    end Traiter;

procedure Afficher is new Pour_Chaque(Traiter);
begin
    Initialiser(Sda);
    Enregistrer(Sda, To_Unbounded_String ("un"),1);
    Enregistrer(Sda, To_Unbounded_String ("deux"),2);
    Afficher(Sda);
    Vider(Sda);
exception
    when Cle_Absente_Exception => Put_Line("Clé absente");
end lca_sujet;

