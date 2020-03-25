#!/usr/bin/env perl
# Runs add_pas.pl in a loop over all UD treebanks.
# Copyright © 2019 Dan Zeman <zeman@ufal.mff.cuni.cz>
# License: GNU GPL

use utf8;
use open ':utf8';
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
binmode(STDERR, ':utf8');

my $os = 'unix'; # windows|unix
my $projekty;
my $pathslash;
my $nooutput;
# Dan's laptop:
if($os eq 'windows')
{
    $projekty = 'C:/Users/Dan/Documents/Lingvistika/Projekty';
    $pathslash = "\\";
    $nooutput = 'NIL:';
}
# Dan's working folder on ÚFAL network:
else
{
    $projekty = '/net/work/people/zeman';
    $pathslash = '/';
    $nooutput = '/dev/null';
}
my $tools = "$projekty/deepud/tools";
my $enhanced = "$projekty/deepud/data/enhanced";
my $workdeep = "$projekty/deepud/data/deep"; # release 2.4 is in a local git on Dan's laptop in $projekty/wdeep
my $release = 'http://hdl.handle.net/11234/1-3105'; # UD release 2.5
opendir(DIR, $enhanced) or die("Cannot read folder $enhanced: $!");
my @folders = sort(grep {m/^UD_/} (readdir(DIR)));
closedir(DIR);
foreach my $folder (@folders)
{
    next unless($folder eq 'UD_English-EWT'); ###!!!
    opendir(DIR, "$enhanced/$folder") or die("Cannot read folder $enhanced/$folder: $!");
    my @files = grep {m/\.conllu$/} (readdir(DIR));
    closedir(DIR);
    foreach my $file (@files)
    {
        print STDERR ("$folder/$file\n");
        my $outpath = $workdeep.$pathslash.$folder.$pathslash.$file.'p';
        system("perl -I $tools $tools/add_pas.pl --udpath $enhanced --release $release --folder $folder --file $file >$outpath 2>$nooutput");
    }
    print STDERR ("$folder/all.log");
    my $outpath = $workdeep.$pathslash.$folder.$pathslash.'all.log';
    system("perl -I $tools $tools/add_pas.pl --udpath $workdeep --release $release --folder $folder --file all.conllu >$nooutput 2>$outpath");
}
