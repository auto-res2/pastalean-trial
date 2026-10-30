from contracts import *


def count_hits(pred: list[int], gold: list[int]) -> int:
    Requires(len(pred) == len(gold))
    Ensures(0 <= Result())
    Ensures(Result() <= len(pred))
    hits = 0
    for i in range(len(pred)):
        Invariant(0 <= hits)
        Invariant(hits <= i)
        if pred[i] == gold[i]:
            hits = hits + 1
    return hits


def main():
    print(count_hits([1, 0, 1, 1], [1, 1, 1, 0]))  # 2
