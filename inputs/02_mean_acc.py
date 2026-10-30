from contracts import *


def mean_acc(accs: list[float]) -> float:
    Requires(len(accs) >= 1)
    Ensures(min(accs) <= Result())
    Ensures(Result() <= max(accs))
    return sum(accs) / len(accs)


def main():
    print(mean_acc([0.80, 0.80, 0.80]))
