#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "cando|como|quen|cal|cales|cando|cantas|canto|cantos|como|cuxa|cuxas|cuxo|onde|que|quen" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Galician-TreeGal/gl_treegal-ud-train.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Galician/gl.vectors > ../Data_for_Enhancer/OUT/UD_Galician-TreeGal/gl_treegal-ud-train.conllu
