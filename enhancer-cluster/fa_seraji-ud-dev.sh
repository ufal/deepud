#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "آنچه" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Persian-Seraji/fa_seraji-ud-dev.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Persian/fa.vectors > ../Data_for_Enhancer/OUT/UD_Persian-Seraji/fa_seraji-ud-dev.conllu
