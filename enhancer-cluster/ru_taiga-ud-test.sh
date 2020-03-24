#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "кого|кому|кто|какая|какие|каким|какими|каких|каков|какова|каково|каковы|какого|какое|какой|какому|какую|кем|кого|кому|которая|которое|которую|который|кто|чем|что|чего|чем|чему|что|чьи|чья|какая|какие|каким|какими|каких|каков|какова|каково|каковы|какого|какое|какой|каком|какому|какую|кем|кого|ком|кому|кот.|которая|которого|которое|которой|котором|которому|которую|которые|который|которым|которыми|которых|кто|некому|нечего|че|чего|чей|чем|чему|что|чье|чьего|чьей|чьи|чьим|чьих|чью|чья|чьё|чьём|чём|што" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Russian-Taiga/ru_taiga-ud-test.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Russian/ru.vectors > ../Data_for_Enhancer/OUT/UD_Russian-Taiga/ru_taiga-ud-test.conllu