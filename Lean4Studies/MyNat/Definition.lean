inductive MyNat where
  | zero : MyNat
  | succ : MyNat → MyNat
  deriving Repr

namespace MyNat

instance : OfNat MyNat 0 where ofNat := zero
instance : OfNat MyNat 1 where ofNat := succ zero
instance : OfNat MyNat 2 where ofNat := succ (succ zero)
instance : OfNat MyNat 3 where ofNat := succ (succ (succ zero))
instance : OfNat MyNat 4 where ofNat := succ (succ (succ (succ zero)))

theorem one_eq_succ_zero : (1 : MyNat) = succ 0 := rfl
theorem two_eq_succ_one : (2 : MyNat) = succ 1 := rfl
theorem three_eq_succ_two : (3 : MyNat) = succ 2 := rfl
theorem four_eq_succ_three : (4 : MyNat) = succ 3 := rfl

end MyNat
