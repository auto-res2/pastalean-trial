#!/usr/bin/env sh
# inputs/*.py を PastaLean で Lean にし、outputs/ に .lean・ログ・exit code を残す。
# PASTALEAN_DIR は PastaLean の clone（lake build py2lean 済み）。
set -u
PASTALEAN_DIR="${PASTALEAN_DIR:-$HOME/repos/PastaLean}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$ROOT/outputs"
SUMMARY="$ROOT/outputs/summary.tsv"
{
  printf 'pastalean_commit\t%s\n' "$(git -C "$PASTALEAN_DIR" rev-parse --short HEAD)"
  printf 'input\texit\tseconds\n'
} > "$SUMMARY"
for f in "$ROOT"/inputs/*.py; do
  name="$(basename "$f" .py)"
  start=$(date +%s)
  (cd "$PASTALEAN_DIR" && uv run pastalean translate "$f" -o "$ROOT/outputs/$name.lean" --timeout 600) \
    > "$ROOT/outputs/$name.log" 2>&1
  code=$?
  end=$(date +%s)
  printf '%s\t%s\t%s\n' "$name" "$code" "$((end - start))" >> "$SUMMARY"
  echo "$name: exit $code ($((end - start))s)"
done
