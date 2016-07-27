DOC= \
	 hello \
	 fm \

.PHONY: $(DOC)


default: $(DOC)

fm: 
	make -f Makefile.main N=$@

fm_clean: 
	make -f Makefile.main N=$@ clean

hello: 
	make -f Makefile.main N=$@

hello_clean: 
	make -f Makefile.main N=$@ clean

