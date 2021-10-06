for DIR in *;
do
  if [ -d $DIR ];
    then
        # Add $DIR to array
        DIRS[${#DIRS[@]}]=$DIR
   fi
done

if [[ -e $1 ]]; then 
  FASTA=$1
else
    echo "Usage: $0 <fasta file>"
    exit 1
fi
echo "Benchmarking sequence formats"
echo "============================="
echo "Running benchmarks for:"

set -euo pipefail
# combine all arguments $@ into one string
ARGS=$@
# Remove double quotes
ARGS=${ARGS//\"/}

echo "  $ARGS"
perl BioPerl/reader.pl $@ 2> /dev/null
perl Bio::SeqReader::Fastq/reader.pl $@ 2> /dev/null
perl BioX::Seq/reader.pl $@ 2> /dev/null
perl FAST::Bio::SeqIO::fastq/reader.pl $@ 2> /dev/null
perl FASTX::Reader/reader.pl $@ 2> /dev/null


hyperfine --export-csv=bench.csv --export-markdown=bench.md --export-json=bench.json  --warmup=10  \
     "perl BioPerl/reader.pl $ARGS " \
     "perl Bio::SeqReader::Fastq/reader.pl $ARGS " \
     "perl BioX::Seq/reader.pl $ARGS " \
     "perl FAST::Bio::SeqIO::fastq/reader.pl $ARGS " \
     "perl FASTX::Reader/reader.pl $ARGS "

