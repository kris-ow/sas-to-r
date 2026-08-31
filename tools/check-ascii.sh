#!/usr/bin/env bash
# Fail if any site source contains a character you cannot type on a standard keyboard.
#
# Em dashes, curly quotes, arrows and ellipsis characters read as machine-generated
# text. Everything on this site is written in plain ASCII instead.

set -uo pipefail

hits=$(grep -rPno "[^\x00-\x7F]" \
  --include="*.qmd" --include="*.md" --include="*.yml" --include="*.yaml" \
  --include="*.css" --include="*.R" \
  --exclude-dir=_site --exclude-dir=_freeze --exclude-dir=.quarto --exclude-dir=.git \
  . || true)

if [ -n "$hits" ]; then
  echo "Non-ASCII characters found:"
  echo "$hits"
  echo
  echo "Replace them with plain keyboard characters. Common offenders:"
  echo "  em dash        ->  rewrite the sentence, or use a colon or comma"
  echo "  curly quotes   ->  \" and '"
  echo "  arrows         ->  ->  or the word"
  echo "  ellipsis       ->  ..."
  exit 1
fi

echo "ASCII check passed."
