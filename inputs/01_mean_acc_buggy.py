from contracts import *


def mean_acc(accs: list[float]) -> float:
    Requires(len(accs) >= 1)
    Ensures(min(accs) <= Result())
    Ensures(Result() <= max(accs))
    return sum(accs) / (len(accs) - 1)  # バグ: 分母が 1 小さい


def main():
    print(mean_acc([0.80, 0.80, 0.80]))  # 1.2（本当の平均は 0.80）
