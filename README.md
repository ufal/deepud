1. Clone the CoreNLP repository (it contains the Stanford Enhancer) and build the project
https://github.com/stanfordnlp/CoreNLP
We use a version we built from CoreNLP GitHub (commit #5fdbfb2).
Our copy of CorNLP is at /net/work/people/droganova/CoreNLP.

Note: That folder also contains a shell script for each CoNLL-U file. It illustrates
how Kira processed the file. And the script can be submitted as a job to the cluster.
There is also a script called "create_jobs.py" that generates all the shell scripts,
including the script "enhance_them_all.sh", which submits the jobs to the cluster.



2. Obtain the official release of Universal Dependencies.
See https://universaldependencies.org/ for the permanent URI of the latest UD release.
At ÚFAL, we have all releases in /net/data, e.g.:
/net/data/universal-dependencies-2.5

We must exclude some UD treebanks:
6 treebanks because they have no text (copyright issues)

UD_Arabic-NYUAD
UD_English-ESL
UD_French-FTB
UD_Hindi_English-HIENCS
UD_Japanese-BCCWJ
UD_Mbya_Guarani-Dooley

19 others because their lemmatization is incomplete
(note that we do not exclude a treebank if it has automatically predicted lemmas):

UD_Bambara-CRB
UD_Cantonese-HK
UD_Chinese-HK
UD_Chinese-PUD
UD_French-PUD
UD_Hindi-PUD
UD_Indonesian-PUD
UD_Korean-PUD
UD_Maltese-MUDT
UD_Old_French-SRCMF
UD_Persian-Seraji
UD_Portuguese-GSD
UD_Portuguese-PUD
UD_Spanish-PUD
UD_Swedish_Sign_Language-SSLC
UD_Telugu-MTG
UD_Thai-PUD
UD_Turkish-PUD
UD_Uyghur-UDT

121 treebanks remain.
For the first version we use only automatically enhanced graphs, even in treebanks where some enhancements
are available. This is because it is not trivial to merge partial manual enhancements with automatic ones.

The following treebanks contain trusted annotation of all five
enhancement types (no enhancements are needed):

UD_Dutch-Alpino
UD_Dutch-LassySmall
UD_English-EWT
UD_English-PUD
UD_Swedish-PUD
UD_Swedish-Talbanken

For the rest of the UD v2.4 treebanks we remove the original enhanced annotation and run the enhancer.



3. To run the enhancer
java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "pron1|pron2" -conlluFile input_file.conllu -embeddings embedding_file.vectors > output_file.conllu

-embeddings is an optional parameter.
We use embeddings that were prepared for CoNLL 2017 Shared Task:
http://hdl.handle.net/11234/1-1989
Download like this (22 GB):
curl --remote-name-all https://lindat.mff.cuni.cz/repository/xmlui/bitstream/handle/11234/1-1989/word-embeddings-conll17.tar
We have an unpacked copy of the embeddings here:
/net/work/people/zeman/mrptask/sharedata/embeddings

-relativePronouns is an obligatory parameter.
For every language, we extract lists of relative pronouns relying on PronType feature (PronType=Rel; https://universaldependencies.org/u/feat/PronType.html#Rel).
If PronType feature is not available in neither of treebanks of a language, we run the enhancer with -relativePronouns "".

Data enhanced using the Stanford enhancer is here:
/net/work/people/droganova/Data_for_Enhancer/final_2.4



4. PACKAGE THE DATA FOR RELEASE IN LINDAT:
tar czf deep-ud-2.4-data.tgz deep
