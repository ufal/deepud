SHELL=/bin/bash
RELEASE=2.10
UDSRCDIR=/net/data/universal-dependencies-$(RELEASE)
UDEXCLUDE=UD_Arabic-NYUAD UD_Arabic-PUD UD_Beja-NSC UD_Chinese-CFL UD_Chinese-HK UD_Chinese-PUD UD_Chukchi-HSE UD_English-ESL UD_English-GUMReddit UD_French-FTB UD_French-PUD UD_Frisian_Dutch-Fame UD_Hindi-PUD UD_Hindi_English-HIENCS UD_Italian-PUD UD_Japanese-BCCWJ UD_Japanese-BCCWJLUW UD_Korean-PUD UD_Maltese-MUDT UD_Mbya_Guarani-Dooley UD_Old_French-SRCMF UD_Old_Turkish-Tonqq UD_Portuguese-PUD UD_Spanish-PUD UD_Swedish_Sign_Language-SSLC UD_Swiss_German-UZH UD_Thai-PUD
# Every time we need to check the newly added treebanks. Do they have lemmas? Do they have text?
# Occasionally we should also check the previously excluded treebanks. Maybe lemmas have been added to some of them?
#   tools/select_treebanks_for_deepud.pl
CORENLPDIR=/net/work/people/droganova/CoreNLP

# It is recommended to run make all |& tee make.log
# The 'enhance' step assumes we can submit jobs to the cluster via qsub!
# We currently do not wait for the cluster jobs to finish, meaning that the steps after 'enhance' must be invoked separately.
all_until_enhance: fetch languages relpron check_embeddings nodeps enhance

all_after_enhance: enhanced_stats patch_with_basic patch_with_trusted validate deep pack

fetch:
	rm -rf data/ud
	mkdir -p data/ud
	cp -r $(UDSRCDIR)/UD_* data/ud
	cd data/ud ; rm -rf $(UDEXCLUDE)

languages:
	ls data/ud | perl -e 'while(<>) { $$x .= " " . $$_ } $$x =~ s/^\s+//s; $$x =~ s/\s+$$//s; @x=map{s/^UD_//; s/-.*//; $$_}(split(/\s+/,$$x)); foreach my $$x (@x) { $$x{$$x}++ } print(join(" ",sort(keys(%x))))' > data/languages.txt

# The Stanford Enhancer needs the list of relative pronouns for each language.
# It is not clear whether the pronouns should be forms or lemmas, but probably it should be forms.
# See also /net/work/people/droganova/Data_for_Enhancer/rel_pronouns.
relpron:
	mkdir -p data/relpron
	for i in `cat data/languages.txt` ; do cat data/ud/UD_$$i*/*.conllu | perl -e 'while(<>) { if(m/^\d+\t/) { @f=split(/\t/); @pt=grep{/^PronType=/}(split(/\|/,$$f[5])); if(@pt && $$pt[0]=~/Rel/) { $$h{$$f[2]}++ } } } @k=sort(keys(%h)); print(join("|",@k))' > data/relpron/relpron-$$i.txt ; done

embeddings:
	cd data ; curl --remote-name-all https://lindat.mff.cuni.cz/repository/xmlui/bitstream/handle/11234/1-1989{/word-embeddings-conll17.tar,/conll2017-surprise-languages.zip}
	mkdir -p data/embeddings
	cd data/embeddings ; tar xf ../word-embeddings-conll17.tar ; ln -s Norwegian-Bokmaal Norwegian ; ln -s ChineseT Chinese
	rm data/word-embeddings-conll17.tar
	for i in data/embeddings/*/*.vectors.xz ; do unxz $$i ; done
	# CoNLL 2017 surprise languages.
	cd data ; unzip conll2017-surprise-languages.zip
	rm data/conll2017-surprise-languages.zip
	make buryat
	make kurmanji
	make north_sami
	make upper_sorbian
	rm -rf data/embeddings/{Buryat,Kurmanji,North_Sami,Upper_Sorbian}
	mkdir data/embeddings/Buryat
	cat data/conll2017-surprise-languages/UD_Buryat/bxr.vectors | xz > data/embeddings/Buryat/bxr.vectors.xz
	mkdir data/embeddings/Kurmanji
	cat data/conll2017-surprise-languages/UD_Kurmanji/kmr.vectors | xz > data/embeddings/Kurmanji/kmr.vectors.xz
	mkdir data/embeddings/North_Sami
	cat data/conll2017-surprise-languages/UD_North_Sami/sme.vectors | xz > data/embeddings/North_Sami/sme.vectors.xz
	mkdir data/embeddings/Upper_Sorbian
	cat data/conll2017-surprise-languages/UD_Upper_Sorbian/hsb.vectors | xz > data/embeddings/Upper_Sorbian/hsb.vectors.xz
	# Jenže teď chci s těmito jazyky udělat ještě tohle, protože s ostatními už je to uděláno:
	# backup=`dirname $$i`/`basename $$i .vectors`.backup ; mv $$i $$backup ; cat $$backup | perl -e '$$x=<>; while(<>) {print}' > $$i
	# tedy:
	# cat data/conll2017-surprise-languages/UD_Upper_Sorbian/hsb.vectors | perl -e '<>; while(<>) {print}' | xz > data/embeddings/Upper_Sorbian/hsb.vectors.xz

