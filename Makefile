SHELL=/bin/bash
UDSRCDIR=/net/data/universal-dependencies-2.5
UDEXCLUDE=UD_Arabic-NYUAD UD_Bambara-CRB UD_Cantonese-HK UD_Chinese-HK UD_Chinese-PUD UD_English-ESL UD_French-FTB UD_French-PUD UD_Hindi-PUD UD_Hindi_English-HIENCS UD_Indonesian-PUD UD_Japanese-BCCWJ UD_Korean-PUD UD_Maltese-MUDT UD_Mbya_Guarani-Dooley UD_Old_French-SRCMF UD_Persian-Seraji UD_Portuguese-GSD UD_Portuguese-PUD UD_Spanish-PUD UD_Swedish_Sign_Language-SSLC UD_Swiss_German-UZH UD_Telugu-MTG UD_Thai-PUD UD_Turkish-PUD UD_Uyghur-UDT
# Every time we need to check the newly added treebanks. Do they have lemmas?
CORENLPDIR=/net/work/people/droganova/CoreNLP

fetch:
	mkdir -p data/ud
	cp -r $(UDSRCDIR)/UD_* data/ud
	cd data/ud ; rm -rf $(UDEXCLUDE)

languages:
	ls data/ud | perl -e 'while(<>) { $$x .= " " . $$_ } $$x =~ s/^\s+//s; $$x =~ s/\s+$$//s; @x=map{s/^UD_//; s/-.*//; $$_}(split(/\s+/,$$x)); foreach my $$x (@x) { $$x{$$x}++ } print(join(" ",sort(keys(%x))))' > data/languages.txt

# The Stanford Enhancer needs the list of relative pronouns for each language.
###!!! Forms or lemmas?
# Probably forms. See also /net/work/people/droganova/Data_for_Enhancer/rel_pronouns.
relpron:
	mkdir -p data/relpron
	for i in `cat data/languages.txt` ; do cat data/ud/UD_$$i*/*.conllu | perl -e 'while(<>) { if(m/^\d+\t/) { @f=split(/\t/); @pt=grep{/^PronType=/}(split(/\|/,$$f[5])); if(@pt && $$pt[0]=~/Rel/) { $$h{$$f[2]}++ } } } @k=sort(keys(%h)); print(join("|",@k))' > data/relpron/relpron-$$i.txt ; done

embeddings:
	cd data ; curl --remote-name-all https://lindat.mff.cuni.cz/repository/xmlui/bitstream/handle/11234/1-1989{/word-embeddings-conll17.tar,/conll2017-surprise-languages.zip}
	mkdir -p data/embeddings
	cd data/embeddings ; tar xf ../word-embeddings-conll17.tar ; ln -s Norwegian-Bokmaal Norwegian
	rm data/word-embeddings-conll17.tar
	for i in data/embeddings/*/*.vectors.xz ; do unxz $$i ; done
	# CoNLL 2017 surprise languages.
	cd data ; unzip conll2017-surprise-languages.zip
	rm data/conll2017-surprise-languages.zip
	udpipe --output=horizontal none --outfile {}.txt *.conllu
	lowercase
	concatenate files
	# https://code.google.com/archive/p/word2vec/ ... code.google.com is now archived, so the following copy may work:
	# https://github.com/tmikolov/word2vec ... but there are other implementations online, in many languages, and perhaps better maintained
	/home/zeman/nastroje/word2vec/word2vec -min-count 10 -size 100 -window 10 -negative 5 -iter 2 -threads 16 -cbow 0 -binary 0 -train INFILE -output OUTFILE

BXRDIR=data/conll2017-surprise-languages/UD_Buryat
KMRDIR=data/conll2017-surprise-languages/UD_Kurmanji
SMEDIR=data/conll2017-surprise-languages/UD_North_Sami
HSBDIR=data/conll2017-surprise-languages/UD_Upper_Sorbian

