#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "which" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Mbya_Guarani-Dooley/gun_dooley-ud-test.conllu > ../Data_for_Enhancer/OUT/UD_Mbya_Guarani-Dooley/gun_dooley-ud-test.conllu
