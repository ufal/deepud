#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "30 000|aucun|aucune|beaucoup|chacun|ce|cela|certaines|certains|chacun|cinq|deux|dont|nul|où|personne|peu|plusieurs|qu'|quarante|quatre|que|qui|quid|rien|six|tous|tout|trois|un|une|_|aucun|auquel|auxquelles|auxquels|beaucoup|ce|certain|chacun|cinq|deux|dont|laquelle|lequel|lesquelles|lesquels|nul|ou|oà|où|personne|peu|plusieurs|qu'|quatre|que|qui|quoi|rien|six|tout|trois|un" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_French-Sequoia/fr_sequoia-ud-test.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/French/fr.vectors > ../Data_for_Enhancer/OUT/UD_French-Sequoia/fr_sequoia-ud-test.conllu
