#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "ինչ|ինչպես|ինչպիսին|որոնց|որքան|երբ|ինչ|ինչը|ինչի|ինչպես|ինչպիսի|ինչպիսին|ինչպիսիք|ինչքան|ով|ովքեր|որ|որը|որի|որին|որից|որն|որոն|որոնց|որոնցից|որոնցով|որոնք|որով|որում|որտեղ|որտեղից|որքան|ուր" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Armenian-ArmTDP/hy_armtdp-ud-train.conllu > ../Data_for_Enhancer/OUT/UD_Armenian-ArmTDP/hy_armtdp-ud-train.conllu
