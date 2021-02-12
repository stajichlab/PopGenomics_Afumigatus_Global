#!/usr/bin/env python3
import csv,sys
outdir="SRA"
outcsv = csv.writer(sys.stdout,delimiter=",")
with open("lib/SRA_samples.csv","rt") as inp:
    csvin = csv.reader(inp,delimiter=",")
    table = {}
    for row in csvin:
        if row[0].startswith("RunAcc"):
            continue
        strain = row[1]
        srr    = row[0]
        srr    = "{}/{}_[12].fastq.gz".format(outdir,srr)
        if strain in table:
            table[strain].append(srr)
        else:
            table[strain] = [srr]

for d in sorted(table):
    outcsv.writerow([d,";".join(table[d])])
