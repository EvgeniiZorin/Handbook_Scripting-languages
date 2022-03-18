ver 1.0.1
# Projects description

- **Generate_randomsort_datasets_with_fractions.sh**: bash script which takes a .txt file with N lines, then generates 10 files with randomly sorted lines from the original file (except for header, which is assumed to be the first line and stays on top) + for each of the 10 files, generates differently-sized fractions of sizes (N-1)\*0.1 for 10%, (N-1)\*0.2 for 20%, and so forth up to 100% (unchanged, randomly-sorted file). 
- Project 2
- Project 3

# Most useful BASH commands

## General info
- Change pw ```passwd```
- Print current date ```date```
- Print history ```history```
- Check the server's load ```top``` or ```htop```
- Check how many resources we have ```df -h```
- See info about the file ```file file.txt```
- See where the program is installed ```which fastqc```
- Show manual for the command ```man pwd``` or a short explanation ```whatis pwd```
- Gen full path of a file ```readlink -f file.txt```
- Print files in the current dir ```for i in $(ls); do echo $i; done```
- Print .txt files in the current dir ```for i in *.txt; do echo $i; done```
- Print difference btw two files, or print nothing if equal ```diff file1.txt file2.txt``` add flag -u for a more readable output
- Clear the screen w/o deleting the scroll history ```clear -x``` or shortcut in Win ```ctrl + L```

**File management**:
- Create nested dirs ```mkdir -p```
- Move several files to a dir ```mv file1.txt file2.txt dirname```
- Delete dir with files ```rm -r``` or ask before delete ```rm -ri```

## Running jobs
- Run a job in the background ```sleep 50 &```
- Check jobs in the background ```jobs```
- Terminate background job ID=2 ```kill %2```

<hr />

## AWK
- Operators: 
  - AND ```$$```
  - OR ```||```
- Print columns 1 and 2 ```awk '{print $1,$2}' file.txt```
- Print rows when column 3 == "expr" (no whitespaces present) ```awk '$3 == "expr"'``` or ```awk '{if ($3 == "expr") print $0;}'```
- Print column 1 if its length is 1 ```awk 'length($1) == 1 {print $1}' filename.txt```
- Print column 3 (delim = \t) ```awk -F"\t" '{print $3}' file.txt``` 
- Print line if the value of column 5 is <= 100 ```awk '$5<=100 {print}' file.txt```
- Concatenate multiple columns ```awk -F"\t" '{print "## " $1 " -- " $4 "_END"}' file.txt```
- In a file containing spaces, with primary delim = \t, print rows where column4 == 99 
  - ```awk 'BEGIN{FS="\t"} $4 == "99"' file.txt``` 
  - or, if two conditions ```awk 'BEGIN{FS="\t"} $4 == "99" $$ $5 == "99"' file.txt``` or ```awk -F"\t" '{if ($4 == "99" && $5 == "99") print $0;}' newfile.txt```
- Rearrange the order of columns in a file ```awk 'BEGIN {FS=OFS="\t"} {print $3, $1, $5}' newfile.txt >newfile_proc.txt```
- Print column 1, replacing all colons by semicolons ```awk 'BEGIN{FS=OFS="\t"} {gsub(/\:/, ";", $1)} 1' file.txt``` or ```awk -F "\t" '{gsub(/\:/,";",$1);print $1"\t"$2"\t"$3}' file.txt```

## CAT
- Concatenate several files into one ```cat file1 file2 > file3```
- Concatenate all .tsv files in the current dir into one ```cat *.tsv >> output.tsv```

## CP
- Copy multiple files to a dir ```cp {file1,file2,file3}.txt dir```
- Flags:
  - -v: with verbose

## CUT
- Print column 7  ```cut -f 7 input.txt``` 
- Print columns 1, 2  ```cut -f 1,2 input.txt``` or ```cut -f 1-2 input.txt``` 
- Print column 3 and up  ```cut -f 3- input.txt```

## GREP
- Print lines containing one letter within A-Z ```grep -w "[A-Z]" input.txt```
- Print lines containing one letter within A-Z at start of line ```grep "^[A-Z]" input.txt```
- Print lines with 'h' at line start ```grep "^h" file.txt```
- Print lines containing string with a letter at the end ```grep -E "string[a-z]" file.txt```
- Flags: 
  - -i: ignore case
  - -c: print line count
  - -v: lines that don't contain ...
  - -n: specified line number in which the query was found
  - -nC 1: prints 1 line before and after the matching line
  - -r: recursive search, case-sensitive
  - -E: **allows to use extended regexp**

