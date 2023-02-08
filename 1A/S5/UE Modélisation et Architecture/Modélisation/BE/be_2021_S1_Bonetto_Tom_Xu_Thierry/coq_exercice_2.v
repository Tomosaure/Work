Require Import Naturelle.
Section Session1_2021_Logique_Exercice_2.

Variable A B C : Prop.





Theorem Exercice_2_Coq : ((A /\ B) -> C) -> ((A -> C) \/ (B -> C)).
Proof.
intros.
left.
intros.
cut (A/\B).
Hyp H.
split.
Hyp H0.

elim H0.

Qed.

Theorem Exercice_2_Naturelle : ((A /\ B) -> C) -> ((A -> C) \/ (B -> C)).
Proof.
I_imp H.
I_ou_d.
I_imp H1.
E_ou A (~A).
TE.
I_imp H2.
E_imp (A/\B).
Hyp H.
I_et.
Hyp H2.
Hyp H1.
absurde H.
I_imp H2.
E_imp (A/\B).
Hyp H.
I_et.

E_ou (A/\B) (~(A/\B)).
Qed.


End Session1_2021_Logique_Exercice_2.