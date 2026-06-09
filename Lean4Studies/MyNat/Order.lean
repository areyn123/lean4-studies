import Lean4Studies.MyNat.Addition

namespace MyNat

-- a ≤ b iff ∃ c, b = a + c
def le (a b : MyNat) : Prop := ∃ c : MyNat, b = a + c

instance : LE MyNat where le := le

theorem le_refl (x : MyNat) : x ≤ x := sorry
theorem zero_le (x : MyNat) : 0 ≤ x := sorry
theorem le_succ_self (x : MyNat) : x ≤ succ x := sorry
theorem le_trans (x y z : MyNat) (hxy : x ≤ y) (hyz : y ≤ z) : x ≤ z := sorry
theorem le_zero (x : MyNat) (hx : x ≤ 0) : x = 0 := sorry
theorem le_antisymm (x y : MyNat) (hxy : x ≤ y) (hyx : y ≤ x) : x = y := sorry
theorem le_total (x y : MyNat) : x ≤ y ∨ y ≤ x := sorry
theorem succ_le_succ (x y : MyNat) (hx : succ x ≤ succ y) : x ≤ y := sorry

end MyNat
