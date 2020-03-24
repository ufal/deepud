#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "on|que|qui|què|com|on|qual|quals|quan|que|qui|què" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Catalan-AnCora/ca_ancora-ud-dev.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Catalan/ca.vectors > ../Data_for_Enhancer/OUT/UD_Catalan-AnCora/ca_ancora-ud-dev.conllu
