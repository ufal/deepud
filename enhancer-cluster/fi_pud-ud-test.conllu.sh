#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "joille|joka|jolla|jolle|josta|joten|jotka|kenellä|kuka|mihin|mikä|missä|mistä|mitä|johon|joiden|joihin|joilla|joille|joilta|joina|joissa|joista|joita|joka|joksi|jolla|jollainen|jollaiseksi|jollaisen|jollaiset|jollaisia|jollaisissa|jollaista|jolle|jolloin|jolta|jona|jonka|jonne|jossa|josta|jota|joten|jotka|ketä|kuka|mihin|miksi|mikä|mikäpä|mille|milloin|millon|millä|miltä|minkä|minne|minnekkä|mis|missä|mist|mistä|miten|mitkä|mitä|mitä-" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Finnish-PUD/fi_pud-ud-test.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Finnish/fi.vectors > ../Data_for_Enhancer/OUT/UD_Finnish-PUD/fi_pud-ud-test.conllu
