NAME=Dissertation

all: $(NAME).pdf

# If you have good Emacs and Org-mode installed by default, delete "-l ~/.emacs.d/init.el"

%.pdf: $(NAME).tex
	pdflatex $^
	bibtex `basename $^ .tex`
	pdflatex $^
	pdflatex $^%.pdf: $(NAME).tex
	pdflatex $(NAME).tex

clean:
	rm -f $(NAME).aux $(NAME).bbl $(NAME).blg $(NAME).log $(NAME).out *~

distclean: clean
	rm -f $(NAME).html $(NAME).tex $(NAME).pdf
