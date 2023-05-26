#!/usr/bin/env perl
# Checks a UD release for treebanks that are suitable to be included in DeepUD.
# Copyright © 2022, 2023 Dan Zeman <zeman@ufal.mff.cuni.cz>
# License: GNU GPL

use utf8;
use open ':utf8';
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
binmode(STDERR, ':utf8');
use Getopt::Long;
# From the UD tools repository:
use udlib;

sub usage
{
    print STDERR ("Usage: $0 --udpath /net/data/universal-dependencies-2.12\n");
}

my $udpath; # released data, e.g., at ÚFAL: /net/data/universal-dependencies-2.12
GetOptions
(
    'udpath=s' => \$udpath
);
if(!defined($udpath))
{
    usage();
    die("Unknown path to the released Universal Dependencies data");
}

my @folders = udlib::list_ud_folders($udpath);
my $n = scalar(@folders);
my $n_notext = 0;
my $n_nolemma = 0;
my $n_selected = 0;
my @exclude = ();
foreach my $folder (@folders)
{
    my $metadata = udlib::read_readme($folder, $udpath);
    if($metadata->{'Includes text'} =~ m/^no/i)
    {
        $n_notext++;
        push(@exclude, $folder);
    }
    elsif($metadata->{'Lemmas'} =~ m/^not available$/i)
    {
        $n_nolemma++;
        push(@exclude, $folder);
    }
    else
    {
        $n_selected++;
    }
}
print("$n total treebanks found in $udpath\n");
print("$n_notext treebanks omitted because the underlying text is not available\n");
print("$n_nolemma treebanks omitted (out of those that have text) because they do not have lemmas\n");
print("$n_selected treebanks remain for Deep UD\n");
# We will need the list of treebanks to exclude for the Makefile.
print("Replace the UDEXCLUDE variable assignment in the Makefile with the following:\n");
print("UDEXCLUDE=".join(' ', @exclude)."\n");
