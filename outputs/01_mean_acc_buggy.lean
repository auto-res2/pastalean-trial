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

def mean_acc := fun (accs : List Rat) ↦ (show Rat from PastaLean.pySum accs /ₚ (PastaLean.pyLen accs -ₚ (1 : Int)))

attribute [simp] mean_acc

@[taste_ingr]
theorem mean_acc_correct :
    ∀ (accs : List Rat),
      PastaLean.pyLen accs ≥ (1 : Int) → PastaLean.pyMin accs ≤ mean_acc accs ∧ mean_acc accs ≤ PastaLean.pyMax accs :=
  by taste?

def mean_acc'rn := fun (accs : List Float) ↦
  (show Float from PastaLean.pyFloat (PastaLean.pySum accs) /ₚ (PastaLean.pyLen accs -ₚ (1 : Int)))

def main' :=
  ((do
      let _ ← PastaLean.ProofMode.pyPrintProof [pyPrintArg (mean_acc [(0.8 : Rat), (0.8 : Rat), (0.8 : Rat)])]) :
    PastaLean.ProofMode.PyProofM _)

attribute [simp] main'

def main''rn :=
  ((do
      let _ ← pyPrintIO [pyPrintArg (mean_acc'rn [(0.8 : Float), (0.8 : Float), (0.8 : Float)])]) :
    IO _)

end PastaLean.User.Root

