#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "which" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Japanese-Modern/ja_modern-ud-test.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Japanese/ja.vectors > ../Data_for_Enhancer/OUT/UD_Japanese-Modern/ja_modern-ud-test.conllu
