import Lean4Studies.MyNat.Multiplication
import Lean4Studies.MyNat.Order

namespace MyNat

-- Peano axioms needed here:
-- succ_inj (a b : MyNat) (h : succ a = succ b) : a = b
-- zero_ne_succ (a : MyNat) : 0 ≠ succ a

-- Theorems to prove:

-- Addition cancellation
-- add_right_cancel (a b n : MyNat) : a + n = b + n → a = b
-- add_left_cancel (a b n : MyNat) : n + a = n + b → a = b
-- add_left_eq_self (x y : MyNat) : x + y = y → x = 0
-- add_right_eq_self (x y : MyNat) : x + y = x → y = 0
-- add_right_eq_zero (a b : MyNat) : a + b = 0 → a = 0
-- add_left_eq_zero (a b : MyNat) : a + b = 0 → b = 0

-- Multiplication cancellation
-- mul_left_cancel (a b c : MyNat) (ha : a ≠ 0) (h : a * b = a * c) : b = c
-- mul_right_eq_one (x y : MyNat) (h : x * y = 1) : x = 1
-- mul_eq_zero (a b : MyNat) (h : a * b = 0) : a = 0 ∨ b = 0
-- mul_ne_zero (a b : MyNat) (ha : a ≠ 0) (hb : b ≠ 0) : a * b ≠ 0

end MyNat
