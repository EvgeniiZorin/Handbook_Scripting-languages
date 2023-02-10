##!/bin/bash

# Variables for colours
RedBold="\033[1;31m"
Green="\033[;32m"
Cyan="\033[;36m"
End="\033[0m"

# Run the script like this: $ bash count_lines_in_txtfiles_in_specified_dir.sh

printf "Please type in the full path for directory with .txt files, for which you would like to count lines, e.g. \n/mnt/c/Users/evgen/Desktop/Python/Hypercuboids/HypercubeME/220123_test_complete_03 \n"
read Path

printf "$Cyan\n .txt files in the specified dir: $End \n"
ls -l $Path/ | sed 1d | grep ".txt$" # prints list of files in the specified dir, removes first line ('total 0'), and then greps file if it has a '.txt' at the end

printf "$Cyan\n Line count: $End \n"
FileWithPath=$Path/*.txt
totalcounter=0
for i in $FileWithPath
do
	filename=$(echo "$i" | awk -F"/" '{print $NF}')
	# Print count in each file
	number=$(wc -l $i | awk '{print $1-1}')
	if [[ $number -eq -1 ]]; then echo "   $filename   |   No lines in this file, boss!"; elif [[ $number -gt -1 ]]; then echo "   $filename   |   $number"; fi
	totalcounter=`expr $totalcounter + $number`
done
printf "${Cyan}\n Total line count: $End   |  $totalcounter \n\n"
