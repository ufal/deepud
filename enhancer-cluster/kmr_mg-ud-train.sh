#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "ku|kû|çi" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Kurmanji-MG/kmr_mg-ud-train.conllu > ../Data_for_Enhancer/OUT/UD_Kurmanji-MG/kmr_mg-ud-train.conllu
