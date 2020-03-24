#!/bin/bash

java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns "ης|οποία|οποίας|οποίες|οποίο|οποίοι|οποίον|οποίος|οποίου|οποίους|οποίων|ος|που" -conlluFile ../Data_for_Enhancer/unEnhanced_2.4/UD_Greek-GDT/el_gdt-ud-dev.conllu -embeddings /net/work/people/zeman/mrptask/sharedata/embeddings/Greek/el.vectors > ../Data_for_Enhancer/OUT/UD_Greek-GDT/el_gdt-ud-dev.conllu
