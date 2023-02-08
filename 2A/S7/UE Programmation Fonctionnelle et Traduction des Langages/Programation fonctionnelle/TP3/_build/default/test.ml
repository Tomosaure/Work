let rec permutations l = match l with
  | [] -> [[]]
  | _ -> List.concat (List.map (fun x -> List.map (fun y -> x::y) (permutations (List.filter (fun y -> y <> x) l))) l);;

