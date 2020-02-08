UDSRCDIR=/net/data/universal-dependencies-2.5
UDEXCLUDE=UD_Arabic-NYUAD UD_Bambara-CRB UD_Cantonese-HK UD_Chinese-HK UD_Chinese-PUD UD_English-ESL UD_French-FTB UD_French-PUD UD_Hindi-PUD UD_Hindi_English-HIENCS UD_Indonesian-PUD UD_Japanese-BCCWJ UD_Korean-PUD UD_Maltese-MUDT UD_Mbya_Guarani-Dooley UD_Old_French-SRCMF UD_Persian-Seraji UD_Portuguese-GSD UD_Portuguese-PUD UD_Spanish-PUD UD_Swedish_Sign_Language-SSLC UD_Telugu-MTG UD_Thai-PUD UD_Turkish-PUD UD_Uyghur-UDT

fetch:
	mkdir -p data/ud
	cp -r $(UDSRCDIR)/UD_* data/ud
	cd data/ud ; rm -rf $(UDEXCLUDE)

# The Stanford Enhancer needs the list of relative pronouns for each language.
###!!! Forms or lemmas?
getrelprons:
	cat data/ud/UD_Czech*/*.conllu | perl -e 'while(<>) { if(m/^\d+\t/) { @f=split(/\t/); @pt=grep{/^PronType=/}(split(/\|/,$$f[5])); if(@pt && $$pt[0]=~/Rel/) { $$h{$$f[1]}++ } } } @k=sort(keys(%h)); print(join("|",@k),"\n")'

