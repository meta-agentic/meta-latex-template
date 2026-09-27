# Repository contract

This repository writes LaTeX documentation from one shared identity. Rules for
anyone, human or agent, working in it:

- **pdfLaTeX + BibTeX for every document.** One bibliography (`common/refs.bib`),
  one processor. No biber, no xelatex.
- **Each document uses its native class:** `acmart` (paper), `beamer` (slides),
  `tufte-book` (manual), `standalone` (brand). Do not import thesis scaffolding.
- **Identity and terms live once, in `common/`.** Never hard-code a colour or
  re-spell a term inline; use the palette tokens and the macros.
- **No claim ships ungrounded.** Every `\CLAIM{}` goes through
  `review/harness.md` and reaches `survived` in `review/claims.md` or is cut.
  Every citation is a source that was opened.
- **No private data** in text, bibliography, figures, or git metadata.
- **Keep the build green.** `make DOCKER=1 all` and CI build every PDF with zero
  errors; fix warnings rather than letting them accrete.
