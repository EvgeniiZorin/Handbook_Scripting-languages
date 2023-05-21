#!/bin/bash
# INPUT: in current dir, file with header and N lines
# OUTPUT: to current dir, 10 samples with randomly-sorted lines (excluding header, which stays on top) +
# + for each, % fractions - 10%, 20%, ... 90%, 100%. 
printf -- "------------------------------------ \n"
printf "Please enter the name of fitland dataset to process \n"
printf "Example inputs: 1) Fitland-10.txt   2) Fitland-128/test_complete_07.txt \n"
read input
inputName=$( echo "${input%%.*}" )
for ((i=1; i<=10; i++))
do
	# Create variable = name of output file with iterable from 1 to 10
	newname0="${inputName}_randsort${i}"
	newname1="${inputName}_randsort${i}.txt"
	# In each output file, put first line as the header from the input file
	newname2="${newname0}_100.txt"
	echo $newname2
	head -1 $input >$newname2
	# Randomly-sort all lines (except header) in original file and concat to output file with 100% of lines
	sed 1d $input | sort --random-sort >>$newname2
	lineCount=$( wc -l $input | awk '{print $1-1}' )
	echo "N(lines) = $lineCount + header"
	# Then, for each random dataset, generate fractions of 10%, 20%, ... 90%
	for j in {10..90..10}
	do
		a1=$( echo "scale=2; $j / 100" | bc -l )
		a2=$( echo "scale=2; ( ($j / 100) * $lineCount) + 1" | bc -l )
		a3=$( echo "$a2 /1" | bc )
		echo "$j%: N(lines+header) = $a3"
		newname3="${newname0}_$j.txt"
		head -$a3 $newname2 > $newname3
	done
done
echo $inputName
printf -- "---------------------------- \n Done! \n"
