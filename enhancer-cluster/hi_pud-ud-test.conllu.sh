#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "जो" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Hindi-PUD/hi_pud-ud-test.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Hindi/hi.vectors > ../Data_for_Enhancer/OUT/UD_Hindi-PUD/hi_pud-ud-test.conllu
