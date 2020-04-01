#!/usr/bin/env perl
# Fixes specific errors made by the Stanford Enhancer (without it, the enhanced output is not valid CoNLL-U).
# Copyright © 2020 Dan Zeman <zeman@ufal.mff.cuni.cz>
# License: GNU GPL

use utf8;
use open ':utf8';
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
binmode(STDERR, ':utf8');

my $text = '';
my $mwt_until;
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
            $parts[-1] =~ s/^_+//;
            $parts[-1] =~ s/_+$//;
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
    # If there is a SpaceAfter=No on the initial line of a multi-word token,
    # the Stanford Enhancer drops it.
    if(m/^\#\s*text\s*=\s*(.+)$/)
    {
        # Remember the current sentence text.
        $text = $1;
        $text =~ s/\r?\n$//;
    }
    elsif(m/^\d+-(\d+)\t/)
    {
        my $new_mwt_until = $1;
        # Another error of the Stanford Enhancer is that it copies the multi-word-token
        # line if it generates an empty node that is a copy of one of the words inside
        # the MWT span. So if we see an interval while another interval is still in
        # effect, we will ignore it and NOT pass it to the output. Note that the
        # other interval must have the same "until" value because we cannot exclude
        # the possibility that there are two subsequent and valid multi-word tokens.
        if(defined($mwt_until) && $mwt_until == $new_mwt_until)
        {
            next;
        }
        $mwt_until = $new_mwt_until;
        my @f = split(/\t/, $_);
        my $form = $f[1];
        if(substr($text, 0, length($form)) eq $form)
        {
            $text = substr($text, length($form));
        }
        if($text !~ s/^\s+//)
        {
            # There is no space after the current token. Make sure that it is
            # indicated in the MISC column.
            my $misc = $f[9];
            $misc =~ s/\r?\n$//;
            if($misc eq '_')
            {
                $misc = 'SpaceAfter=No';
            }
            else
            {
                my @misc = split(/\|/, $misc);
                if(!grep {$_ eq 'SpaceAfter=No'} (@misc))
                {
                    push(@misc, 'SpaceAfter=No');
                }
                $misc = join('|', @misc);
            }
            $f[9] = $misc."\n";
        }
        $_ = join("\t", @f);
    }
    elsif(m/^(\d+)\t/ && !(defined($mwt_until) && $1<=$mwt_until))
    {
        $mwt_until = undef;
        # We do not expect SpaceAfter errors at normal tokens and we do not try to fix them.
        # But we still must consume the prefix of the sentence text to keep it synchronized.
        my @f = split(/\t/, $_);
        my $form = $f[1];
        if(substr($text, 0, length($form)) eq $form)
        {
            $text = substr($text, length($form));
        }
        $text =~ s/^\s+//;
    }
    elsif(m/^\s*$/)
    {
        $mwt_until = undef;
        $text = undef;
    }
    # The Stanford Enhancer occasionally generates a graph without root. It seems
    # that it forgets the 0:root relation when the node is at the same time the
    # target of a newly added *:relsubj relation. However, the guidelines do not
    # say that the original parent link should disappear, regardless whether it
    # is 0:root or something else. (This error was observed in Italian ISDT.)
    if(m/^\d+\t.+\t0\troot\t/)
    {
        my @f = split(/\t/, $_);
        # To be safe, double-check that "0\troot" really appears in the expected columns.
        if($f[6] eq '0' && $f[7] eq 'root')
        {
            my @deps = split(/\|/, $f[8]);
            if(!grep {m/^0:root(:|$)/} (@deps))
            {
                unshift(@deps, '0:root');
            }
            $f[8] = join('|', @deps);
        }
        $_ = join("\t", @f);
    }
    print;
}
