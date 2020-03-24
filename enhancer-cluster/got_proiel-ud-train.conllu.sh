#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "saei|ei|ikei|ize|izei|izwizei|juzei|jūzei|saei|sei|soei|swaswe|swe|þadei|þaiei|þaimei|þammei|þan|þane|þanei|þanuh|þanzei|þarei|þatei|þaþroei|þei|þizaiei|þize|þizeei|þizei|þizeiei|þizozei|þoei|þoze|þozei|þuei|þuzei|ƕaiwa|ƕan" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Gothic-PROIEL/got_proiel-ud-train.conllu > ../Data_for_Enhancer/OUT/UD_Gothic-PROIEL/got_proiel-ud-train.conllu
