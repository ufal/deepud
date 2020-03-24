#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "a" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Welsh-CCG/cy_ccg-ud-test.conllu > ../Data_for_Enhancer/OUT/UD_Welsh-CCG/cy_ccg-ud-test.conllu
