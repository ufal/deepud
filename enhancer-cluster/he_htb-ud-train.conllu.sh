#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "which" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Hebrew-HTB/he_htb-ud-train.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Hebrew/he.vectors > ../Data_for_Enhancer/OUT/UD_Hebrew-HTB/he_htb-ud-train.conllu
