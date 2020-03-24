#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "ið|sum" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Faroese-OFT/fo_oft-ud-test.conllu > ../Data_for_Enhancer/OUT/UD_Faroese-OFT/fo_oft-ud-test.conllu
