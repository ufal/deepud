#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "which" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Telugu-MTG/te_mtg-ud-train.conllu > ../Data_for_Enhancer/OUT/UD_Telugu-MTG/te_mtg-ud-train.conllu
