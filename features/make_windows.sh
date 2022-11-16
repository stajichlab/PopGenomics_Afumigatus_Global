#!/usr/bin/bash -l
module load bedtools
grep -P "\tmatch\t" repeats.gff3  > repeats_only.gff3
grep -P "\tgene\t" genes.gff3  > genes_only.gff3
for window in 10000 50000
do
	bedtools makewindows -b genome.bed -w $window > genome_${window}windows.bed
 	bedtools coverage -b repeats_only.gff3 -a genome_${window}windows.bed > repeat_windows_$window.bed
 	bedtools coverage -b genes_only.gff3 -a genome_${window}windows.bed > gene_windows_$window.bed
done
