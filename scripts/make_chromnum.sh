cut -f1,2 genome/*.fai | perl -p -e 's/^(\w+\d+)(\d)\t/$1$2,$2,/'  > genome/chrom_nums.csv
