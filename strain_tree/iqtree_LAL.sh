#!/usr/bin/bash -l
#SBATCH -p batch,intel -N 1 -n 4 --mem 96gb --out run_LAL_IQTREE.log

module load iqtree/2.1.3
#IN=Afum_global_v3.LofgrenPanGenome.SNP.mfa

IN=Afum_global_v3.LofgrenPanGenome.SNP.mfa.varsites.phy
iqtree2 -s $IN -m GTR+ASC -nt AUTO -bb 1000 -alrt 1000
