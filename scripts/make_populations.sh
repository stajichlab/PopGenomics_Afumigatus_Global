#!/usr/bin/bash -l

echo -e "Populations:\n\n  All:" > population_sets.inprogress.yaml
IFS=,
cat samples.csv | while read POPNAME FILES
do
	echo "    - $POPNAME"
done >> population_sets.inprogress.yaml
