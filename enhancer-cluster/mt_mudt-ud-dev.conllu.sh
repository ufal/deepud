#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "which" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Maltese-MUDT/mt_mudt-ud-dev.conllu > ../Data_for_Enhancer/OUT/UD_Maltese-MUDT/mt_mudt-ud-dev.conllu
