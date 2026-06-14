namespace AccExploration

/-!
## Exercise 1: Build `Acc` proofs by hand

Prove that 0, 1, and 2 are accessible under `Nat.lt`.
For 0: no natural number is `< 0`, so the `∀ y, y < 0 → Acc ...`
premise is vacuously satisfied.
For 1: the only predecessor is 0, which you already proved accessible.
For 2: predecessors are 0 and 1.

Use `Acc.intro` directly — no tactics, no `Nat.lt_wfRel`.
Hint: `Nat.lt` reduces to `Nat.succ y ≤ x`, and `Nat.le`
is an inductive. `omega` can close the impossible branches.
-/

theorem acc_zero : Acc Nat.lt 0 := sorry
theorem acc_one  : Acc Nat.lt 1 := sorry
theorem acc_two  : Acc Nat.lt 2 := sorry

/-!
## Exercise 2: Use `Acc.rec` directly to define a function

Define integer division by 2 (flooring) as a direct `Acc.rec`
application on an `Acc Nat.lt n` proof. No `match`, no equation
compiler, no `WellFounded.fix`.

The logic: if n < 2, return 0; otherwise return 1 + (div2 (n - 2)).
The recursive call on (n - 2) is valid because n - 2 < n when n ≥ 2.

This is the raw version of what `WellFounded.fix` automates.
-/

def div2 (n : Nat) : Nat := sorry

/-!
## Exercise 3: Rewrite div2 using `WellFounded.fix`

Same function, but use `WellFounded.fix` with `Nat.lt_wfRel.wf`
instead of threading `Acc` proofs manually. Compare the ergonomics.
The body `F` receives `x : Nat` and
`ih : (y : Nat) → y < x → Nat`, and should implement the same
if/else logic.
-/

def div2' (n : Nat) : Nat := sorry

/-!
## Exercise 4: See what Lean generates

Define div2 the normal way with `termination_by n` and a
`decreasing_by` block (or let Lean infer it). Then inspect
the kernel term:

  set_option pp.all true in #print div2''

Identify the `WellFounded.fix` call in the output. This closes
the loop: your handwritten `Acc.rec` from Exercise 2, the
`WellFounded.fix` from Exercise 3, and Lean's auto-generated
term are all the same construction at different abstraction levels.
-/

def div2'' (n : Nat) : Nat := sorry

/-!
## Exercise 5: Why `Acc` must be a subsingleton

Attempt to define a hypothetical `Acc'` in `Type` instead of
`Prop`, with the same structure. Observe that its recursor's
motive would be unrestricted anyway (it's not in `Prop`), but
consider: could you prove `WellFounded` for it? `WellFounded`
is a `Prop` saying `∀ a, Acc r a`. If `Acc` lived in `Type`,
`WellFounded` would need to produce *data* — a specific `Acc`
tree for every element — and proof irrelevance couldn't collapse
them.

The exercise: define `Acc'` in `Type`, then try to state and
prove an analogue of `WellFounded` for `Nat.lt`. Observe the
friction. This demonstrates why `Acc` living in `Prop` (and
being a subsingleton) is a deliberate design choice, not an
accident.
-/

inductive Acc' {α : Type} (r : α → α → Prop) : α → Type where
  | intro (x : α) (h : ∀ y, r y x → Acc' r y) : Acc' r x

-- Try: what does WellFounded look like for Acc'?
-- def wf_nat_lt' : ∀ n, Acc' Nat.lt n := sorry

end AccExploration
