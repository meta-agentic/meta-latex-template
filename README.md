# meta-latex-template

A ready-to-use repository for writing LaTeX documentation that has to hold up: a
research paper, a slide deck, a handbook and a logo, all sharing one visual
identity and one bibliography, built reproducibly in the same TeX Live image
locally and in CI, with an adversarial review harness that keeps claims honest.

| Deliverable | Class | Source | Output |
|-------------|-------|--------|--------|
| **Paper** | ACM `acmart` | [`paper/`](paper/) | `paper/paper.pdf` |
| **Slides** | `beamer` + `Brand` theme | [`slides/`](slides/) | `slides/slides.pdf` |
| **Manual** | `tufte-book` | [`manual/`](manual/) | `manual/manual.pdf` |
| **Logo** | TikZ `standalone` | [`brand/`](brand/) | `brand/out/{logo,mark,wordmark}.{pdf,png,svg}` |

Keep the deliverables you need and delete the rest: the Makefile and CI build
whatever is present.

## Use this template

1. **Use this template → Create a new repository** above, or:
   ```bash
   gh repo create <owner>/<name> --template meta-agentic/meta-latex-template --private --clone
   ```
2. Make it yours:
   - `common/brand.sty`: set `\brandname` and the palette.
   - `common/macros.sty`: replace `\project` and add your terms.
   - `paper/paper.tex`, `slides/slides.tex`, `manual/manual.tex`: title, authors.
   - `LICENSE`: choose the licence for your content (see below).
   - Delete any deliverable folder you will not use.
3. Build:
   ```bash
   make DOCKER=1 all     # first run pulls texlive/texlive:latest (~5 GB, one-off)
   ```

## Build

Everything is **pdfLaTeX + BibTeX**, driven by `latexmk` (`.latexmkrc`).

```bash
make all       # every deliverable present
make paper     # one deliverable
make logo      # brand PDFs into brand/out/
make raster    # + PNG/SVG (needs pdftocairo | inkscape | dvisvgm)
make clean
```

Prefix any target with `DOCKER=1` to run it inside `texlive/texlive:latest`, the
image CI uses, so nothing is installed on the host and local output matches CI.
A host build needs a full-enough distribution; a minimal one lacks `acmart` and
`tufte-book`. The authoritative build is CI
([`.github/workflows/latex.yml`](.github/workflows/latex.yml)); PDFs are uploaded
as workflow artifacts.

## How it fits together

- [`common/brand.sty`](common/brand.sty): palette tokens, the mark, the wordmark
  and the lockup. The mark is the author's logo: the Latin participles
  *evolvens iterans* (unfolding, repeating) running around an infinity sign as
  one closed ribbon that passes behind itself, drawn in TikZ with its own fixed
  typeface so it looks the same in every document. Change a colour
  here and every document follows.
- [`common/macros.sty`](common/macros.sty): the canonical spelling of every term,
  and the editorial markers `\TODO{}`, `\CLAIM{}`, `\NEEDCITE` that render
  visibly in draft builds.
- [`common/refs.bib`](common/refs.bib): the single bibliography.
- [`review/`](review/): the write → review → fact-check → editor loop, the claims
  ledger, the reviewer rubric and the submission checklist. A claim ships only
  once it has survived.

Documents load the shared files by relative path (`\usepackage{../common/brand}`),
so there is no `TEXINPUTS` setup. Each document uses its native class; do not
graft thesis scaffolding onto them.

## Conventions

- One `.bib`, one processor (BibTeX). No biber, no xelatex.
- Branding and terminology live once, in `common/`. Never hard-code a colour or
  re-spell a term inline.
- No claim ships ungrounded, and no citation ships unopened.
- Keep the build green: CI must produce every PDF with zero errors.

## Licence

The template itself is MIT ([`LICENSE`](LICENSE)). Documents you write with it
are yours to license: a common choice is CC BY 4.0 for prose and figures and MIT
for build scripts and macros.
