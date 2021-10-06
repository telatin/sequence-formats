# Perl libraries

## reader.pl script

The _reader.pl_ script will count the total amount of input files, total sequences, total bases and maximum length
of a set of input files, in FASTA or FASTQ format, gzipped or not.

A benchmark tested the performance using four files, in FASTQ and FASTA format, Gzipped or not:

```
┌───────────────────┬──────┬──────────┬────────┬──────┬──────┬──────┬──────────┬─────┬──────┐
│ File              │ #Seq │ Total bp │ Avg    │ N50  │ N75  │ N90  │ auN      │ Min │ Max  │
├───────────────────┼──────┼──────────┼────────┼──────┼──────┼──────┼──────────┼─────┼──────┤
│ /tmp/random.fa    │ 1000 │ 5040213  │ 5040.2 │ 6883 │ 4908 │ 3151 │ 6306.366 │ 63  │ 9999 │
│ /tmp/random.fa.gz │ 750  │ 3842141  │ 5122.9 │ 6870 │ 4988 │ 3263 │ 6401.693 │ 63  │ 9999 │
│ /tmp/random.fq    │ 1000 │ 5290012  │ 5290.0 │ 7334 │ 5134 │ 3205 │ 6443.091 │ 84  │ 9998 │
│ /tmp/random.fq.gz │ 750  │ 3849682  │ 5132.9 │ 7173 │ 4987 │ 3038 │ 6406.062 │ 84  │ 9997 │
└───────────────────┴──────┴──────────┴────────┴──────┴──────┴──────┴──────────┴─────┴──────┘
```

The results:

| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `BioPerl` | 6.087 ± 0.115 | 5.874 | 6.254 | 30.92 ± 0.66 |
| `Bio::SeqReader::Fastq` | 0.380 ± 0.005 | 0.374 | 0.390 | 1.93 ± 0.03 |
| `BioX::Seq` | 0.197 ± 0.002 | 0.195 | 0.201 | 1.00 |
| `FAST::Bio::SeqIO::fastq` | 6.853 ± 0.344 | 6.306 | 7.566 | 34.81 ± 1.78 |
| `FASTX::Reader` | 0.244 ± 0.003 | 0.239 | 0.250 | 1.24 ± 0.02 |