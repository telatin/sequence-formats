#!/usr/bin/env perl

use 5.012;
use warnings;
use Getopt::Long;
use FAST::Bio::SeqIO;
use File::Basename;
my $from = dirname($0);
my $count_files = 0;
my $tot_seqs = 0;
my $tot_bases = 0;
my $max_length = 0;

for my $filename (@ARGV) {
    my $format = $filename =~ /(\.fastq|\.fq)/ ? 'fastq' : 'fasta';
    my $gzipped = $filename =~ /\.gz$/ ? 1 : 0;
    my $in;
    if ($gzipped) {
        my $fh = IO::File->new("gzip -dc $filename |") or die "Can't open $filename: $!";
        $in  = FAST::Bio::SeqIO->new(-fh=>$fh,
                                -format=>"$format");
    } else {
        $in  = FAST::Bio::SeqIO->new(-file => "$filename" ,
                                    -format => "$format");
    }
    my $total_seqs = 0;
    my $total_bases = 0;
    while ( my $seq = $in->next_seq() ) {

        $total_seqs++;
        $max_length = $seq->length() if $seq->length() > $max_length;
        $total_bases += $seq->length();
    }
    $count_files++;
    $tot_seqs += $total_seqs;
    $tot_bases += $total_bases;
}
say "Files=$count_files; Sequences=$tot_seqs; Bases=$tot_bases; Max=$max_length; From=$from";
  