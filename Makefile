RECIPES = scheale\
		  fm\
		  kLtz\
		  crystalline\
		  distant_intelligence\
		  bones\
		  chatting_robot\
		  sugar\
		  oatmeal\
		  minions\
		  machines_at_work\
		  midnight_crawl\
		  density\
		  playwithtoys\
		  waiting_room

UGENS = atone.md

ifdef SITEGEN_MAKEFILE
RECIPE_PAGES = $(addsuffix /index.md, $(addprefix proj/cook/recipes/,$(RECIPES)))
UGEN_PAGES = $(addprefix proj/cook/ugens/,$(UGENS))
RECIPE_PAGES += $(UGEN_PAGES)

%.md: %.sp 
	perl proj/cook/format.pl $< > $@

else
RECIPE_PAGES = $(addsuffix /index.md, $(addprefix recipes/,$(RECIPES)))
UGEN_PAGES = $(addprefix ugens/,$(UGENS))
RECIPE_PAGES += $(UGEN_PAGES)

default: all
all: $(RECIPE_PAGES)
%.md: %.sp 
	perl format.pl $< > $@
clean:
	rm -rf $(RECIPE_PAGES)
endif
