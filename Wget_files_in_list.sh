##!/bin/bash

for i in $(cat fasta_list.txt | tr -d '\r')
do
	echo $i
	wget "https://www.uniprot.org/uniprot/$i.fasta"
done

#for i in $(cat fasta_list.txt | tr -d '\r'); do echo $i; wget "https://www.uniprot.org/uniprot/$i.fasta"; done
