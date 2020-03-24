#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "kas|kam|kas|ko|kuras|kuriem|kuru|kam|kas|ko|kura|kurai|kuram|kuras|kuri|kuriem|kuros|kuru|kurus|kurā|kurām|kurās|kurš|kā|kāda|kādam|kādas|kādi|kādos|kāds|kādu|kādus|kādā|kādām|kādās|pats|pašu" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Latvian-LVTB/lv_lvtb-ud-dev.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Latvian/lv.vectors > ../Data_for_Enhancer/OUT/UD_Latvian-LVTB/lv_lvtb-ud-dev.conllu
