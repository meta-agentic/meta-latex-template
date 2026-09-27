# Makefile — build every deliverable present in this repo. Engine: pdfLaTeX
# via latexmk (see .latexmkrc).
# Targets: paper slides manual logo raster all clean help.
#
# Two ways to build:
#   make all            — host TeX (needs a full-enough distribution)
#   make DOCKER=1 all   — inside texlive/texlive:latest, the SAME image CI
#                         uses: identical output, nothing installed on the
#                         host. First run pulls the image (~5 GB, one-off).
#
# DOCKER mode re-invokes this Makefile inside the container, so every target
# works identically in both modes. A deliverable you delete (say, manual/)
# simply drops out of `all`.
LATEXMK := latexmk -pdf

TEXIMG  := texlive/texlive:latest
# Docker Desktop's /usr/local/bin symlinks can be broken (AppTranslocation);
# fall back to the CLI inside the app bundle.
DOCKERBIN := $(shell command -v docker 2>/dev/null \
  || echo /Applications/Docker.app/Contents/Resources/bin/docker)

# Deliverables present: <dir>/<dir>.tex exists.
DOCS := $(foreach d,paper slides manual,$(if $(wildcard $(d)/$(d).tex),$(d)))
LOGO := $(if $(wildcard brand/logo.tex),logo)

ifdef DOCKER
Makefile .latexmkrc: ;
%: FORCE
	$(DOCKERBIN) run --rm -v "$(CURDIR)":/work -w /work $(TEXIMG) make $@
FORCE:
.PHONY: FORCE
else

.PHONY: all paper slides manual logo raster clean help

help:
	@echo "present: $(DOCS) $(LOGO)"
	@echo "targets: $(DOCS) $(LOGO) raster all clean"
	@echo "prefix with DOCKER=1 to build in the CI image ($(TEXIMG))"

all: $(DOCS) $(LOGO)

paper:
	cd paper   && $(LATEXMK) paper.tex

slides:
	cd slides  && $(LATEXMK) slides.tex

manual:
	cd manual  && $(LATEXMK) manual.tex

logo:
	cd brand   && $(LATEXMK) -output-directory=out logo.tex mark.tex wordmark.tex

# PDF -> PNG/SVG for non-TeX use (needs pdftocairo | inkscape | dvisvgm)
raster: logo
	cd brand   && ./build-raster.sh

clean:
	$(foreach d,$(DOCS),-cd $(d) && latexmk -C;)
	-cd brand && latexmk -C -output-directory=out
	-rm -f brand/out/*.png brand/out/*.svg

endif
