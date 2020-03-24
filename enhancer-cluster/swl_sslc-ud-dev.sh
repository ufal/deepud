#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "which" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Swedish_Sign_Language-SSLC/swl_sslc-ud-dev.conllu > ../Data_for_Enhancer/OUT/UD_Swedish_Sign_Language-SSLC/swl_sslc-ud-dev.conllu
