import Lean4Studies.MyNat.Addition

namespace MyNat

-- Recursion equations (axioms)
-- mul_zero (a : MyNat) : a * 0 = 0
-- mul_succ (a b : MyNat) : a * succ b = a * b + a

def mul : MyNat → MyNat → MyNat
  | _, .zero   => .zero
  | a, .succ b => add (mul a b) a

instance : Mul MyNat where mul := mul

theorem mul_zero (a : MyNat) : a * 0 = 0 := rfl
theorem mul_succ (a b : MyNat) : a * succ b = a * b + a := rfl

-- Theorems to prove:
-- mul_one (m : MyNat) : m * 1 = m
-- zero_mul (m : MyNat) : 0 * m = 0
-- succ_mul (a b : MyNat) : succ a * b = a * b + b
-- mul_comm (a b : MyNat) : a * b = b * a
-- one_mul (m : MyNat) : 1 * m = m
-- two_mul (m : MyNat) : 2 * m = m + m
-- mul_add (a b c : MyNat) : a * (b + c) = a * b + a * c
-- add_mul (a b c : MyNat) : (a + b) * c = a * c + b * c
-- mul_assoc (a b c : MyNat) : a * b * c = a * (b * c)

end MyNat
