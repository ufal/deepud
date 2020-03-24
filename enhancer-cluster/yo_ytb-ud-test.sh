#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "tí" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Yoruba-YTB/yo_ytb-ud-test.conllu > ../Data_for_Enhancer/OUT/UD_Yoruba-YTB/yo_ytb-ud-test.conllu
