DOC= \
	 hello \
	 fm \
	 distant_intelligence \
	 crystalline \
	 kLtz \
	 scheale \

DOC_CREATE=$(addsuffix _create,$(DOC))
DOC_CLEAN=$(addsuffix _clean,$(DOC))

default: $(DOC_CREATE)

%_create: 
	make -f Makefile.main N=$(subst _create,,$@)

%_clean: 
	make -f Makefile.main N=$(subst _clean,,$@) clean


clean:
	make $(DOC_CLEAN)
