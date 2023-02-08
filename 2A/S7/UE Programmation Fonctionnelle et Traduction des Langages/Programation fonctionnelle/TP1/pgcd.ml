(*  pgcd : int -> int -> int *)
(*  Renvoie le pgcd de deux entiers *)
(*  Paramètre a : le premier entier *)
(*  Paramètre b : le deuxieme entier *)
(*  Résultat : le pgcd de a et b *)
(*  Précondition : (a != 0 && b != 0) *)
(*  Grâce à la valeur absolue on enlève la précondition (a >= 0 && b >= 0) *)

let pgcd a b =
  let rec pgcd_positif a b =
    if a = b then a
    else if a > b then pgcd_positif (a - b) b
    else pgcd_positif a (b-a)
  and abs x = 
    if x < 0 then -x else x
  in match (a,b) with
    | (a,0) -> a
    | (0,b) -> b 
    | _ -> pgcd_positif (abs a) (abs b)

  let%test _ = pgcd 5 0 = 5
  let%test _ = pgcd 0 4 = 4
  let%test _ = pgcd 3 12 = 3 
  let%test _ = pgcd 24 16 = 8
  let%test _ = pgcd (-4) 6 = 2
  let%test _ = pgcd 7 (-2) = 1
  let%test _ = pgcd (-6) (-4) = 2