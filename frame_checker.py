#!/usr/bin/env python3

"""
Show available frames for a given verb.

"""

import os
from argparse import ArgumentParser
import re

def parse_arguments():
    parser = ArgumentParser(description='Show available frames for a given verb')
    parser.add_argument('-v', '--verb', metavar='VERB',
                        type=str, action='store',
                        default=None, dest='verb',
                        help='lemma of a target verb', required=True)
    parser.add_argument('-t', '--treebanks', metavar='TREEBANKS',
                        type=str, action='store',
                        default=None, dest='treebanks',
                        help='treebank/treebanks to search', required=True)

    args = parser.parse_args()
    return args

def get_fnames(treebanks_raw, ext):
    treebanks_files_list = []
    treebanks = treebanks_raw.strip().split('+')

    for treebank in treebanks:
        for root, subdirs, fnames in os.walk(treebank):
            for fname in fnames:
                if fname.endswith(ext):
                    treebanks_files_list.append(os.path.join(root, fname))

    return treebanks_files_list

def main(verb, treebanks_raw):
    """
    """
    frames = []
    template = '\t' + verb + '\t'
    treebanks = get_fnames(treebanks_raw, '.conllup')
    print(treebanks)
    for treebank_file in treebanks:
        with open(treebank_file, 'r') as in_file:
            sentences = in_file.read().strip().split('\n\n')
            for sentence in sentences:
                if re.search(template, sentence) is not None:
                    tokens = sentence.strip().split('\n')
                    for token in tokens:
                        if template in token:
                            args = token.strip().split('\t')[11].split('|')
                            if args != ['_']:
                                args_updated = []
                                for arg in args:
                                    _num, _id = arg.strip().split(':')
                                    if ',' in _id:
                                        _id = _id.strip().split(',')[0]
                                    for t in tokens:
                                        if not t.startswith('#') and t.strip().split('\t')[0] == _id:
                                            rel = t.strip().split('\t')[8].split('|')[0].split(':')[1]
                                            case = t.strip().split('\t')[5].split('|')[0]
                                            if not case.startswith('Case='):
                                                case = ''
                                            else:
                                                case = ':' + case
                                            args_updated.append(_num + ':' + rel + case)
                                            if 'arg1:root' in args_updated:
                                                print(sentence)
                                            break
                                if args_updated not in frames:
                                    frames.append(args_updated)
    for frame in frames:
        print(frame)
                                                                  
if __name__ == "__main__":
    args = parse_arguments()
    main(args.verb, args.treebanks)
