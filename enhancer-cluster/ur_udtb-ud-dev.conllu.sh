#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "which" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Urdu-UDTB/ur_udtb-ud-dev.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Urdu/ur.vectors > ../Data_for_Enhancer/OUT/UD_Urdu-UDTB/ur_udtb-ud-dev.conllu
