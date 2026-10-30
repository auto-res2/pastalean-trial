from contracts import *


def split_ids(ids: list[int], k: int) -> tuple[list[int], list[int]]:
    Requires(0 <= k)
    Requires(k <= len(ids))
    Ensures(len(Result()[0]) == k)
    Ensures(Result()[0] + Result()[1] == ids)
    train = ids[:k]
    test = ids[k:]
    return train, test


def main():
    print(split_ids([1, 2, 3, 4, 5], 3))  # ([1, 2, 3], [4, 5])
