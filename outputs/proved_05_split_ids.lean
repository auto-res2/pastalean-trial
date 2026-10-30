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

def split_ids := fun (ids : List Int) ↦ fun (k : Int) ↦
  let train := (PastaLean.pySlice ids none (some k) none : List Int)
  let test := (PastaLean.pySlice ids (some k) none none : List Int)
  (train, test)

attribute [simp] split_ids

@[taste_ingr]
theorem split_ids_correct :
    ∀ (ids : List Int),
      ∀ (k : Int),
        let train := PastaLean.pySlice ids none (some k) none
        let test := PastaLean.pySlice ids (some k) none none
        (0 : Int) ≤ k →
          k ≤ PastaLean.pyLen ids →
            PastaLean.pyLen (split_ids ids k)⦋(0 : Int)⦌ = k ∧
              (split_ids ids k)⦋(0 : Int)⦌ +ₚ (split_ids ids k)⦋(1 : Int)⦌ = ids :=
  by intros; simp_all (config := { zetaDelta := true }) [taste_ingr]; sorry

def split_ids'rn := fun (ids : List Int) ↦ fun (k : Int) ↦
  let train := (PastaLean.pySlice ids none (some k) none : List Int)
  let test := (PastaLean.pySlice ids (some k) none none : List Int)
  (train, test)

def main' :=
  ((do
      let _ ←
        PastaLean.ProofMode.pyPrintProof
            [pyPrintArg (split_ids [(1 : Int), (2 : Int), (3 : Int), (4 : Int), (5 : Int)] (3 : Int))]) :
    PastaLean.ProofMode.PyProofM _)

attribute [simp] main'

def main''rn :=
  ((do
      let _ ← pyPrintIO [pyPrintArg (split_ids'rn [(1 : Int), (2 : Int), (3 : Int), (4 : Int), (5 : Int)] (3 : Int))]) :
    IO _)

end PastaLean.User.Root

