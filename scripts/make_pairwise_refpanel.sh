#!/usr/bin/bash -l
#SBATCH -p short -N 1 -n 8 --mem 8gb --out logs/pairwise_SNPs.log

module load bcftools
module load workspace/scratch
IN=vcf/Afum_global_v4.RefPanel.SNP.combined_selected.vcf.gz
CPU=8
echo -e "STRAIN\tCOUNT" > pairwise_refstrain_count.tsv
for strain in $(bcftools query -l $IN)
do
	bcftools view --threads $CPU -s $strain -Ob -o $SCRATCH/$strain.bcf $IN
	bcftools +fill-tags $SCRATCH/$strain.bcf -Ob -o $SCRATCH/$strain.tags.bcf -- -t all
	count=$(bcftools view -e "AF=0" $SCRATCH/$strain.tags.bcf | grep -c PASS)
	echo -e "$strain\t$count"
done >> pairwise_refstrain_count.tsv

