The Stanford Enhancer is used to generate enhanced graphs for those UD v2.4 corpora that lack them.
We use a version we built from CoreNLP GitHub (commit #5fdbfb2).

1. Clone the CoreNLP repository and build the project
https://github.com/stanfordnlp/CoreNLP

2. Download Universal Dependencies 2.4
https://lindat.mff.cuni.cz/repository/xmlui/handle/11234/1-2988

Data enhanced using the Stanford enhancer is here:
/lnet/spec/work/people/droganova/Data_for_Enhancer/final_2.4

It has been pruned and some treebanks are missing:
6 treebanks because they have no text (copyright issues)
19 others because their lemmatization is incomplete:

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
https://lindat.mff.cuni.cz/repository/xmlui/handle/11234/1-1989

-relativePronouns is an obligatory parameter.
For every language, we extract lists of relative pronouns relying on PronType feature (PronType=Rel; https://universaldependencies.org/u/feat/PronType.html#Rel).
If PronType feature is not available in neither of treebanks of a language, we run the enhancer with -relativePronouns "".

4. PACKAGE THE DATA FOR RELEASE IN LINDAT:
tar czf deep-ud-2.4-data.tgz deep
