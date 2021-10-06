| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `perl BioPerl/reader.pl /tmp/random.fa /tmp/random.fa.gz /tmp/random.fq /tmp/random.fq.gz ` | 6.087 ± 0.115 | 5.874 | 6.254 | 30.92 ± 0.66 |
| `perl Bio::SeqReader::Fastq/reader.pl /tmp/random.fa /tmp/random.fa.gz /tmp/random.fq /tmp/random.fq.gz ` | 0.380 ± 0.005 | 0.374 | 0.390 | 1.93 ± 0.03 |
| `perl BioX::Seq/reader.pl /tmp/random.fa /tmp/random.fa.gz /tmp/random.fq /tmp/random.fq.gz ` | 0.197 ± 0.002 | 0.195 | 0.201 | 1.00 |
| `perl FAST::Bio::SeqIO::fastq/reader.pl /tmp/random.fa /tmp/random.fa.gz /tmp/random.fq /tmp/random.fq.gz ` | 6.853 ± 0.344 | 6.306 | 7.566 | 34.81 ± 1.78 |
| `perl FASTX::Reader/reader.pl /tmp/random.fa /tmp/random.fa.gz /tmp/random.fq /tmp/random.fq.gz ` | 0.244 ± 0.003 | 0.239 | 0.250 | 1.24 ± 0.02 |
