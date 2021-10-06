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


set -euo pipefail

perl Bio::SeqReader::Fastq/reader.pl "$@" | tail -n 2
perl BioX::Seq/reader.pl "$@" | tail -n 2
perl FAST::Bio::SeqIO::fastq/reader.pl "$@" | tail -n 2
perl FASTX::Reader/reader.pl "$@" | tail -n 2

perl BioPerl/reader.pl "$@" | tail -n 2
 