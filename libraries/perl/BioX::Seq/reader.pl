#!/usr/bin/env perl

use 5.012;
use warnings;
use BioX::Seq::Stream;
use File::Basename;
my $from = dirname($0);
my $tot = 0;
my $len = 0;

my $count_files = 0;
my $tot_seqs = 0;
my $tot_bases = 0;
my $max_length = 0;

for my $filename (@ARGV) {
    my $parser = BioX::Seq::Stream->new( $filename );
    my $total_seqs = 0;
    my $total_bases = 0;
    while (my $seq = $parser->next_seq) {
        $total_seqs++;;
        $max_length = length($seq->seq) if length($seq->seq) > $max_length;
        $total_bases += length($seq->seq);
    }
    $count_files++;
    $tot_seqs += $total_seqs;
    $tot_bases += $total_bases;   
}
say "Files=$count_files; Sequences=$tot_seqs; Bases=$tot_bases; Max=$max_length; From=$from";