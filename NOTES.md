# 結果（2026-10-30）

PastaLean 013de07、Lean v4.31.0。`outputs/` は既定（証明は `taste?` のまま `sorry` 扱いで型検査のみ）、`outputs/proved_*` は `--prove-asserts`（変換時に証明を探して埋める）。

| 入力 | 型検査 | 生成された定理 | `--prove-asserts` の結果 |
|---|---|---|---|
| 01 mean_acc（バグ入り） | 通過 | `∀ accs, len ≥ 1 → min ≤ mean_acc accs ∧ mean_acc accs ≤ max` | 証明できず `sorry` |
| 02 mean_acc（正しい） | 通過 | 同上 | 証明できず `sorry` |
| 03 count_hits | 通過 | Hoare triple `count_hits_spec`（invariant 付き） | 一部の goal を `omega` で閉じたが残りは `sorry` |
| 04 観測値の claim（定数） | 通過 | `claim_c1 = true`、`claim_c2 = true` | 自動で証明（`simp_all` + `grind`）、`sorry` 0 |
| 05 split_ids | 通過 | `∀ ids k, … len train = k ∧ train ++ test = ids` | 証明できず `sorry` |
| 06 claim（dict の入れ子） | 通過 | 定理なし（契約を付けていない） | — |

所要時間は 1 ファイル 12〜87 秒（初回は backend 起動込み）。PastaLean 自体の初回 build（Mathlib キャッシュ取得 + `lake build py2lean`）は約 1.5 時間。

## 分かったこと

- **6 件とも変換と型検査が通った。** float は証明用で `Rat`、実行用で `Float`。observed.json の形の dict は `Std.HashMap String (Std.HashMap String Rat)` になり、`obs["m"]["run"]` の参照もそのまま写る（06）。`all(...)`、内包表記、tuple、スライスも通った。
- **観測値に対する claim は自動で証明できた（04）。** 値が定数の比較は `decide` になり、`claim_c1 = true` を `simp_all` と `grind` が閉じた。AIRAS の claim を「観測値を定数として埋め込み、`= true` を証明する」形にすれば、証明本体を人も LLM も書かずに済む。
- **全称の契約は自動では閉じない（01、02、03、05）。** 正しい平均（02）もバグ入り（01）も同じく `sorry` で、自動証明だけでは区別がつかない。バグを「証明できない」として見つけるには、正しい側の証明が誰かに書ける必要がある。論文の `taste?` 8／164 と同じ傾向。
- **01 の反例は自動では出ない。** 証明が閉じないことと偽であることは別で、反例の提示は PastaLean の機能に無い。
- **`Result()` を含む契約は CPython では走らない。** `contracts` の `Result()` は `None` を返すので、`Ensures(min(accs) <= Result())` は Python 実行時に TypeError になる。「CPython でもそのまま走る」は `Result()` を使わない契約に限る。
