#!/usr/bin/env python3
import csv
infile ="lib/DAPC_groupings_K3_20Jan2021.txt"
groups = {}
with open(infile,"rt") as fh:
    csvin = csv.reader(fh,delimiter="\t")
    header = next(csvin)
    for row in csvin:
        CladeName = "DAPC_Clade_{}".format(row[1])
        if CladeName not in groups:
            groups[CladeName] = []
        groups[CladeName].append(row[0])

for clade in groups:
    print("  {}:".format(clade))
    for strain in groups[clade]:
        print("    - {}".format(strain))
