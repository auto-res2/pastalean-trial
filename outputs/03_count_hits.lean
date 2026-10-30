import PastaLean
import Libraries
import Std.Tactic.Do

open PastaLean
open Libraries
open Std.Do

set_option linter.all false
set_option mvcgen.warning false

set_option maxHeartbeats 800000

namespace PastaLean.User.Root

def count_hits := fun (pred : List Int) ↦ fun (gold : List Int) ↦
  (do
    let mut hits : Int := (0 : Int)
    for hb'i : i in (PastaLean.pyRange (PastaLean.pyLen pred))do
      let _ := Libraries.passta.pyPassInvariant (decide ((0 : Int) ≤ hits))
      let _ := Libraries.passta.pyPassInvariant (decide (hits ≤ i))
      if h_1 : PastaLean.pyListGetProof pred i (PastaLean.pyRange_len_bound_of_eq rfl hb'i) = gold⦋i⦌ then 
        hits := hits +ₚ (1 : Int)
    return hits : Id _)

@[spec]
theorem count_hits_spec :
    ⦃⌜PastaLean.pyLen pred = PastaLean.pyLen gold⌝⦄ count_hits pred gold ⦃⇓hits =>
      ⌜(0 : Int) ≤ hits ∧ hits ≤ PastaLean.pyLen pred⌝⦄ :=
  by
  try
    mvcgen [count_hits, PastaLean.pyRange_forIn, PastaLean.pyRange_forIn_start] invariants
    · ⇓⟨cur, hits⟩ =>
      ⌜let i := (cur.prefix.length : Int);
        (0 : Int) ≤ hits ∧ hits ≤ i⌝
  taste?
  all_goals sorry

theorem count_hits_correct :
    ∀ (pred : List Int),
      ∀ (gold : List Int),
        PastaLean.pyLen pred = PastaLean.pyLen gold →
          let hits := (count_hits pred gold).run;
          (0 : Int) ≤ hits ∧ hits ≤ PastaLean.pyLen pred :=
  by
  intro pred gold hpre
  exact count_hits_spec hpre

def count_hits'rn := fun (pred : List Int) ↦ fun (gold : List Int) ↦
  Id.run
    (do
      let _ := Libraries.passta.pyPassRequires (PastaLean.pyLen pred == PastaLean.pyLen gold)
      let mut hits : Int := (0 : Int)
      for hb'i : i in (PastaLean.pyRange (PastaLean.pyLen pred))do
        let _ := Libraries.passta.pyPassInvariant (decide ((0 : Int) ≤ hits))
        let _ := Libraries.passta.pyPassInvariant (decide (hits ≤ i))
        if h_1 : PastaLean.pyListGetProof pred i (PastaLean.pyRange_len_bound_of_eq rfl hb'i) == gold⦋i⦌ then 
          hits := hits +ₚ (1 : Int)
      return hits)

def main' :=
  ((do
      let _ ←
        PastaLean.ProofMode.pyPrintProof
            [pyPrintArg
                (count_hits [(1 : Int), (0 : Int), (1 : Int), (1 : Int)]
                  [(1 : Int), (1 : Int), (1 : Int), (0 : Int)])]) :
    PastaLean.ProofMode.PyProofM _)

attribute [simp] main'

def main''rn :=
  ((do
      let _ ←
        pyPrintIO
            [pyPrintArg
                (count_hits'rn [(1 : Int), (0 : Int), (1 : Int), (1 : Int)]
                  [(1 : Int), (1 : Int), (1 : Int), (0 : Int)])]) :
    IO _)

end PastaLean.User.Root

