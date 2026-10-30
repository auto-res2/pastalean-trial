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

-- scigym-code-as-declaration-3 の .research/results/<run>/metrics.json の trajectory_smape
def SMAPE_MINI :=
  (0.3711800923509 : Rat)

def SMAPE_NANO :=
  (0.47040152465822055 : Rat)

def claim_c1 :=
  decide (SMAPE_NANO -ₚ SMAPE_MINI ≥ (0.0 : Rat))

attribute [simp] claim_c1

@[taste_ingr]
theorem claim_c1_correct : claim_c1 = Bool.true := by simp_all (config := { zetaDelta := true }) [taste_ingr]; grind +locals +suggestions

def claim_c1'rn :=
  decide (SMAPE_NANO -ₚ SMAPE_MINI ≥ (0.0 : Float))

def claim_c2 :=
  decide (SMAPE_MINI -ₚ (0.6007 : Rat) ≤ (0.1 : Rat))

attribute [simp] claim_c2

@[taste_ingr]
theorem claim_c2_correct : claim_c2 = Bool.true := by simp_all (config := { zetaDelta := true }) [taste_ingr]; grind +locals +suggestions

def claim_c2'rn :=
  decide (SMAPE_MINI -ₚ (0.6007 : Float) ≤ (0.1 : Float))

def every_seed_margin := fun (a : List Rat) ↦ fun (b : List Rat) ↦ fun (margin : Rat) ↦
  Id.run
    (do
      -- すべての seed で a が b を margin 以上上回る
      let _ := Libraries.passta.pyPassRequires (PastaLean.pyLen a == PastaLean.pyLen b)
      let p'_ret_1 :=
        PastaLean.pyAll ((PastaLean.pyRange (PastaLean.pyLen a)).map fun (i : Int) => decide (a⦋i⦌ -ₚ b⦋i⦌ ≥ margin))
      return p'_ret_1)

attribute [simp, taste_ingr] every_seed_margin

def every_seed_margin'rn := fun (a : List Float) ↦ fun (b : List Float) ↦ fun (margin : Float) ↦
  Id.run
    (do
      -- すべての seed で a が b を margin 以上上回る
      let _ := Libraries.passta.pyPassRequires (PastaLean.pyLen a == PastaLean.pyLen b)
      let p'_ret_1 :=
        PastaLean.pyAll ((PastaLean.pyRange (PastaLean.pyLen a)).map fun (i : Int) => decide (a⦋i⦌ -ₚ b⦋i⦌ ≥ margin))
      return p'_ret_1)

def main' :=
  ((do
      let _ ← PastaLean.ProofMode.pyPrintProof [pyPrintArg (claim_c1), pyPrintArg (claim_c2)]
      let _ ←
        PastaLean.ProofMode.pyPrintProof
            [pyPrintArg
                (every_seed_margin [(0.47 : Rat), (0.48 : Rat), (0.46 : Rat)] [(0.37 : Rat), (0.38 : Rat), (0.36 : Rat)]
                  (0.05 : Rat))]
      let _ ←
        PastaLean.ProofMode.pyPrintProof
            [pyPrintArg
                (every_seed_margin [(0.47 : Rat), (0.48 : Rat), (0.4 : Rat)] [(0.37 : Rat), (0.38 : Rat), (0.36 : Rat)]
                  (0.05 : Rat))]) :
    PastaLean.ProofMode.PyProofM _)

attribute [simp] main'

def main''rn :=
  ((do
      let _ ← pyPrintIO [pyPrintArg (claim_c1'rn), pyPrintArg (claim_c2'rn)]
      let _ ←
        pyPrintIO
            [pyPrintArg
                (every_seed_margin'rn [(0.47 : Float), (0.48 : Float), (0.46 : Float)]
                  [(0.37 : Float), (0.38 : Float), (0.36 : Float)] (0.05 : Float))]
      let _ ←
        pyPrintIO
            [pyPrintArg
                (every_seed_margin'rn [(0.47 : Float), (0.48 : Float), (0.4 : Float)]
                  [(0.37 : Float), (0.38 : Float), (0.36 : Float)] (0.05 : Float))]) :
    IO _)

end PastaLean.User.Root