## LS
- Flags:
  - -1: one per line
  - -s: sort by size
  - -a: all files including hidden ones
  - -t: sorted by time
  - -l: list of extended information
  - -h: human-readable

## REGEXP
Meta characters which need to be escaped with a backslash ```\``` : ```.[{(\^$|?*+```
- Zero or more characters ```*```
- Zero or one character ```?```
- Any of the stated characters ```[abc]```
- Any character NOT specified ```[^abc]```
- Removes special meaning of a char ```\```
- Logical OR operator ```|```
- Char at the start of line ```^X```
- Char at the end of line ```X$```
- FOR loop ```{}```
  - ```echo {a,b,c}.txt```
  - ```echo {1..5}.txt```

## RENAME
- Flags: 
  - -n: check which actions will be taken without taking them (mock)
  - -v: verbose
- Rename a file ```rename 's/oldname/newname/' file```
- Change extension in all .txt files ```rename 's/.txt$/.csv/' *.txt``` or same but deliberately escaping special symbols ```rename -n 's/\.txt$/\.csv/' *.txt
- Replace all spaces with underscores in all .txt files (with a global modifier) ```rename 's/ /_/g' *.txt```
- In .txt files, change name ```rename 's/my_file/file/' *.txt```

## SCREEN
- Create a parallel session ```screen```
- Exit a screen ```ctrl + A```, then ```D```
- Show screens ```screen -ls```
- Go to screen ```screen -r```
- Name a screen ```screen -S name```
- Kill ```screen -X -S [session # you want to kill] kill```

## SED
- Print line 2 ```sed -n 2p file.txt```
- Remove line 7 inplace ```sed -ie '7d' file.txt``` or ```sed -i '7d' file.txt```
- Replace all occurrences of str1 with str2 ```sed 's/str1/str2/g' file.txt```
- Replace delim '\t' with ';' ```sed 's/\t/;/g' file.txt```

## SORT
- Randomly shuffle 10 non-repeating sample items ```shuf -n 10 input.txt``` or ```sort --random-sort input.txt```
- Sort by col3, then by col4 ```sort -k3 -k4 file.txt```
- Flags for ```sort```:
  - -u: sort and print unique lines
  - -V: sort alphanumerically - numbers, then letters
  - -r: reverse sort
  - -n: numerical sort (10, then 100)

## UNIQ
- Remove replciates from sorted data, leaving only unique values ```uniq```
- Flags:
  - -c: with counts
  - -u: only unique lines
  - -d: only duplicates

## WC
- Flags:
  - -l: number of lines
  - -w: number of words
  - -c: number of bytes
  - -m: number of characters
  - -L: prints only length of the longest line
  - -X: print number of lines, words, byte count

## XARGS
- Use output of file.txt as args in function 'rm' ```cat file.txt | xargs rm```
- ```find . -size +1M | xargs ls -lh```

## ZIP, GZIP
- Zip (.gz) a file ```gzip -k filename.txt```
- Zip (.zip) a directory ```zip -r output.zip inputdir```
- Unzip ```gzip -d file``` or ```gunzip file```
- Extract a .tar.gz file with verbose ```tar -xvf archive.tar.gz```


# Workload managers
- PBS
  - Push bash script to queue ```qsub script.sh```
  - Check queue ```qstat```
- Slurm
  - Push bash script to queue ```sbatch script.sh```
  - Check queue ```squeue```

# Bioinformatics-specific commands
- Take VCF file and output the most commonly-encountered REF nucleotide ```sed '/##/d' input.vcf | awk '{print $1, $4}' | grep "^15" | awk '{print$2}' | grep -w "[A-Z]" | sort | uniq -c | sort -r | head -1```
- Convert Fastq to Fasta ```cat input.fastq | paste - - - - | sed 's/^@/>/g' | cut -f1-2 | tr '\t' '\n'``` or ```sed -n '1~4s/^@/>/p;2~4p' input.fastq > output.fasta```
- Download multiple .fasta files from the uniprot website by their ID given in a text file ```for i in $(cat fasta_list.txt | tr -d '\r'); do wget "https://www.uniprot.org/uniprot/$i.fasta"; done```
  - Here, fasta list looks like this: P94485 \n Q7CPU9 \n Q802Y8
  - Note: the script removes the cryptic newline '\r' from the end of each line

# BASH scripting
- Concatenate a string: ```var1="I really enjoy"; var1+="programming"``` or ```var1="I really"; var2=" prog"; var3="${var1} enjoy ${var2}"```
- Debug script: 
  - Debug ```set -x```
  - Prohibits overwriting existing regular files ``` set -C```
- Slicing a string ```echo "string1" | cut -c1-3``` 
