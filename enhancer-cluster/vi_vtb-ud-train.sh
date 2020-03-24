#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "which" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Vietnamese-VTB/vi_vtb-ud-train.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Vietnamese/vi.vectors > ../Data_for_Enhancer/OUT/UD_Vietnamese-VTB/vi_vtb-ud-train.conllu