#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "che|chi|cui|che|chi|chiunque|cosa|donde|quanta|quanto|ch|cha|che|chi|chiunque|ciò|come|cosa|cui|donde|dov|dove|entrambi|essere|k|ke|laddove|le|ove|qual|quale|quali|quando|quanta|quante|quanti|quanto|que|stata|sé|tale|tanto" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Italian-VIT/it_vit-ud-test.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Italian/it.vectors > ../Data_for_Enhancer/OUT/UD_Italian-VIT/it_vit-ud-test.conllu
