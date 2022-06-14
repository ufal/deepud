#!/usr/bin/env perl
# Checks a UD release for treebanks that are suitable to be included in DeepUD.
# Copyright © 2022 Dan Zeman <zeman@ufal.mff.cuni.cz>
# License: GNU GPL

use utf8;
use open ':utf8';
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
binmode(STDERR, ':utf8');
# From the UD tools repository:
use udlib;

# This should later become a commandline argument.
my $path = '/net/data/universal-dependencies-2.10'; ###!!!/UD_*/README*
my @folders = udlib::list_ud_folders($path);
my $n = scalar(@folders);
my $n_notext = 0;
my $n_nolemma = 0;
my $n_selected = 0;
foreach my $folder (@folders)
{
    my $metadata = udlib::read_readme($folder, $path);
    if($metadata->{'Includes text'} =~ m/^no/i)
    {
        $n_notext++;
    }
    elsif($metadata->{'Lemmas'} =~ m/^not available$/i)
    {
        $n_nolemma++;
    }
    else
    {
        $n_selected++;
    }
}
print("$n total treebanks found\n");
print("$n_notext treebanks omitted because the underlying text is not available\n");
print("$n_nolemma treebanks omitted (out of those that have text) because they do not have lemmas\n");
print("$n_selected treebanks remain for Deep UD\n");
