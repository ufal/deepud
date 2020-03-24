#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "which" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Korean-Kaist/ko_kaist-ud-dev.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Korean/ko.vectors > ../Data_for_Enhancer/OUT/UD_Korean-Kaist/ko_kaist-ud-dev.conllu
