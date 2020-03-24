#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "quel|quelque|quels|quiex|qel|qual|quanz|quel|quele|quelque|quels|ques|quex|quiex|quéle" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Old_French-SRCMF/fro_srcmf-ud-dev.conllu > ../Data_for_Enhancer/OUT/UD_Old_French-SRCMF/fro_srcmf-ud-dev.conllu
