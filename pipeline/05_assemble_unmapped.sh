#!/usr/bin/bash -l
#SBATCH -p batch -N 1 -n 8 --mem 24gb --out logs/assemble_unmapped.%a.log --time 24:00:00

module load spades
MEM=24
UNMAPPEDASM=unmapped_asm
UNMAPPED=unmapped
if [ -f config.txt ]; then
  source config.txt
fi

CPU=2
if [ $SLURM_CPUS_ON_NODE ]; then
  CPU=$SLURM_CPUS_ON_NODE
fi
N=${SLURM_ARRAY_TASK_ID}
if [ -z $N ]; then
  N=$1
fi
if [ -z $N ]; then
  echo "cannot run without a number provided either cmdline or --array in sbatch"
  exit
fi


MAX=$(wc -l $SAMPFILE | awk '{print $1}')
if [ $N -gt $MAX ]; then
  echo "$N is too big, only $MAX lines in $SAMPFILE"
  exit
fi

IFS=,
cat $SAMPFILE | sed -n ${N}p | while read STRAIN FILEBASE
do
  UMAP=$UNMAPPED/${STRAIN}.$FASTQEXT
  UMAPSINGLE=$UNMAPPED/${STRAIN}_single.$FASTQEXT
  if [[ ! -s $UMAP && ! -s $UMAPSINGLE ]]; then
      echo "Need unmapped FASTQ file, skipping $STRAIN ($FILEBASE)"
  elif [ ! -s $UMAP ]; then
      spades.py --pe-s 1 $UMAPSINGLE -o $UNMAPPEDASM/$STRAIN -t $CPU -m $MEM  --isolate
  elif [ ! -s $UMAPSINGLE ]; then
      spades.py --pe-12 1 $UMAP -o $UNMAPPEDASM/$STRAIN -t $CPU -m $MEM --isolate
  else 
      spades.py --pe-12 1 $UMAP --pe-s 1 $UMAPSINGLE -o $UNMAPPEDASM/$STRAIN -t $CPU -m $MEM --isolate
  fi
done
