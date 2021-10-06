#!/usr/bin/env perl

use 5.012;
use warnings;
use Bio::SeqIO;
use File::Basename;
my $from = dirname($0); 
my $count_files = 0;
my $tot_seqs = 0;
my $tot_bases = 0;
my $max_length = 0;

for my $filename (@ARGV) {
    
    my $format = $filename =~ /(\.fq|\.fastq)/ ? 'fastq' : 'fasta';
    my $gzipped = $filename =~ /\.gz$/ ? 1 : 0;

    my $seqio_object;
    my $fh;
   
    if ($gzipped) {
        $fh = IO::File->new("zcat $filename |");
        $seqio_object = Bio::SeqIO->new(-fh => $fh,
                                        -format => "$format");
    } else {
        $seqio_object = Bio::SeqIO->new(-file => "$filename",
                                        -format => "$format");
    }
    my $total_seqs = 0;
    my $total_bases = 0;

    while (my $seq_object = $seqio_object->next_seq) {
        $total_seqs++;
        $max_length = length($seq_object->seq) if length($seq_object->seq) > $max_length;
        $total_bases += length($seq_object->seq);
    }
    $count_files++;
    $tot_seqs += $total_seqs;
    $tot_bases += $total_bases;

}
say "Files=$count_files; Sequences=$tot_seqs; Bases=$tot_bases; Max=$max_length; From=$from";
