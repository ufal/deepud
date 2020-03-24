#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "што|якi|якая|якога|якое|якой|які|якім|якімі|якіх|якія" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Belarusian-HSE/be_hse-ud-train.conllu > ../Data_for_Enhancer/OUT/UD_Belarusian-HSE/be_hse-ud-train.conllu
