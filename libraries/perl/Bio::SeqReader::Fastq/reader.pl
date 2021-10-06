#!/usr/bin/env perl

use 5.012;
use warnings;
use IO::File;
use IO::Uncompress::AnyUncompress;
use Bio::SeqReader::Fasta;
use Bio::SeqReader::Fastq;
use File::Basename;
my $from = dirname($0);

my $count_files = 0;
my $tot_seqs = 0;
my $tot_bases = 0;
my $max_length = 0;

for my $filename (@ARGV) {
    $count_files++;

    my $fh;
    my $reader;


    if ($filename =~ /\.gz$/) {
        $fh =  new IO::Uncompress::AnyUncompress( $filename );
    } else {
        $fh = new IO::File( $filename, 'r' );
    }

    if ($filename =~ /(\.fq|\.fastq)/) {
        $reader = Bio::SeqReader::Fastq->new( fh => $fh );
    } else {
        $reader = Bio::SeqReader::Fasta->new( fh => $fh );
    }

    my $count_seqs = 0;
    my $count_bases = 0;
    
    while ( my $s = $reader->next() ) {
        $count_seqs++;
        $count_bases += length($s->seq);
        $max_length = length($s->seq) if length($s->seq) > $max_length;
    }
    $tot_seqs += $count_seqs;
    $tot_bases += $count_bases;
}

say "Files=$count_files; Sequences=$tot_seqs; Bases=$tot_bases; Max=$max_length; From=$from";
# my $so = new Bio::SeqReader::FastqRecord(
#                 header1     => 'R_12345 read info ...',
#                 seqtext     => 'ACGTACGT',
#                 header2     => '',
#                 qualtext    => 'A@AA?#??'
#                 );
# Constructor with initial values
# my $so = new Bio::SeqReader::FastaRecord(
#                 display_id  => 'R_12345',
#                 description => 'Predicted kinase gene',
#                 seqtext     => 'ACGTACGT',
#                 );