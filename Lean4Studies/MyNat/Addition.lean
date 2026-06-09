import Lean4Studies.MyNat.Definition

namespace MyNat

-- Recursion equations (axioms)
-- add_zero (a : MyNat) : a + 0 = a
-- add_succ (a b : MyNat) : a + succ b = succ (a + b)

def add : MyNat → MyNat → MyNat
  | a, .zero   => a
  | a, .succ b => .succ (add a b)

instance : Add MyNat where add := add

theorem add_zero (a : MyNat) : a + 0 = a := rfl
theorem add_succ (a b : MyNat) : a + succ b = succ (a + b) := rfl

-- Theorems to prove:
-- zero_add (n : MyNat) : 0 + n = n
-- succ_add (a b : MyNat) : succ a + b = succ (a + b)
-- add_comm (a b : MyNat) : a + b = b + a
-- add_assoc (a b c : MyNat) : a + b + c = a + (b + c)
-- add_right_comm (a b c : MyNat) : a + b + c = a + c + b

end MyNat
