#!/usr/bin/env bash
# build-raster.sh — rasterize the brand PDFs to PNG (256/512/1024) + SVG for
# use outside the TeX ecosystem (website, dashboard, GitHub avatar, slides in
# other tools). Idempotent; writes into brand/out/.
#
# Requires a compiled PDF for each source (run `make logo` first, or this
# script will compile them if pdflatex is available). Rasterizers, in order of
# preference: pdftocairo (poppler) > inkscape > (gs+ImageMagick). SVG needs
# pdftocairo or inkscape or dvisvgm.
set -euo pipefail
cd "$(dirname "$0")"
OUT=out
mkdir -p "$OUT"

SOURCES=(logo mark wordmark)
SIZES=(256 512 1024)

have() { command -v "$1" >/dev/null 2>&1; }

ensure_pdf() {
  local base=$1
  if [[ ! -f "$OUT/$base.pdf" ]]; then
    if have pdflatex; then
      echo "  compiling $base.tex -> $OUT/$base.pdf"
      pdflatex -interaction=nonstopmode -halt-on-error -output-directory="$OUT" "$base.tex" >/dev/null
    else
      echo "  !! $OUT/$base.pdf missing and pdflatex not found — run 'make logo' on a TeX host first" >&2
      return 1
    fi
  fi
}

raster_png() {
  local base=$1 size=$2 src="$OUT/$base.pdf" dst="$OUT/$base-$size.png"
  if have pdftocairo; then
    pdftocairo -png -singlefile -scale-to "$size" "$src" "${dst%.png}"
  elif have inkscape; then
    inkscape "$src" --export-type=png --export-width="$size" --export-filename="$dst" >/dev/null 2>&1
  elif have gs && have convert; then
    convert -density 300 -background none "$src" -resize "${size}x${size}" "$dst"
  else
    echo "  !! no PNG rasterizer (need pdftocairo | inkscape | gs+convert)" >&2; return 1
  fi
  echo "  wrote $dst"
}

raster_svg() {
  local base=$1 src="$OUT/$base.pdf" dst="$OUT/$base.svg"
  if have pdftocairo; then
    pdftocairo -svg "$src" "$dst"
  elif have inkscape; then
    inkscape "$src" --export-type=svg --export-filename="$dst" >/dev/null 2>&1
  elif have dvisvgm; then
    dvisvgm --pdf "$src" -o "$dst" >/dev/null 2>&1
  else
    echo "  !! no SVG rasterizer (need pdftocairo | inkscape | dvisvgm)" >&2; return 1
  fi
  echo "  wrote $dst"
}

for base in "${SOURCES[@]}"; do
  echo "$base:"
  ensure_pdf "$base" || continue
  for s in "${SIZES[@]}"; do raster_png "$base" "$s" || true; done
  raster_svg "$base" || true
done
echo "done."
