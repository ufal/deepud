#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "which" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Classical_Chinese-Kyoto/lzh_kyoto-ud-train.conllu > ../Data_for_Enhancer/OUT/UD_Classical_Chinese-Kyoto/lzh_kyoto-ud-train.conllu