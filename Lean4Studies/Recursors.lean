/-!
# Recursors: motives, large elimination, and what `rw` builds

Background, condensed:

* Given goal `P[t]` and `h : t = t'`, `rw` abstracts the targeted
  occurrence(s) of `t` to build a motive `m := fun y => P[y]` (so `m t` is
  definitionally the goal), then closes the goal via `Eq.mpr` — itself
  defined through `Eq.rec`:

  `Eq.rec.{u, v} {α : Sort v} {x : α}`
  `  {motive : (y : α) → x = y → Sort u}`
  `  (refl : motive x (.refl x))`
  `  {y : α} (t : x = y) : motive y t`

  Occurrence selection (`nth_rw` / `rw (occs := ...)`) is just *selective*
  abstraction: non-selected occurrences remain the literal term `t`.

* The motive universe `Sort u` is fully polymorphic: recursors support
  **large elimination** — eliminating into data and types, not only `Prop`.
  ι-reduction (recursor applied to a constructor reduces to the matching
  minor premise) is what makes such definitions *compute* during
  typechecking.

* Exception: inductives living in `Prop`. To preserve proof irrelevance, a
  `Prop`-valued inductive only gets a `Sort u` motive when it is a
  **subsingleton** (≤ 1 constructor, and every constructor argument is a
  proof, a parameter, or an index). `Eq`, `True`, `False`, `And`, `Acc`
  qualify; `Or` does not.

* A **constant** motive `fun _ => C` is plain recursion/case analysis; a
  **dependent** motive `fun x => C x` makes the return type track the major
  premise (induction in `Prop`, dependent functions in `Type`).

Recommended order: 1 → 5. Exercise 4 consolidates the universe story;
3 and 5 consolidate motive construction.
-/

namespace Recursors

/-!
## Exercise 1: ι-reduction with a `Type 1`-valued motive

Define `Tuple α n` ≡ `α × α × ⋯ × Unit` (`n` copies of `α`) by applying
`Nat.rec` directly — no `match`, no equation compiler. The motive is
`fun _ => Type : Nat → Type 1`, i.e. the recursor's *values* are types.

Then replace the `sorry` in the `example` with `rfl`: ι-reduction makes
`Tuple Nat 2` compute to `Nat × Nat × Unit` during typechecking.
-/

def Tuple (α : Type) : Nat → Type :=
  Nat.rec
    -- motive
    (motive := λ _ ↦ Type)
    -- minor premise 1: zero
    (Unit)
    -- minor premise 2: succ
    (λ _ ih ↦ α × ih)
    -- major premise

example : Tuple Nat 2 = (Nat × Nat × Unit) :=
  rfl

/-!
## Exercise 2: transport by hand

Implement `Vec.cast` as an explicit `Eq.rec` application — no `▸`, no
`cast`, no tactics. Write the motive by hand (`motive := fun k _ => ...`).
This is exactly what `h ▸ v` elaborates to.
-/

inductive Vec (α : Type) : Nat → Type where
  | nil  : Vec α 0
  | cons {n : Nat} : α → Vec α n → Vec α (n + 1)

def Vec.cast {α : Type} {n m : Nat} (h : n = m) : Vec α n → Vec α m :=
  -- okay so the type appears to say given n = n a Vec of α n implies a Vec of α m
  -- and the fucntion works by accepting some whitness that n = m, a Vec α n and then it gives you back Vec α m?
  λ v ↦
    Eq.rec
      -- motive
      (motive :=
        λ
         (x : Nat)    -- for any Nat
         (_ : n = x) -- and a proof n = x
         ↦ Vec α x)   -- we want back a Vec α x
      -- minor premise 1: refl
      v
      -- major premise
      h

/-!
## Exercise 3: constructor disjointness from scratch

Prove `(0 : Nat) ≠ 1` without `Nat.noConfusion`, `simp`, `decide`, `omega`,
or `cases`/`injection`. Use `Nat.rec` with a motive whose *values* are
different propositions per constructor — e.g.
`fun n => Nat.rec True (fun _ _ => False) n` — (or detour via `Bool`),
then transport `trivial` along the hypothesis `(h : 0 = 1)` with `Eq.rec`.
-/

/- def D : Nat → Prop := -/
/-   Nat.rec -/
/-     (motive := -/
/-       λ -/
/-         (_ : Nat) -- for any inhabitant of Nat -/
/-         ↦ Prop    -- we want back a Prop -/
/-     ) -/
/-     -- minor prmeise 1: zero -/
/-     True -- when zero provide true -/
/-     -- minor premise 2: succ -/
/-     (λ _ _ ↦  False) -- provide false regarless of the current nat or previous result -/

def D : Nat → Prop :=
  λ (n : Nat) ↦ -- bind goal antecedent
    Nat.casesOn
      (motive :=
        λ
          (_ : Nat) -- for any inhabitant of Nat
          ↦ Prop    -- we want back a Prop
      )
    -- major premise
    n
    -- minor premise 1: zero
    True
    -- minor premise 2: succ (no ih)
    (λ (_ : Nat) ↦ False)

theorem zero_ne_one : (0 : Nat) ≠ 1 :=
  -- bind negation antecedent
  λ (p : 0 = 1) ↦
    Eq.rec
      (motive :=
        λ
         (x : Nat)   -- for any Nat
         (_ : 0 = x) -- and a proof 0 = x
         ↦ D x)
     -- minor premise
     trivial
     -- major premise
     p

/-!
## Exercise 4: subsingleton elimination (the universe story)

(a) Uncomment `whichOr` and observe the universe error: `Or.rec`'s motive
is restricted to `Prop` (`Or` has two constructors, so a `Sort u` motive
would let programs inspect *which* proof they received, breaking proof
irrelevance). Re-comment it afterwards so the file builds.

(b) Check `#check @And.rec` and `#check @Or.rec` to compare motive
universes. Then implement `andToBool` using `And.rec` explicitly — the
point is simply that it *elaborates* with a `Type`-valued motive. Explain
why via the subsingleton criteria: one constructor, every argument a proof.
-/

def andToBool {a b : Prop} (h : a ∧ b) : Bool :=
  -- okay so we have a bound And and we want a bool back?
  And.rec
    (motive :=
      λ
        (_ : a ∧ b) -- for conjuncts a and b
        ↦ Bool) -- we want back a bool
    -- minor premise 1: intro
    (λ _ _ ↦ True) -- somehow True resolves to true?
    h

/-!
## Exercise 5: `nth_rw` by hand — selective occurrence abstraction

The goal below contains three occurrences of `a`; rewrite only the
*second* one (the `nth_rw 2 [h]` of Mathlib; the core spelling is
`rw (occs := .pos [2]) [h]`).

(a) `manual`: construct the motive abstracting only the second occurrence
yourself and close the goal with `Eq.mpr (congrArg _ h) ...` (or a raw
`h ▸` with the motive given explicitly) — no `rw`.

(b) `viaRw`: close the same goal with `rw (occs := .pos [2]) [h]`, then
compare the elaborated terms:
`set_option pp.all true in #print manual` vs `#print viaRw`.
-/

theorem manual (a b : Nat) (h : a = b) : a + a = a + b :=
  Eq.rec (motive := λ x _ ↦ x) rfl (congrArg (λ y ↦ a + y = a + b) h).symm

theorem viaRw (a b : Nat) (h : a = b) : a + a = a + b := by
  rw (occs := .pos [2]) [h]

end Recursors
