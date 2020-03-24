#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "егда|егоже|емоуже|е҅гда|егда|егдаже|егоже|еже|еиже|елико|еликоже|емоуже|еѩже|еѭже|иде|идеже|иждеже|иже|имъже|имьже|ихъже|и҅же|како|къде|кѫѭ|кꙑи|негоже|неже|неиже|нелиже|немъже|немьже|неѩже|неѩ҅же|нимъже|нихъже|ньже|нюже|нѣже|нѧже|нѭдѫже|нѭже|одънелиже|отъ|отънѥлиже|хъже|іже|ѣже|ѣкаже|ѣко|ѣкоже|ѣможе|ѣцѣмъ|ѣцѣхъ|ѥгда|ѥгдаже|ѥлико|ѥликоже|ѥликъ|ѩже|ѭдоуже|ѭже|ѭ҄доуже|ѭ҄же|ꙇже|ꙇдеже|ꙇже|ꙇмъже|ꙇмьже|ꙇхъже|ꙇ҅.|ꙇ҅деже|ꙇ҅же|ꙇ҅хъже|ꙗко|ꙗкоже|ꙗкъ|ꙗкъже|ꙗможе" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Old_Church_Slavonic-PROIEL/cu_proiel-ud-train.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Old_Church_Slavonic/cu.vectors > ../Data_for_Enhancer/OUT/UD_Old_Church_Slavonic-PROIEL/cu_proiel-ud-train.conllu
