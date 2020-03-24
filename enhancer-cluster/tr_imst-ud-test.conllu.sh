#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "which" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Turkish-IMST/tr_imst-ud-test.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Turkish/tr.vectors > ../Data_for_Enhancer/OUT/UD_Turkish-IMST/tr_imst-ud-test.conllu
