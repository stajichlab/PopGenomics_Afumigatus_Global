#!/usr/bin/bash -l
#SBATCH -p short
module load bioperl

perl ../scripts/repeatmasker_to_gff3.pl FungiDB-50_AfumigatusAf293_Genome.fasta.out > FungiDB-50_AfumigatusAf293_Genome.RM.gff3
