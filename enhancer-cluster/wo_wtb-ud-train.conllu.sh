#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "ba|bi|bu|fu|gi|gu|ju|ki|ku|la|li|lii|lu|yu|ba|bee|bi|bii|boobale|boobee|boobii|boobu|bu|fa|fi|fu|ga|gee|gi|gii|googee|googu|gu|ja|ji|jii|jooju|ju|ka|ki|ku|la|li|lol|loolu|lu|ma|mi|mii|mu|si|soosii|su|wa|wi|wii|wu|ya|yi|yii|yooyu|yoy|yu|ña|ñi|ñu|ña|ñi|ñooñu|ñu" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Wolof-WTB/wo_wtb-ud-train.conllu > ../Data_for_Enhancer/OUT/UD_Wolof-WTB/wo_wtb-ud-train.conllu
