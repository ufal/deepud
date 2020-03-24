#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "_|m|ma|التى|التي|الذى|الذي|الذين|اللاتى|اللاتي|اللتان|اللتين|اللذان|اللذين|اللواتي|اَلَّذِي|ما|ماهو|ماهُوَ" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Arabic-NYUAD/ar_nyuad-ud-train.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Arabic/ar.vectors > ../Data_for_Enhancer/OUT/UD_Arabic-NYUAD/ar_nyuad-ud-train.conllu