BXRDIR=data/conll2017-surprise-languages/UD_Buryat
KMRDIR=data/conll2017-surprise-languages/UD_Kurmanji
SMEDIR=data/conll2017-surprise-languages/UD_North_Sami
HSBDIR=data/conll2017-surprise-languages/UD_Upper_Sorbian
# https://code.google.com/archive/p/word2vec/ ... code.google.com is now archived, so the following copy may work:
# https://github.com/tmikolov/word2vec ... but there are other implementations online, in many languages, and perhaps better maintained

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

# Remove enhanced graphs from UD-released treebanks.
# We do it even to the trusted treebanks but we will later not use their Stanford enhancements.
nodeps:
	mkdir -p data/nodeps
	rm -rf data/nodeps/UD_*
	cp -r data/ud/UD_* data/nodeps
	for i in data/nodeps/UD_*/*.conllu ; do echo $$i ; cat $$i | perl -pe 'if(m/^\d+\t/) { @f=split(/\t/); $$f[8]="_"; $$_=join("\t",@f); }' > nodeps ; mv nodeps $$i ; done

# Apply the Stanford Enhancer to the treebanks. This step assumes we can submit jobs to the cluster via qsub!
# Note that stanford_enhancer.sh calls fix_stanford_enhancer.pl to fix validation errors caused by the Stanford Enhancer.
enhance:
	mkdir -p data/enhanced
	rm -rf data/enhanced/UD_*
	cp -r data/nodeps/UD_* data/enhanced
	mkdir -p enhancer-cluster
	cd enhancer-cluster ; for i in ../data/enhanced/UD_*/*.conllu ; do script=`basename $$i .conllu`.sh ; ( echo ../stanford_enhancer.sh $$i > $$script ) ; chmod 755 $$script ; git add $$script ; qsub -cwd -j y -l mem_free=10G,act_mem_free=10G,h_vmem=12G -m n $$script ; done

