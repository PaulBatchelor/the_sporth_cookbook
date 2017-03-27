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

ifdef SITEGEN_MAKEFILE
RECIPE_PAGES = $(addsuffix /index.md, $(addprefix proj/cook/recipes/,$(RECIPES)))
%.md: %.sp 
	perl proj/cook/format.pl $< > $@
else
RECIPE_PAGES = $(addsuffix /index.md, $(addprefix recipes/,$(RECIPES)))
default: all
all: $(RECIPE_PAGES)
%.md: %.sp 
	perl format.pl $< > $@
clean:
	rm -rf $(RECIPE_PAGES)
endif
