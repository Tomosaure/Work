(* This file is generated by Why3's Coq driver *)
(* Beware! Only edit allowed sections below    *)
Require Import BuiltIn.
Require BuiltIn.
Require int.Int.

(* Why3 assumption *)
Inductive ref (a:Type) :=
  | mk_ref : a -> ref a.
Axiom ref_WhyType : forall (a:Type) {a_WT:WhyType a}, WhyType (ref a).
Existing Instance ref_WhyType.
Arguments mk_ref {a}.

(* Why3 assumption *)
Definition contents {a:Type} {a_WT:WhyType a} (v:ref a) : a :=
  match v with
  | mk_ref x => x
  end.

Parameter factorielle: Z -> Z.

Axiom factorielle_zero : ((factorielle 0%Z) = 1%Z).

Axiom factorielle_succ :
  forall (n:Z), (0%Z <= n)%Z ->
  ((factorielle (n + 1%Z)%Z) = ((n + 1%Z)%Z * (factorielle n))%Z).

(* Why3 goal *)
Theorem VC_factorielle_ascendant :
  forall (n:Z), (0%Z <= n)%Z ->
  (((factorielle 0%Z) = 1%Z) /\ ((0%Z <= 0%Z)%Z /\ (0%Z <= n)%Z)) /\
  forall (r:Z) (i:Z),
  (((factorielle i) = r) /\ ((0%Z <= i)%Z /\ (i <= n)%Z)) ->
  ((i < n)%Z -> forall (i1:Z), (i1 = (i + 1%Z)%Z) -> forall (r1:Z),
   (r1 = (i1 * r)%Z) ->
   ((0%Z <= (n - i)%Z)%Z /\ ((n - i1)%Z < (n - i)%Z)%Z) /\
   (((factorielle i1) = r1) /\ ((0%Z <= i1)%Z /\ (i1 <= n)%Z))) /\
  (~ (i < n)%Z -> ((factorielle n) = r)).
(* Why3 intros n h1. *)
Proof.
intros n h1.

Qed.

