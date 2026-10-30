from contracts import *

# scigym-code-as-declaration-3 の .research/results/<run>/metrics.json の trajectory_smape
SMAPE_MINI = 0.3711800923509
SMAPE_NANO = 0.47040152465822055


def claim_c1() -> bool:
    # c1: nano の trajectory_smape − mini の trajectory_smape ≥ 0
    Ensures(Result() == True)
    return SMAPE_NANO - SMAPE_MINI >= 0.0


def claim_c2() -> bool:
    # c2: mini の trajectory_smape − 0.6007 ≤ 0.10（0.6007 は s1.p5 の公表値）
    Ensures(Result() == True)
    return SMAPE_MINI - 0.6007 <= 0.10


def every_seed_margin(a: list[float], b: list[float], margin: float) -> bool:
    # すべての seed で a が b を margin 以上上回る
    Requires(len(a) == len(b))
    return all(a[i] - b[i] >= margin for i in range(len(a)))


def main():
    print(claim_c1(), claim_c2())
    print(every_seed_margin([0.47, 0.48, 0.46], [0.37, 0.38, 0.36], 0.05))  # True
    print(every_seed_margin([0.47, 0.48, 0.40], [0.37, 0.38, 0.36], 0.05))  # False
