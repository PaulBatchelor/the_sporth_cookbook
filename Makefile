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
		  waiting_room\
		  in_seven

UGENS = abs.md\
		adsr.md\
		atone.md\
		allpass.md\
		autowah.md\
		add.md\
		ampdb.md\
		bal.md\
		biscale.md\
		bitcrush.md\
		blsaw.md\
		blsquare.md\
		bltriangle.md\
		bpm2dur.md\
		bpm2rate.md\
		branch.md\
		brown.md\
		butbp.md\
		butbr.md\
		buthp.md\
		butlp.md\
		changed.md\
		crossfade.md\
		clip.md\
		clock.md\
		comb.md\
		count.md\
		dcblk.md\
		delay.md\
		dtrig.md\
		diode.md\
		diskin.md\
		dist.md\
		osc.md\
		oscmorph.md\
		posc3.md\
		tblrec.md\
		tabread.md\
		tone.md\
		tget.md\
		tseq.md\
		tset.md\

SIGNAL_SOUND = 00_sine.md

ifdef SITEGEN_MAKEFILE
RECIPE_PAGES = $(addsuffix /index.md, $(addprefix proj/cook/recipes/,$(RECIPES)))

UGEN_PAGES = $(addprefix proj/cook/ugens/,$(UGENS))
RECIPE_PAGES += $(UGEN_PAGES)

SIGNAL_SOUND_PAGES = $(addprefix proj/cook/signaltosound/,$(SIGNAL_SOUND))
RECIPE_PAGES += $(SIGNAL_SOUND_PAGES)

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
