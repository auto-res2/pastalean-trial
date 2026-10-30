from contracts import *


def claim_c1(obs: dict[str, dict[str, float]]) -> bool:
    # observed.json の形: obs[指標][run_id]
    return obs["trajectory_smape"]["react-gpt-4.1-nano"] - obs["trajectory_smape"]["react-gpt-4.1-mini"] >= 0.0


def main():
    obs = {
        "trajectory_smape": {
            "react-gpt-4.1-mini": 0.3711800923509,
            "react-gpt-4.1-nano": 0.47040152465822055,
        }
    }
    print(claim_c1(obs))  # True
