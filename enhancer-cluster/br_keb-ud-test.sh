#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "a|ar pezh|ar pezh a|re" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Breton-KEB/br_keb-ud-test.conllu > ../Data_for_Enhancer/OUT/UD_Breton-KEB/br_keb-ud-test.conllu
