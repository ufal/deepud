#!/usr/bin/env python

"""
Create jobs.

echo conlluFile
java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer -relativePronouns ["which"] -conlluFile [.conllu] -embeddings [lang.vectors] > 

qsub -cwd -j y -l mem_free=6G,act_mem_free=6G,h_vmem=8G -M droganova@ufal.mff.cuni.cz -m conllu_file_name.sh

"""

import os
from argparse import ArgumentParser
from collections import defaultdict

treebanks_to_omit = ['UD_Arabic-NYUAD', 'UD_English-ESL', 'UD_Hindi_English-HIENCS', 'UD_French-FTB', 'UD_Japanese-BCCWJ', 'UD_Mbya_Guarani-Dooley'] 

def parse_arguments():
    parser = ArgumentParser(description='Extract relative pronouns (PronType=Rel)')
    parser.add_argument('-i', '--input-directory', metavar='INPUT_DIR',
                        type=str, action='store',
                        default=None, dest='input_directory',
                        help='input directory', required=True)
    parser.add_argument('-o', '--output-directory', metavar='OUTPUT_DIR',
                        type=str, action='store',
                        default=None, dest='output_directory',
                        help='output directory', required=True)
    parser.add_argument('-e', '--embeddings-directory', metavar='EMBEDDINGS_DIR',
                        type=str, action='store',
                        default=None, dest='embeddings_directory',
                        help='embeddings directory', required=True)
    parser.add_argument('-r', '--pronouns-directory', metavar='PRON_DIR',
                        type=str, action='store',
                        default=None, dest='pronouns_directory',
                        help='relative pronouns directory', required=True)

    args = parser.parse_args()
    return args

def get_fnames(ifolder, ofolder, ext):
    ifname_list, ofname_list = [], []
    for root, subdirs, fnames in os.walk(ifolder):
        for fname in fnames:
            if fname.endswith(ext):
                ifname_list.append(os.path.join(root, fname))
                osubfolder = root.replace(ifolder, ofolder)
                if not os.path.exists(osubfolder):
	                os.makedirs(osubfolder)
                ofname_list.append(os.path.join(osubfolder, fname))
    return ifname_list, ofname_list

def main(embeddings, pronouns, ifiles, ofiles):
    """
    Process all files in ifiles list.
    Output into ofiles list.
    """
    pron_lang_list = []
    for root, subdirs, fnames in os.walk(pronouns):
        for fname in fnames:
            pron_lang_list.append(os.path.join(root, fname))

    embeddings_list = []
    for root, subdirs, fnames in os.walk(embeddings):
        for fname in fnames:
            if fname.endswith('.vectors'):
                embeddings_list.append(os.path.join(root, fname))

    const_part_all = 'qsub -cwd -j y -l mem_free=10G,act_mem_free=10G,h_vmem=12G -M droganova@ufal.mff.cuni.cz -m beas '
    const_part_treebank = 'java -mx4g -cp "*" edu.stanford.nlp.trees.ud.UniversalEnhancer '

    with open('enhance_them_all.sh', 'w') as all_file:
        all_file.write('#!/bin/bash' + '\n\n')

        for ifname, ofname in zip(ifiles, ofiles):
            conllu_parameter = '-conlluFile ' + ifname + ' ' # 2nd

            head, tail = os.path.split(ofname)

            all_file.write(const_part_all + tail + '.sh\n')

            embeddings_lang = tail.strip().split('_')[0]
            pronoun_lang = head.split('/')[-1].split('-')[0].replace('UD_', '')

            for elem in pron_lang_list:
                print(head, '||', pronoun_lang, '||', elem)
                elem_temp = elem.strip().split("/")[-1].split('-')[0]
                print(elem_temp)
                if pronoun_lang == elem_temp:
                    _file = open(elem, 'r')
                    relP = _file.read()
                    _file.close()
                    relP_parameter = '-relativePronouns "' + relP + '" ' # 1st
                    break
            else:
                relP_parameter = '-relativePronouns "which" ' # 1st

            for elem in embeddings_list:
                elem_temp = elem.strip().split('.')[0]
                if elem_temp.endswith(embeddings_lang):
                    emb_parameter = '-embeddings ' + elem + ' > ' + ofname # 3rd and 4th
                    break
            else:
                 emb_parameter = '> ' + ofname # 4th without 3rd


            with open(tail + '.sh', 'w') as treebank_file:
                treebank_file.write('#!/bin/bash' + '\n\n')
                line = const_part_treebank + relP_parameter + conllu_parameter + emb_parameter
                treebank_file.write(line)
                treebank_file.write('\n')

def wrapper(embeddings, pronouns, ifolder, ofolder):
	main(embeddings, pronouns, *get_fnames(ifolder, ofolder, '.conllu'))

if __name__ == "__main__":
    args = parse_arguments()
    wrapper(args.embeddings_directory, args.pronouns_directory, args.input_directory, args.output_directory)

