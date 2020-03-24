#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "जो" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Hindi-HDTB/hi_hdtb-ud-train.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Hindi/hi.vectors > ../Data_for_Enhancer/OUT/UD_Hindi-HDTB/hi_hdtb-ud-train.conllu
