SPORTHDOT=~/proj/sporth/util/sporthdot

NAME=$(N)/$(N)

default: $(NAME).pdf

$(NAME).dot: $(NAME).sp
	$(SPORTHDOT) $^ > $@

$(NAME).ps: $(NAME).dot
	dot -Tps $^ > $@

$(NAME).tex: $(NAME).sp
	cat $^ | perl format.pl $^ | smutex > $@

$(NAME)_doc.tex:
	gcc -DNAME=$(NAME) -x c -E doc.template | sed /^\#/d > $@



$(NAME).pdf: $(NAME)_doc.tex $(NAME).ps $(NAME).tex
	latex $^ 
	dvipdf `basename $(NAME)`_doc.dvi tmp.pdf
	rm *.dvi *.aux *.log
	mv tmp.pdf $(NAME).pdf

clean: 
	rm -rf $(NAME).dot 
	rm -rf $(NAME).dvi 
	rm -rf $(NAME).aux 
	rm -rf $(NAME).tex 
	rm -rf $(NAME).log
	rm -rf $(NAME).ps
	rm -rf $(NAME).pdf
	rm -rf $(NAME)_doc.tex
	rm -rf $(NAME).sp.code
	rm -rf *.dot 
	rm -rf *.dvi 
	rm -rf *.aux 
	rm -rf *.tex 
	rm -rf *.log
	rm -rf *.ps
	rm -rf *.pdf
	rm -rf *_doc.tex
	rm -rf *.sp.code

