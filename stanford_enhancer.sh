#!/bin/bash
# Applies the Stanford Enhancer to a CoNLL-U file.
# Argument is the path to the CoNLL-U file. The path must contain the name of the UD folder. We read the name of the language from it.
if [[ -z "$1" ]] ; then
  echo Usage: stanford_enhancer.sh data/enhanced/UD_Ancient_Greek-PROIEL/grc_proiel-ud-train.conllu
  exit 1
fi
# Fixed path to our installation of Stanford CoreNLP. We could also take it as an argument if desirable.
CORENLPDIR=/net/work/people/droganova/CoreNLP
DEEPUDDIR=/net/work/people/zeman/deepud
RELPRONDIR=$DEEPUDDIR/data/relpron
EMBEDDIR=$DEEPUDDIR/data/embeddings
TMPOUT=/COMP.TMP/$$.enhanced.conllu
if [[ -e "$TMPOUT" ]] ; then
  echo "$TMPOUT" already exists, giving up.
  exit 1
fi
language=`dirname $1 | perl -pe 's:-.+$::; s:^.*UD_::'`
relpron=`cat $RELPRONDIR/relpron-$language.txt`
if [[ -d "$EMBEDDIR/$language" ]] ; then
  embeddings=$EMBEDDIR/$language/`ls -1 $EMBEDDIR/$language | grep vectors`
  echo $1 '('$language, $relpron, $embeddings')'
  TMPVEC=/COMP.TMP/$$.vectors
  echo Extracting $embeddings to $TMPVEC...
  if [[ -e "$TMPVEC" ]] ; then
    echo "$TMPVEC" already exists, giving up.
    exit 1
  fi
  # Avoid running out of memory. Take only vectors of the 2 million most frequent words.
  xzcat $embeddings | head -2000000 > $TMPVEC
  java -mx4g -cp "$CORENLPDIR/*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "$relpron" -conlluFile $1 -embeddings $TMPVEC -numHid 100 | $DEEPUDDIR/tools/fix_stanford_enhancer.pl > $TMPOUT
  mv $TMPOUT $1
  rm -f $TMPVEC
else
  echo $1 '('$language, $relpron, NO EMBEDDINGS')'
  java -mx4g -cp "$CORENLPDIR/*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "$relpron" -conlluFile $1 -numHid 100 | $DEEPUDDIR/tools/fix_stanford_enhancer.pl > $TMPOUT
  mv $TMPOUT $1
fi
