#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "enquanto|nada|quem|quando|quantos|que|quem|segundo|tudo|apenas|como|conforme|cuja|cujas|cujo|cujos|enquanto|mais|nada|o|onde|os|qu|quais|qual|quando|quanto|quantos|que|quem|segundo|tudo" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Portuguese-Bosque/pt_bosque-ud-train.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Portuguese/pt.vectors > ../Data_for_Enhancer/OUT/UD_Portuguese-Bosque/pt_bosque-ud-train.conllu
