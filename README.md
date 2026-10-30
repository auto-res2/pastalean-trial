# pastalean-trial

PastaLean（Python → Lean 4 の決定的な変換器、arXiv 2610.34205）を、AIRAS の claim 層にあたる小さな Python 関数で試した記録。

## 目的

- AIRAS で agent が書く claim 関数（観測値に対する比較、集約、分割、採点）が PastaLean の対応範囲に入るか。
- 契約（`Requires`／`Ensures`／`Invariant`）を付けたとき、定理と証明の skeleton がどう出るか。`taste?` がどこまで閉じるか。
- 観測値に対する claim（定数の比較）を Lean 側で判定できるか。

## 環境

- PastaLean: https://github.com/siddhartha-gadgil/PastaLean （commit は `outputs/summary.tsv` の先頭行に記録）
- Lean: leanprover/lean4:v4.31.0、Mathlib v4.31.0（PastaLean の pin）
- 実行: `uv run pastalean translate <file> --timeout 600`（`--mode both` 既定。証明用 twin と実行用 twin を出し、`lake env lean` で型検査）

## 入力（`inputs/`）

| ファイル | 何を試すか |
|---|---|
| `01_mean_acc_buggy.py` | 平均の分母が 1 小さいバグ。契約「min ≤ 結果 ≤ max」は破れるはず |
| `02_mean_acc.py` | 正しい平均。同じ契約が証明できるか |
| `03_count_hits.py` | 採点関数。ループと invariant、`0 ≤ 結果 ≤ len` |
| `04_claims_observed.py` | AIRAS の claim を定数で書いたもの（scigym-code-as-declaration-3 の record の値）。`decide` で判定できるか |
| `05_split_ids.py` | データ分割。tuple の返り値と「結合すると元に戻る」契約 |
| `06_claims_dict.py` | observed.json の形（dict の入れ子）から claim を引くもの。dict の対応範囲 |

契約は PastaLean の `contracts` モジュールの記法（`from contracts import *`）。

## 実行

```sh
scripts/translate_all.sh                                        # 型検査のみ（証明は sorry 扱い）
PROVE_FLAG=--prove-asserts OUT_SUFFIX=proved_ scripts/translate_all.sh   # 証明も探す
```

## 結果

`outputs/summary.tsv` と `NOTES.md` を参照。
