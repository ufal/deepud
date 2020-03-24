#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "något|som|vad|vilka|vilken|de|man|någon|något|som|vad|vars|vilka|vilkas|vilken|vilket" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Swedish-LinES/sv_lines-ud-train.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Swedish/sv.vectors > ../Data_for_Enhancer/OUT/UD_Swedish-LinES/sv_lines-ud-train.conllu
