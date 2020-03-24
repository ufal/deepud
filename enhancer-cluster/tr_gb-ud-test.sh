#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "which" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Turkish-GB/tr_gb-ud-test.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Turkish/tr.vectors > ../Data_for_Enhancer/OUT/UD_Turkish-GB/tr_gb-ud-test.conllu
