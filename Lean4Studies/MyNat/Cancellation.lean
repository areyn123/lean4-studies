import Lean4Studies.MyNat.Multiplication
import Lean4Studies.MyNat.Order

namespace MyNat

-- Peano axioms (needed by cancellation proofs)
theorem succ_inj (a b : MyNat) (h : succ a = succ b) : a = b := sorry
theorem zero_ne_succ (a : MyNat) : 0 ≠ succ a := sorry

-- Addition cancellation
theorem add_right_cancel (a b n : MyNat) : a + n = b + n → a = b := sorry
theorem add_left_cancel (a b n : MyNat) : n + a = n + b → a = b := sorry
theorem add_left_eq_self (x y : MyNat) : x + y = y → x = 0 := sorry
theorem add_right_eq_self (x y : MyNat) : x + y = x → y = 0 := sorry
theorem add_right_eq_zero (a b : MyNat) : a + b = 0 → a = 0 := sorry
theorem add_left_eq_zero (a b : MyNat) : a + b = 0 → b = 0 := sorry

-- Multiplication cancellation
theorem mul_left_cancel (a b c : MyNat) (ha : a ≠ 0) (h : a * b = a * c) : b = c := sorry
theorem mul_right_eq_one (x y : MyNat) (h : x * y = 1) : x = 1 := sorry
theorem mul_eq_zero (a b : MyNat) (h : a * b = 0) : a = 0 ∨ b = 0 := sorry
theorem mul_ne_zero (a b : MyNat) (ha : a ≠ 0) (hb : b ≠ 0) : a * b ≠ 0 := sorry

end MyNat
