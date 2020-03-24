#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "min|minw|mun|mín|mîn" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Bambara-CRB/bm_crb-ud-test.conllu > ../Data_for_Enhancer/OUT/UD_Bambara-CRB/bm_crb-ud-test.conllu
