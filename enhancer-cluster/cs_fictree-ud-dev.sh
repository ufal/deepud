#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "což|jenž|přičemž|zato|což|jehož|jejichž|jejíchž|jejíhož|jejímiž|jejímuž|jejímž|jejíž|jejž|jemuž|jenž|jež|jichž|jimiž|jimž|již|jímž|jíž|kterážto|kterýžto|nichž|nimiž|nimž|niž|nímž|nízko|níž|něhož|nějž|němuž|němž|něž|přičemž|qua|zato|čemuž|čehož|čemuž|čemž|čímž" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Czech-FicTree/cs_fictree-ud-dev.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Czech/cs.vectors > ../Data_for_Enhancer/OUT/UD_Czech-FicTree/cs_fictree-ud-dev.conllu
