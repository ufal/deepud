#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "a|ar|ba|nár|a|ab|ar|atá|atáid|atáimse|ba|bhíos|bí|caoin|chaoinfeas|chuireas|cuir|eireos|faoi|faoina|fhéadas|féad|i|ina|inar|is|le|lean|leanas|lena|lenar|n-a|nach|ná|nár|nárbh|o|rachas|shíleas|síl|tagas|tarlaigh|thagas|tharlós|théas|téigh|éirigh|ó" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Irish-IDT/ga_idt-ud-test.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Irish/ga.vectors > ../Data_for_Enhancer/OUT/UD_Irish-IDT/ga_idt-ud-test.conllu
