#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "berkat|bila|demikian|jadi|manakala|saat|sebelum|sedangkan|yang|agar|bahwa|berkat|bila|bilamana|demikian|jadi|kemudian|ketika|maka|manakala|saat|saatnya|sebelum|sedangkan|sehubungan|sementara|yang|yg" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Indonesian-GSD/id_gsd-ud-train.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Indonesian/id.vectors > ../Data_for_Enhancer/OUT/UD_Indonesian-GSD/id_gsd-ud-train.conllu
