#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "250g|anger|angers|brettstein|d|das|dem|den|denen|der|deren|derer|dessen|die|er|top|was|welch|welche|welchem|welcher|welches|wer" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_German-HDT/de_hdt-ud-test.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/German/de.vectors > ../Data_for_Enhancer/OUT/UD_German-HDT/de_hdt-ud-test.conllu
