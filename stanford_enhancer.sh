#!/bin/bash
# Applies the Stanford Enhancer to a CoNLL-U file.
# Argument is the path to the CoNLL-U file. The path must contain the name of the UD folder. We read the name of the language from it.
if [[ -z "$1" ]] ; then
  echo Usage: stanford_enhancer.sh data/enhanced/UD_Ancient_Greek-PROIEL/grc_proiel-ud-train.conllu
  exit 1
fi
# Fixed path to our installation of Stanford CoreNLP. We could also take it as an argument if desirable.
CORENLPDIR=/net/work/people/droganova/CoreNLP
language=`dirname $1 | perl -pe 's:-.+$::; s:^.*UD_::'`
relpron=`cat data/relpron/relpron-$language.txt`
if [[ -d "data/embeddings/$language" ]] ; then
  embeddings=data/embeddings/$language/`ls -1 data/embeddings/$language | grep vectors`
  echo $1 '('$language, $relpron, $embeddings')'
  xzcat $embeddings > data/current.vectors
  java -mx4g -cp "$CORENLPDIR/*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "$relpron" -conlluFile $1 -embeddings data/current.vectors -numHid 100 > enhanced.conllu
  mv enhanced.conllu $1
  rm -f data/current.vectors
else
  echo $1 '('$language, $relpron, NO EMBEDDINGS')'
  java -mx4g -cp "$CORENLPDIR/*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "$relpron" -conlluFile $1 -numHid 100 > enhanced.conllu
  mv enhanced.conllu $1
fi
