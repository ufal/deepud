#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "die|hetgeen|dat|die|hetgeen|hetgene|hetwelk" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Dutch-LassySmall/nl_lassysmall-ud-dev.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Dutch/nl.vectors > ../Data_for_Enhancer/OUT/UD_Dutch-LassySmall/nl_lassysmall-ud-dev.conllu
