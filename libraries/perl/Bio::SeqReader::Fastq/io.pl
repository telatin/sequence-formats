
die "Missing filename\n" unless -e $ARGV[0];
my $fh = new IO::File($ARGV[0]);

while (my $line = readline($fh) ) {
  print "$line";
  exit;
}
