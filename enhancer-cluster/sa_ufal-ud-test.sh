#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "य|यं|यः|यत|यतः|यत्|यत्र|यथा|यदा|यद्|यस्मात्|यस्मिन्|यस्य|यस्या|या|यावत्|ये|येन|यो" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Sanskrit-UFAL/sa_ufal-ud-test.conllu > ../Data_for_Enhancer/OUT/UD_Sanskrit-UFAL/sa_ufal-ud-test.conllu
