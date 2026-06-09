import Lean4Studies.MyNat.Multiplication

namespace MyNat

-- Recursion equations (axioms)
-- pow_zero (m : MyNat) : m ^ 0 = 1
-- pow_succ (m n : MyNat) : m ^ succ n = m ^ n * m

def pow : MyNat → MyNat → MyNat
  | _, .zero   => .succ .zero
  | m, .succ n => mul (pow m n) m

instance : Pow MyNat MyNat where pow := pow

theorem pow_zero (m : MyNat) : m ^ (0 : MyNat) = 1 := rfl
theorem pow_succ (m n : MyNat) : m ^ succ n = m ^ n * m := rfl

-- Theorems to prove:
-- zero_pow_zero : (0 : MyNat) ^ (0 : MyNat) = 1
-- zero_pow_succ (m : MyNat) : (0 : MyNat) ^ succ m = 0
-- pow_one (a : MyNat) : a ^ (1 : MyNat) = a
-- one_pow (m : MyNat) : (1 : MyNat) ^ m = 1
-- pow_two (a : MyNat) : a ^ (2 : MyNat) = a * a
-- pow_add (a m n : MyNat) : a ^ (m + n) = a ^ m * a ^ n
-- mul_pow (a b n : MyNat) : (a * b) ^ n = a ^ n * b ^ n
-- pow_pow (a m n : MyNat) : (a ^ m) ^ n = a ^ (m * n)
-- add_sq (a b : MyNat) : (a + b) ^ (2 : MyNat) = a ^ (2 : MyNat) + b ^ (2 : MyNat) + 2 * a * b

end MyNat