buryat:
	udpipe --train $(BXRDIR)/bxr.udpipe $(BXRDIR)/bxr-ud-sample.conllu
	udpipe --tokenize $(BXRDIR)/bxr.udpipe --output=horizontal < $(BXRDIR)/bxr-20161120-pages-articles-000.txt | perl -CSA -pe '$$_=lc($$_)' > $(BXRDIR)/bxr.tokenized.lowercased.txt
	/home/zeman/nastroje/word2vec/word2vec -min-count 10 -size 100 -window 10 -negative 5 -iter 2 -threads 16 -cbow 0 -binary 0 -train $(BXRDIR)/bxr.tokenized.lowercased.txt -output $(BXRDIR)/bxr.vectors

kurmanji:
	udpipe --train $(KMRDIR)/kmr.udpipe $(KMRDIR)/kmr-ud-sample.conllu
	udpipe --tokenize $(KMRDIR)/kmr.udpipe --output=horizontal < $(KMRDIR)/kmr-20161120-pages-articles-000.txt | perl -CSA -pe '$$_=lc($$_)' > $(KMRDIR)/kmr.tokenized.lowercased.txt
	/home/zeman/nastroje/word2vec/word2vec -min-count 10 -size 100 -window 10 -negative 5 -iter 2 -threads 16 -cbow 0 -binary 0 -train $(KMRDIR)/kmr.tokenized.lowercased.txt -output $(KMRDIR)/kmr.vectors

north_sami:
	udpipe --train $(SMEDIR)/sme.udpipe $(SMEDIR)/sme-ud-sample.conllu
	udpipe --tokenize $(SMEDIR)/sme.udpipe --output=horizontal < $(SMEDIR)/sme-20161120-pages-articles-000.txt | perl -CSA -pe '$$_=lc($$_)' > $(SMEDIR)/sme.tokenized.lowercased.txt
	/home/zeman/nastroje/word2vec/word2vec -min-count 10 -size 100 -window 10 -negative 5 -iter 2 -threads 16 -cbow 0 -binary 0 -train $(SMEDIR)/sme.tokenized.lowercased.txt -output $(SMEDIR)/sme.vectors

upper_sorbian:
	udpipe --train $(HSBDIR)/hsb.udpipe $(HSBDIR)/hsb-ud-sample.conllu
	udpipe --tokenize $(HSBDIR)/hsb.udpipe --output=horizontal < $(HSBDIR)/hsb-20161120-pages-articles-000.txt | perl -CSA -pe '$$_=lc($$_)' > $(HSBDIR)/hsb.tokenized.lowercased.txt
	/home/zeman/nastroje/word2vec/word2vec -min-count 10 -size 100 -window 10 -negative 5 -iter 2 -threads 16 -cbow 0 -binary 0 -train $(HSBDIR)/hsb.tokenized.lowercased.txt -output $(HSBDIR)/hsb.vectors

# The word embeddings from the CoNLL 2017 shared task always have a header line with two numbers:
# number of words, and number of dimensions. Stanford CoreNLP does not expect this line, so we must
# delete it!
# See also /net/work/people/droganova/CoreNLP/src/edu/stanford/nlp/neural/Embedding.java
emb_for_stanford:
	for i in data/embeddings/*/*.vectors ; do backup=`dirname $$i`/`basename $$i .vectors`.backup ; mv $$i $$backup ; cat $$backup | perl -e '$$x=<>; while(<>) {print}' > $$i ; done
	# cat it.backup | perl -pe '<>; while(<>) {print}' > it.vectors ; xz it.vectors

# Report languages for which we lack word embeddings.
check_embeddings:
	for i in `cat data/languages.txt` ; do if [[ ! -d data/embeddings/$$i ]] ; then echo Missing embeddings for language $$i. ; fi ; done

###!!!xzcat:

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
	for i in data/enhanced/UD_*/*.conllu ; do ./stanford_enhancer.sh $$i ; done

