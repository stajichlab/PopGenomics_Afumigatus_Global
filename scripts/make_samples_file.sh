#!/usr/bin/bash -l
echo "STRAIN,FILEBASE" > samples.inprogress.csv
pushd input
ls */*R1.fastq.gz | perl -p -e 's/((\S+)_R1\.fastq\.gz)/$2,$2_R[12].fastq.gz/' >> ../samples.inprogress.csv
ls */*R1_001.fastq.gz | perl -p -e 's/(((\S+)_S\d+)_R1_001\.fastq\.gz)/$3,$2_R[12]_001.fastq.gz/'  >> ../samples.inprogress.csv
ls */*_1.f*gz | perl -p -e 's/(\S+)\/(\S+)_1./$2,$1\/$2_R\?./' >> ../samples.inprogress.csv
