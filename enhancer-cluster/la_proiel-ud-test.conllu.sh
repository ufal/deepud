#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "cui|cuius|qvae|qua|quae|quaecunque|quam|quanto|quapropter|quare|quarum|quas|quem|qui|quibus|quicquid|quicumque|quo|quocirca|quod|quorum|quos|ubi|ut|vbi|ad|cui|cuicumque|cuius|cujus|cum|modum|ob|prout|qua|quacumque|quae|quaecumque|qualem|quales|quali|qualibus|qualis|quam|quamcumque|quamdiu|quamobrem|quando|quanta|quantam|quantas|quanto|quantum|quantus|quapropter|quare|quarum|quas|quatenus|quem|quemadmodum|quemcumque|qui|quibus|quibuscumque|quicquid|quicumque|quid|quis|quisquis|quo|quoad|quocirca|quocumque|quod|quodcumque|quoi|quoius|quom|quomodo|quoque|quoquo|quorum|quos|quoscumque|quot|quotiens|quotienscumque|quotquot|quotus|re|rem|sicut|tamquam|ubi|ubicumque|unde|ut|uter|uti|utro" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Latin-PROIEL/la_proiel-ud-test.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Latin/la.vectors > ../Data_for_Enhancer/OUT/UD_Latin-PROIEL/la_proiel-ud-test.conllu
