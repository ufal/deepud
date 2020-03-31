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
    # Czech data occasionally contains a lemma with an explanatory comment which
    # should have been removed but was not because of missing closing bracket.
    # Stanford Enhancer copies it to the enhanced dependency label but it contains
    # characters that must not occur there:
    # 4:conj:and_^(obv._souč._anglických_názvů,_"a"
    # We cannot remove it completely because we might remove something legitimate
    # in other languages (and the error should be fixed elsewhere). But we must
    # remove non-letter, non-underscore characters.
    if(m/^\d+(\.\d+)?\t/)
    {
        my @f = split(/\t/, $_);
        my @deps = split(/\|/, $f[8]);
        foreach my $dep (@deps)
        {
            my @parts = split(/:/, $dep);
            # Only the last part is affected by the error.
            $parts[-1] =~ s/[^_\p{Ll}\p{Lm}\p{Lo}\p{M}]//g;
            if($parts[-1] eq '')
            {
                pop(@parts);
            }
            # Even if we had to remove the last part, there must be other parts, so we should be fine now.
            $dep = join(':', @parts);
        }
        $f[8] = join('|', @deps);
        $_ = join("\t", @f);
    }
    print;
}