# Check the cluster log files for Stanford Enhancer errors.
check_enhancement_errors:
	echo Problems with graphs: `grep 'Problem with graph' enhancer-cluster/*.o* | wc -l`
	grep -iP 'error|exception' enhancer-cluster/*.o*

# If the following target says, e.g., Need to rerun data/nodeps/UD_Ancient_Greek-PROIEL/grc_proiel-ud-train.conllu src=187033 tgt=123484,
# we may qrsh to a cluster machine and then run:
# pushd enhancer-cluster ; ./grc_proiel-ud-train.sh ; popd
# However, if the error is that the Stanford enhancer crashes on particular data, rerunning it will not help.
check_enhancement_wcc:
	for i in data/nodeps/UD_* ; do echo ; echo `basename $$i` ; for j in $$i/*.conllu ; do echo `basename $$j` ; wc_conll.pl $$j ; wc_conll.pl data/enhanced/`basename $$i`/`basename $$j` ; done ; done
	for i in data/nodeps/UD_* ; do for j in $$i/*.conllu ; do k=data/enhanced/`basename $$i`/`basename $$j` ; src=`wc_conll.pl $$j | perl -pe 's/^.*, (\d+) tokens.*$$/\1/ or $$_=0'` ; tgt=`wc_conll.pl $$k | perl -pe 's/^.*, (\d+) tokens.*$$/\1/ or $$_=0'` ; if [[ "$$src" != "$$tgt" ]] ; then echo Need to rerun $$j src=$$src tgt=$$tgt ; fi ; done ; done

enhanced_stats:
	( for i in data/enhanced/UD_* ; do echo $$i ; ( cat $$i/*.conllu | enhanced_graph_properties.pl ) ; echo ; done ) |& tee estats.log

# Make sure every file in "enhanced" contains all tokens and has something valid in the DEPS column.
# If the Stanford Enhancer crashed, copy the basic tree to DEPS.
patch_with_basic:
	for i in data/nodeps/UD_* ; do for j in $$i/*.conllu ; do k=data/enhanced/`basename $$i`/`basename $$j` ; src=`wc_conll.pl $$j | perl -pe 's/^.*, (\d+) tokens.*$$/\1/ or $$_=0'` ; tgt=`wc_conll.pl $$k | perl -pe 's/^.*, (\d+) tokens.*$$/\1/ or $$_=0'` ; if [[ "$$src" != "$$tgt" ]] ; then echo $$j to $$k ; ( cat $$j | conllu-copy-basic-to-enhanced.pl > $$k ) ; fi ; done ; done

# For languages for which we have trusted full enhanced annotation, replace the
# output of the Stanford Enhancer with the trusted annotation.
patch_with_trusted:
	cp data/ud/UD_Belarusian-HSE/*.conllu data/enhanced/UD_Belarusian-HSE
	cp data/ud/UD_Czech-CAC/*.conllu data/enhanced/UD_Czech-CAC
	cp data/ud/UD_Czech-FicTree/*.conllu data/enhanced/UD_Czech-FicTree
	cp data/ud/UD_Czech-PDT/*.conllu data/enhanced/UD_Czech-PDT
	cp data/ud/UD_Dutch-Alpino/*.conllu data/enhanced/UD_Dutch-Alpino
	cp data/ud/UD_Dutch-LassySmall/*.conllu data/enhanced/UD_Dutch-LassySmall
	cp data/ud/UD_English-EWT/*.conllu data/enhanced/UD_English-EWT
	cp data/ud/UD_English-GUM/*.conllu data/enhanced/UD_English-GUM
	cp data/ud/UD_English-PUD/*.conllu data/enhanced/UD_English-PUD
	cp data/ud/UD_Italian-ISDT/*.conllu data/enhanced/UD_Italian-ISDT
	cp data/ud/UD_Lithuanian-ALKSNIS/*.conllu data/enhanced/UD_Lithuanian-ALKSNIS
	cp data/ud/UD_Slovak-SNK/*.conllu data/enhanced/UD_Slovak-SNK
	cp data/ud/UD_Swedish-Talbanken/*.conllu data/enhanced/UD_Swedish-Talbanken
	cp data/ud/UD_Swedish-PUD/*.conllu data/enhanced/UD_Swedish-PUD

# It is recommended to run make validate |& tee validate.log, as there are many files to be validated,
# and errors may be overlooked.
validate:
	for i in data/enhanced/UD_*/*.conllu ; do echo $$i ; validate.py --level 2 --lang ud $$i ; done

deep:
	rm -rf data/deep
	cp -r data/enhanced data/deep
	for i in data/deep/UD_* ; do pushd $$i ; cat *.conllu > all.conllu ; popd ; done
	tools/add_pas_to_all.pl

# We will need the list of languages and the size (sentences, tokens, words) when publishing the package in Lindat.
pack:
	cd data ; tar czf deep-ud-$(RELEASE)-data.tgz deep
	cat data/languages.txt
	cat data/deep/UD_*/all.conllu | wc_conll.pl
