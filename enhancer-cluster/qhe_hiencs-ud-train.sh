#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "which" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Hindi_English-HIENCS/qhe_hiencs-ud-train.conllu > ../Data_for_Enhancer/OUT/UD_Hindi_English-HIENCS/qhe_hiencs-ud-train.conllu
