#!/usr/bin/env perl
# Fixes specific errors made by the Stanford Enhancer (without it, the enhanced output is not valid CoNLL-U).
# Copyright © 2020 Dan Zeman <zeman@ufal.mff.cuni.cz>
# License: GNU GPL

use utf8;
use open ':utf8';
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
binmode(STDERR, ':utf8');

while(<>)
{
    # When generating empty nodes, Stanford Enhancer copies a non-empty node with
    # everything including possible SpaceAfter=No (which is not allowed with empty
    # nodes).
    if(m/^\d+\.\d+\t/)
    {
        s/\r?\n$//;
        my $line = $_;
        my @f = split(/\t/, $line);
        my @misc = grep {$_ ne 'SpaceAfter=No'} (split(/\|/, $f[9]));
        push(@misc, '_') if(scalar(@misc)==0);
        $f[9] = join('|', @misc);
        $line = join("\t", @f);
        $_ = $line."\n";
    }
    print;
}
