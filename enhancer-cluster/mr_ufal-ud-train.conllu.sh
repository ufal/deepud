#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "जो|ते|तो" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Marathi-UFAL/mr_ufal-ud-train.conllu > ../Data_for_Enhancer/OUT/UD_Marathi-UFAL/mr_ufal-ud-train.conllu
