#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "that|that|when|who|what|where|which|who|why|how|that|were|what|when|where|whereby|wherein|whhich|which|who|whom|whose|why" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_English-ESL/en_esl-ud-train.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/English/en.vectors > ../Data_for_Enhancer/OUT/UD_English-ESL/en_esl-ud-train.conllu
