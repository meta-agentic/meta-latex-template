# .latexmkrc — pdfLaTeX everywhere, BibTeX when a document cites.
$pdf_mode  = 1;                 # produce PDF via pdflatex
$pdflatex  = 'pdflatex -interaction=nonstopmode -halt-on-error -file-line-error %O %S';
$bibtex_use = 2;                # run bibtex as needed; clean .bbl on -C
$max_repeat = 5;

# Keep aux clutter listable so .gitignore/clean can sweep it.
$clean_ext = 'bbl run.xml synctex.gz nav snm vrb';
