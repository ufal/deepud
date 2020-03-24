#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "geaid|geain|gean|geas|geasa|geat|gii|goabbá|guhte|guđe|guđet|maid|maidda|maiguin|main|mainna|man|mas|masa|mat|mii" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_North_Sami-Giella/sme_giella-ud-train.conllu > ../Data_for_Enhancer/OUT/UD_North_Sami-Giella/sme_giella-ud-train.conllu
