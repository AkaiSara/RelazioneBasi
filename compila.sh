pdflatex doc/relazione.tex
rm *.aux *.fls *.fdb_latexmk *.out *.toc *.log
rm doc/*.aux doc/*.fls doc/*.fdb_latexmk doc/*.out doc/*.toc doc/*.log
xdg-open relazione.pdf
