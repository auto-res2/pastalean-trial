import PastaLean
import Libraries
import Std.Tactic.Do

open PastaLean
open Libraries
open Std.Do

set_option linter.all false
set_option mvcgen.warning false

set_option maxHeartbeats 200000

namespace PastaLean.User.Root

def claim_c1 := fun (obs : Std.HashMap String (Std.HashMap String Rat)) ↦
  -- observed.json の形: obs[指標][run_id]
  decide (obs⦋"trajectory_smape"⦌⦋"react-gpt-4.1-nano"⦌ -ₚ obs⦋"trajectory_smape"⦌⦋"react-gpt-4.1-mini"⦌ ≥ (0.0 : Rat))

attribute [simp, taste_ingr] claim_c1

def claim_c1'rn := fun (obs : Std.HashMap String (Std.HashMap String Float)) ↦
  -- observed.json の形: obs[指標][run_id]
  decide
    (obs⦋"trajectory_smape"⦌⦋"react-gpt-4.1-nano"⦌ -ₚ obs⦋"trajectory_smape"⦌⦋"react-gpt-4.1-mini"⦌ ≥ (0.0 : Float))

def main' :=
  ((do
      let mut obs :=
        Std.HashMap.ofList
          [("trajectory_smape",
              Std.HashMap.ofList
                [("react-gpt-4.1-mini", (0.3711800923509 : Rat)), ("react-gpt-4.1-nano", (0.47040152465822055 : Rat))])]
      let _ ← PastaLean.ProofMode.pyPrintProof [pyPrintArg (claim_c1 obs)]) :
    PastaLean.ProofMode.PyProofM _)

attribute [simp] main'

def main''rn :=
  ((do
      let mut obs :=
        Std.HashMap.ofList
          [("trajectory_smape",
              Std.HashMap.ofList
                [("react-gpt-4.1-mini", (0.3711800923509 : Float)),
                  ("react-gpt-4.1-nano", (0.47040152465822055 : Float))])]
      let _ ← pyPrintIO [pyPrintArg (claim_c1'rn obs)]) :
    IO _)

end PastaLean.User.Root

