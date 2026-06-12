import Lean4Studies.MyNat.Definition

namespace MyNat

-- Recursion equations (axioms)
-- add_zero (a : MyNat) : a + 0 = a
-- add_succ (a b : MyNat) : a + succ b = succ (a + b)

def add : MyNat → MyNat → MyNat
  | a, .zero   => a
  | a, .succ b => .succ (add a b)

instance : Add MyNat where add := add

theorem add_zero (a : MyNat) : a + zero = a := rfl
theorem add_succ (a b : MyNat) : a + succ b = succ (a + b) := rfl

theorem zero_add (n : MyNat) : zero + n = n := by
  induction n with
    | zero => rfl
    | succ k ih => rw [add_succ, ih]

theorem succ_add (a b : MyNat) : succ a + b = succ (a + b) := by
  induction b with
    | zero => rfl
    | succ k ih => rw [add_succ, ih, add_succ]

theorem add_comm (a b : MyNat) : a + b = b + a := by
  induction b with
    | zero => rw [add_zero, zero_add]
    | succ k ih => rw [add_succ, ih, succ_add]

theorem add_assoc (a b c : MyNat) : a + b + c = a + (b + c) := by
  induction c with
    | zero => rw [add_zero, add_zero, add_comm]
    | succ k ih =>
      conv => lhs; rw [add_succ]
      conv => rhs; rw [add_succ]
      rw  [ih, add_succ]

theorem add_right_comm (a b c : MyNat) : a + b + c = a + c + b := by
  induction c with
    | zero => rw [add_zero, add_zero]
    | succ k ih =>
    conv => lhs; rw [add_succ, ih]
    conv => rhs; rw [add_assoc, succ_add, add_succ, ← add_assoc]



end MyNat
