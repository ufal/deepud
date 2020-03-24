#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "co|co|gdzie|jaki|które|którego|kiedy|kto|który|co|czego|czemu|czym|gdzie|jacy|jak|jaka|jaki|jakich|jakie|jakiego|jakiej|jakiemu|jakim|jakimi|jaką|kiedy|kim|kogo|komu|kto|ktora|ktore|która|które|którego|której|któremu|który|których|którym|którymi|którzy|którą|skąd" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Polish-PDB/pl_pdb-ud-train.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Polish/pl.vectors > ../Data_for_Enhancer/OUT/UD_Polish-PDB/pl_pdb-ud-train.conllu
