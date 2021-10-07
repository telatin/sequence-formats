# Perl libraries
## Libraries

The "FASTX" columns refers to the seamless parsing of both FASTA and FASTQ files.

| Library name                                                               | Last Updated | Fastx |
|:---------------------------------------------------------------------------|:-------------|:------|
| [BioPerl Bio::SeqIO](https://metacpan.org/pod/Bio::SeqIO)                  |  2019* | -    |
| [BioX::Seq](https://metacpan.org/pod/BioX::Seq)                            |  2021  | ✅    |
| [FASTX::Reader](https://metacpan.org/pod/FASTX::Reader)                    |  2021  | ✅    | 
| [FAST::Bio::SeqIO::fastq](https://metacpan.org/pod/FAST::Bio::SeqIO::fastq)|  2015  |  -    |
| [Bio::SeqReader](https://metacpan.org/pod/Bio::SeqReader)                  |  2012  |  -    | 

* The BioPerl project is active and constantly updated, we reported the last commit in the SeqIO modules specifically.

#### BioPerl

* **Summary**: BioPerl is a well-known and comprehensive set of modules for bioinformatics, that was arguably the world-leading
effort in bioinformatics libraries before the advent of NGS. See [bioperl.org](https://bioperl.org/). The wide adoption
makes it a recommended distribution for bioinformatics projects, but it's complex dependency tree and occasional difficulties
in the installation (usually due to compiled components) can be and obstacle. If FASTA/FASTQ parsing is the only task required, other libraries can be a faster, lighter and easier to install solution.
* **Publication**: [Stajich et al. 2002 - The Bioperl toolkit: Perl modules for the life sciences](http://dx.doi.org/10.1101/gr.361602)
* **Authors/maintainers**: The BioPerl consortium; latest commits on FASTA and FASTQ modules by David Miguel Susano Pinto and Lee Katz
* **Tests**: comprehensive test suite 


#### BioX::Seq

* **Summary**: A lightweight object-oriented FASTA/FASTQ parser. Does not depend on non core libraries and provides the fastest parsing, seamlessly supporting FASTA and FASTQ files, compressed or not. It's the ideal choice when FASTX parsing is the only request.
* **Publication**: Cite repository [https://github.com/jvolkening/p5-BioX-Seq](https://github.com/jvolkening/p5-BioX-Seq)
* **Authors/maintainers**: Jeremy Volkening
* **Test coverage**: 95.68% Coverage


#### FASTX::Reader

* **Summary**: Lightweight module implementing Heng Li's 
[FASTA/FASTQ parser](https://github.com/lh3/readfq/blob/master/readfq.pl). The parser returns scalars (not OO). It's a fast implementation.
* **Publication**: [Telatin et al. 2021 - SeqFu: A Suite of Utilities for the Robust and Reproducible Manipulation of Sequence Files](https://www.mdpi.com/2306-5354/8/5/59)
* **Authors/maintainers**: Andrea Telatin
* **Test coverage**: 71.87% Coverage

#### FAST::Bio::SeqIO::fastq

* **Summary**: Modules for the the *Fast Analysis of Sequences Toolbox (FAST)*, a set of UNIX utilities (for example fasgrep, fascut, fashead and fastr) that extends the UNIX toolbox paradigm to bioinformatic sequence records.
* **Publication**: [Lawrence et al. 2015 - FAST: FAST Analysis of Sequences Toolbox](https://www.frontiersin.org/articles/10.3389/fgene.2015.00172/full)
* **Authors/maintainers**: Ewan Birney, Lincoln Stein (Fasta), and Chris Fields, Tony Cox (Fastq)
* **Test coverage**: 34.04% Coverage  

#### Bio::SeqReader

* **Summary**: Provides separate FASTA and FASTQ parser.
* **Publication**: Cite repository [https://metacpan.org/pod/Bio::SeqReader](https://metacpan.org/pod/Bio::SeqReader)
* **Authors/maintainers**: John A. Crow
* **Test coverage**: Class is tested, parser is not


## The _reader.pl_ script

The _reader.pl_ script will count the total amount of input files, total sequences, total bases and maximum length
of a set of input files, in FASTA or FASTQ format, gzipped or not.

A benchmark tested the performance using four files, in FASTQ and FASTA format, Gzipped or not,
generated with `utils/generate-random-fastx.py`:

│ File          │ #Seq │ Total bp │ Avg    │ N50  │ N75  │ N90  │ auN      │ Min │ Max  │
|:--------------|-----:|---------:|-------:|-----:|-----:|-----:|---------:|----:|-----:|
│ random.fa     │ 1000 │ 5040213  │ 5040.2 │ 6883 │ 4908 │ 3151 │ 6306.366 │ 63  │ 9999 │
│ random.fa.gz  │ 750  │ 3842141  │ 5122.9 │ 6870 │ 4988 │ 3263 │ 6401.693 │ 63  │ 9999 │
│ random.fq     │ 1000 │ 5290012  │ 5290.0 │ 7334 │ 5134 │ 3205 │ 6443.091 │ 84  │ 9998 │
│ random.fq.gz  │ 750  │ 3849682  │ 5132.9 │ 7173 │ 4987 │ 3038 │ 6406.062 │ 84  │ 9997 │


The results:

| Command | Mean [s] | Min [s] | Max [s] | Relative | Multi format handling |
|:---|---:|---:|---:|---:|:---|
| `BioX::Seq` | 0.197 ± 0.002 | 0.195 | 0.201 | 1.00 | Simpler |
| `FASTX::Reader` | 0.244 ± 0.003 | 0.239 | 0.250 | 1.24 ± 0.02 | Simpler |
| `Bio::SeqReader::Fastq` | 0.380 ± 0.005 | 0.374 | 0.390 | 1.93 ± 0.03 | Longer |
| `BioPerl` | 6.087 ± 0.115 | 5.874 | 6.254 | 30.92 ± 0.66 | Longer |
| `FAST::Bio::SeqIO::fastq` | 6.853 ± 0.344 | 6.306 | 7.566 | 34.81 ± 1.78 | Longer |
