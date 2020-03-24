#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "hdźež|kajke|kajki|kiž|kotraž|kotrehož|kotrejež|kotrejž|kotrež|kotrychž|kotrymiž|kotrymž|kotryž|kotřiž|čehoždla|čimž|štož" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Upper_Sorbian-UFAL/hsb_ufal-ud-train.conllu > ../Data_for_Enhancer/OUT/UD_Upper_Sorbian-UFAL/hsb_ufal-ud-train.conllu
