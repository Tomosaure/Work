with Ada.Text_IO;               use Ada.Text_IO;
with Ada.Integer_Text_IO;       use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;     use Ada.Strings.Unbounded;
with  Ada.Text_IO.Unbounded_IO; use  Ada.Text_IO.Unbounded_IO;

-- Exemple d'utilisation des Unbonded_String
procedure Exemple_Unbounded_String is
    Chaine: Unbounded_String;
    a : Unbounded_String;
begin
	-- Intialiser une Unbounded_String à partir d'une String
	Chaine := To_Unbounded_String ("Exemple");
     a := To_Unbounded_String("abc");
    -- Afficher une Unbounded_String
	Put_Line ("La chaine est : "  & Chaine);	--! & concaténation des chaînes

	-- Longueur d'une Unbounded_String
	Put ("Sa longueur est : ");
	Put (Length (Chaine), 1);
	New_Line;

	-- L'initiale de la chaîne
	Put_Line ("Son initiale est " & To_String (Chaine) (2));

	-- Ajouter une chaîne à la fin d'une Unbounded_String
	Append (Chaine, " final");
	Put_Line ("La chaine après concaténation est : "  & Chaine);

	-- Lire au clavier une Unbounded_String
	--Put ("Donner une chaîne : ");
	--Chaine := Get_Line;
    --Put_Line ("La chaine lu est  : "  & Chaine);
    if To_String (a) (1) < To_String (Chaine) (1) then
        Put("ok");
    else
        Put("n");
    end if;
end Exemple_Unbounded_String;
