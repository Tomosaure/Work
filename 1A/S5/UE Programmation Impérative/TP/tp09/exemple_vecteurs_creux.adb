with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Vecteurs_Creux;    use Vecteurs_Creux;

-- Exemple d'utilisation des vecteurs creux.
procedure Exemple_Vecteurs_Creux is

	V : T_Vecteur_Creux;
	Epsilon: constant Float := 1.0e-5;
begin
    Put_Line ("Début du scénario");
    Initialiser(V);
    Afficher(V);
    Modifier(V,4,5.0);
    Modifier(V,2,1.0);
    Afficher(V);
    Put_Line ("Fin du scénario");
end Exemple_Vecteurs_Creux;
