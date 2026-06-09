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

theorem mul_one (m : MyNat) : m * 1 = m := sorry
theorem zero_mul (m : MyNat) : 0 * m = 0 := sorry
theorem succ_mul (a b : MyNat) : succ a * b = a * b + b := sorry
theorem mul_comm (a b : MyNat) : a * b = b * a := sorry
theorem one_mul (m : MyNat) : 1 * m = m := sorry
theorem two_mul (m : MyNat) : 2 * m = m + m := sorry
theorem mul_add (a b c : MyNat) : a * (b + c) = a * b + a * c := sorry
theorem add_mul (a b c : MyNat) : (a + b) * c = a * c + b * c := sorry
theorem mul_assoc (a b c : MyNat) : a * b * c = a * (b * c) := sorry

end MyNat
