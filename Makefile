.DEFAULT_GOAL := ch_analizer.hfst

ch_analizer.hfst: ch_generator.hfst
	hfst-invert $< -o $@
ch_generator.hfst: ch_lexd.hfst ch_twol.hfst
	hfst-compose-intersect $^ -o $@
ch_lexd.hfst: ch.lexd
	lexd $< | hfst-txt2fst -o $@
ch_twol.hfst: ch.twol
	hfst-twolc $< -o $@
ch.lexd: $(wildcard *ch.lexd)
	cat *ch.lexd > ch.lexd
#test.pass.txt: ch_tests.csv
#	awk -F, '$$3 == "pass" {print $$1 ":" $$2}' $^ | sort -u > $@
#test: ch_generator.hfst test.pass.txt
#	bash compare.sh $< test.pass.txt; rm test.*
clean:
	rm *.hfst
#count_forms: write_forms_count
#	hfst-fst2strings ch_analizer.hfst | wc -l
#write_forms_count: ch_analizer.hfst
#	sed -i "$$(cat README.md | wc -l)s/^.*$$/$$(hfst-fst2strings ch_analizer.hfst | wc -l)/" README.md
