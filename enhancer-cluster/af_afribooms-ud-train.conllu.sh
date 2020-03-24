#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "daarbenewens|daarna|daarom|dieselfde|hierbenewens|hierdeur|hiermee|hiervolgens|toe|waar|wanneer|wannneer|wat|daaraan|daarbenewens|daarby|daardeur|daarin|daarmee|daarna|daarom|daaroor|daarop|daarteen|daartoe|daarvan|daarvoor|dat|dieselfde|hierbenewens|hierbo|hierby|hierdeur|hierin|hiermee|hieronder|hieroor|hierop|hiervan|hiervolgens|hoe|hoekom|hoeveel|so|sodanig|sodanige|só|toe|waar|waaraan|waarby|waardeur|waarheen|waarin|waarmee|waarna|waarom|waaronder|waaroor|waarop|waarteen|waartoe|waartydens|waaruit|waarvan|waarvolgens|waarvoor|wanneer|wannneer|wat|watter|wie" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Afrikaans-AfriBooms/af_afribooms-ud-train.conllu > ../Data_for_Enhancer/OUT/UD_Afrikaans-AfriBooms/af_afribooms-ud-train.conllu
