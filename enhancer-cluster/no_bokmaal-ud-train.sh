#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "som" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Norwegian-Bokmaal/no_bokmaal-ud-train.conllu > ../Data_for_Enhancer/OUT/UD_Norwegian-Bokmaal/no_bokmaal-ud-train.conllu
