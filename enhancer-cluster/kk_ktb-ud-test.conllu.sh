#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "which" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Kazakh-KTB/kk_ktb-ud-test.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Kazakh/kk.vectors > ../Data_for_Enhancer/OUT/UD_Kazakh-KTB/kk_ktb-ud-test.conllu
