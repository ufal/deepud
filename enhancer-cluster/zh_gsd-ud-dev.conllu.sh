#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "which" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Chinese-GSD/zh_gsd-ud-dev.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/ChineseT/zh.vectors > ../Data_for_Enhancer/OUT/UD_Chinese-GSD/zh_gsd-ud-dev.conllu
