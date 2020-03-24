#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "which" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Romanian-Nonstandard/ro_nonstandard-ud-dev.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Romanian/ro.vectors > ../Data_for_Enhancer/OUT/UD_Romanian-Nonstandard/ro_nonstandard-ud-dev.conllu