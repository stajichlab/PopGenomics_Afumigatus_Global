#!/usr/bin/env python3
import csv,sys,re
outdir="SRA"
with open("lib/SRA_samples.csv","rt") as inp, open("samples.csv","rt") as existing, open("samples.csv.2","w",newline="",encoding="utf-8") as outf:
    outcsv = csv.writer(outf,delimiter=",")
    csvin = csv.reader(inp,delimiter=",")
    sampin = csv.reader(existing,delimiter=",")
    table = {}
    for row in sampin:
        if row[0].startswith("Strain"):
            continue
        table[row[0]] = set(row[1].split(";"))

    for row in csvin:
        if row[0].startswith("RunAcc"):
            continue
        strain = row[1]
        strain = re.sub(r' ','_',strain)
        strain = re.sub(r'\/','-',strain)
        srr    = row[0]
        srr    = "{}/{}_[12].fastq.gz".format(outdir,srr)

        if strain in table:
            table[strain].add(srr)
        else:
            table[strain] = set([srr])

    inp.close()
    existing.close()

    for d in sorted(table,key=lambda strain: ((next(iter(table[strain]))).split('/')[0],strain)  ):
        outcsv.writerow([d,";".join(sorted(table[d]))])
