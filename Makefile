.DEFAULT_GOAL := ch_analizer.hfst

ch_analizer.hfst: ch_generator.hfst
	hfst-invert $< -o $@
ch_generator.hfst: ch_lexd.hfst ch_twol.hfst
	hfst-compose-intersect $^ -o $@
ch_lexd.hfst: ch_lexd.lexd
	lexd $< | hfst-txt2fst -o $@
ch_twol.hfst: ch.twol
	hfst-twolc $< -o $@
ch_lexd.lexd: $(wildcard *ch.lexd)
	cat *ch.lexd > ch_lexd.lexd
clean:
	rm *.hfst
	rm ch_lexd.lexd

# Чтобы всё запустить: hfst-fst2strings