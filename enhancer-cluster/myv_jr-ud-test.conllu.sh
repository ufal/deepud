#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "зярдо|конат|конатань|конатнень|знярдо|зняро|зярдо|зярс|кие|кить|ков|кода|кодамо|козонь|кона|конадонть|конанень|конань|конась|конат|коната|конатань|конатнеде|конатненень|конатнесэ|косо|кува|мезе|мезесь" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Erzya-JR/myv_jr-ud-test.conllu > ../Data_for_Enhancer/OUT/UD_Erzya-JR/myv_jr-ud-test.conllu
