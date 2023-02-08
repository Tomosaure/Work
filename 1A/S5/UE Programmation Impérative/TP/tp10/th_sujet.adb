with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with TH;

procedure th_sujet  is

   package TH_String_Integer is
    new TH (T_Cle => Unbounded_String, T_Donnee => Integer, Capacite => 11, Hachage => Length);
   use TH_String_Integer;

   procedure Afficher(Cle: in Unbounded_String; Donnee: in Integer) is
   begin
		Put(To_String(Cle));
		Put(" : ");
        Put(Donnee,1);
        Put("   ");
   end Afficher;

  procedure Afficher_TH is
		new Pour_Chaque_TH(Afficher);

   Sda : T_TH;
begin
   Initialiser_TH(Sda);
   Enregistrer_TH(Sda, To_Unbounded_String("Un"), 1);
   Enregistrer_TH(Sda, To_Unbounded_String("Deux"), 2);
   Enregistrer_TH(Sda, To_Unbounded_String("Trois"), 3);
   Enregistrer_TH(Sda, To_Unbounded_String("Quatre"), 4);
   Enregistrer_TH(Sda, To_Unbounded_String("Cinq"), 5);
   Enregistrer_TH(Sda, To_Unbounded_String("Quatre-vingt-dix-neuf"), 99);
   Enregistrer_TH(Sda, To_Unbounded_String("Vingt-et-un"), 21);
   Afficher_TH(Sda);
   Vider_TH(Sda);
end th_Sujet;
