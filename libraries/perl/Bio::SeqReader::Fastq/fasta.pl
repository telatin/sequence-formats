use 5.012;
use warnings;
use Bio::SeqReader::Fasta;

die "Missing input file\n" unless -e "$ARGV[0]";
print STDERR "Reading $ARGV[0]\n";

# Read a FASTA file from stdin
#open(my $fh, "$ARGV[0]") || die;
my $fh1 = new IO::File( "$ARGV[0]" );
my $in =  Bio::SeqReader::Fasta->new( fh => $fh1 );
my $c++;
while ( my $so = $in->next() ) {
    $c++;   
    print $c, "\t",  $so->display_id(), "\n";
}
