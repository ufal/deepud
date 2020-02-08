SHELL=/bin/bash
UDSRCDIR=/net/data/universal-dependencies-2.5
UDEXCLUDE=UD_Arabic-NYUAD UD_Bambara-CRB UD_Cantonese-HK UD_Chinese-HK UD_Chinese-PUD UD_English-ESL UD_French-FTB UD_French-PUD UD_Hindi-PUD UD_Hindi_English-HIENCS UD_Indonesian-PUD UD_Japanese-BCCWJ UD_Korean-PUD UD_Maltese-MUDT UD_Mbya_Guarani-Dooley UD_Old_French-SRCMF UD_Persian-Seraji UD_Portuguese-GSD UD_Portuguese-PUD UD_Spanish-PUD UD_Swedish_Sign_Language-SSLC UD_Swiss_German-UZH UD_Telugu-MTG UD_Thai-PUD UD_Turkish-PUD UD_Uyghur-UDT
# Every time we need to check the newly added treebanks. Do they have lemmas?
CORENLPDIR=/net/work/people/droganova/CoreNLP

fetch:
	mkdir -p data/ud
	cp -r $(UDSRCDIR)/UD_* data/ud
	cd data/ud ; rm -rf $(UDEXCLUDE)

# The Stanford Enhancer needs the list of relative pronouns for each language.
###!!! Forms or lemmas?
# Probably forms. See also /net/work/people/droganova/Data_for_Enhancer/rel_pronouns.
relpron:
	mkdir -p data/relpron
	ls data/ud | perl -e 'while(<>) { $$x .= " " . $$_ } $$x =~ s/^\s+//s; $$x =~ s/\s+$$//s; @x=map{s/^UD_//; s/-.*//; $$_}(split(/\s+/,$$x)); foreach my $$x (@x) { $$x{$$x}++ } print(join(" ",sort(keys(%x))))' > data/languages.txt
	for i in `cat data/languages.txt` ; do cat data/ud/UD_$$i*/*.conllu | perl -e 'while(<>) { if(m/^\d+\t/) { @f=split(/\t/); @pt=grep{/^PronType=/}(split(/\|/,$$f[5])); if(@pt && $$pt[0]=~/Rel/) { $$h{$$f[2]}++ } } } @k=sort(keys(%h)); print(join("|",@k))' > data/relpron/relpron-$$i.txt ; done

embeddings:
	cd data ; curl --remote-name-all https://lindat.mff.cuni.cz/repository/xmlui/bitstream/handle/11234/1-1989/word-embeddings-conll17.tar
	mkdir -p data/embeddings
	cd data/embeddings ; tar xf ../word-embeddings-conll17.tar ; ln -s Norwegian-Bokmaal Norwegian
	rm data/word-embeddings-conll17.tar
	for i in data/embeddings/*/*.vectors.xz ; do unxz $i ; done

# Remove enhanced graphs from UD-released treebanks (except the trusted ones).
nodeps:
	mkdir -p data/nodeps
	rm -rf data/nodeps/UD_*
	cp -r data/ud/UD_* data/nodeps
	for i in data/nodeps/UD_*/*.conllu ; do echo $$i ; cat $$i | perl -pe 'if(m/^\d+\t/) { @f=split(/\t/); $$f[8]="_"; $$_=join("\t",@f); }' > nodeps ; mv nodeps $$i ; done

# Apply the Stanford Enhancer to the treebanks.
enhance:
	mkdir -p data/enhanced
	rm -rf data/enhanced/UD_*
	cp -r data/nodeps/UD_* data/enhanced
	for i in data/enhanced/UD_*/*.conllu ; do language=`dirname $$i | perl -pe 's:-.+$::; s:^.*UD_::'` ; relpron=`cat data/relpron/relpron-$$language.txt` ; embeddings=data/embeddings/ echo $$i '('$$language, $$relpron')' ; echo java -mx4g -cp $(CORENLPDIR) edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "$$relpron" -conlluFile input_file.conllu -embeddings embedding_file.vectors > enhanced.conllu ; mv enhanced.conllu $$i ; done
