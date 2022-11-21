# Bash handbook 


> This is a practical handbook about the basic functions and concepts in BASH that I wrote for my own reference in case I forget a certain BASH function. If you stumble upon this handbook and find it useful, the pleasure is mine :)    
> .   
> Evgenii Zorin

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC_BY_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)

# Contents
- [Bash handbook](#bash-handbook)
- [Contents](#contents)
- [General info](#general-info)
  - [Redirecting output](#redirecting-output)
- [chmod](#chmod)
- [Variables](#variables)
  - [String](#string)
  - [Array](#array)
- [Date and time](#date-and-time)
- [Regular expressions](#regular-expressions)
- [FOR loop](#for-loop)
- [Conditional statements](#conditional-statements)
  - [IF](#if)
  - [WHILE](#while)
  - [UNTIL](#until)
- [Math](#math)
- [Function definition](#function-definition)
- [File handling](#file-handling)
- [Main functions](#main-functions)
  - [Running jobs](#running-jobs)
  - [AWK](#awk)
  - [CAT](#cat)
  - [CD](#cd)
  - [CP](#cp)
  - [CUT](#cut)
  - [ECHO_PRINTF](#echo_printf)
  - [FIND](#find)
  - [GREP](#grep)
  - [LS](#ls)
  - [RANDOM](#random)
  - [RENAME](#rename)
  - [SCREEN](#screen)
  - [SED](#sed)
  - [SHUF](#shuf)
  - [SORT](#sort)
  - [TR](#tr)
  - [UNIQ](#uniq)
  - [WC](#wc)
  - [XARGS](#xargs)
  - [ZIP_GZIP](#zip_gzip)
- [Workload managers](#workload-managers)
- [Bioinformatics commands](#bioinformatics-commands)
- [BASH scripting](#bash-scripting)

# General info

If you are working on WSL Ubuntu terminal, you could cd to the Desktop folder with the following command:
```cd /mnt/c/Users/evgen/Desktop```

- Change pw ```passwd```
- Print current date ```date```
- Check the server's load ```top``` or ```htop```
- Check how many resources we have ```df -h```
- See info about the file ```file file.txt```
- See where the program is installed ```which fastqc```
- Gen full path of a file ```readlink -f file.txt```
- Print files in the current dir ```for i in $(ls); do echo $i; done```
- Print .txt files in the current dir ```for i in *.txt; do echo $i; done```
- Print difference btw two files, or print nothing if equal ```diff file1.txt file2.txt``` add flag -u for a more readable output
- Clear the screen w/o deleting the scroll history ```clear -x``` or shortcut in Win ```ctrl + L```
- Check exit status of the last cmd `echo $?`. Zero errors is 0, doesn't exist or False is 1. 

**History**
- Print history `history`
- Execute cmd from a line number X from history `!X`

```bash
: '
comment out
multiple lines
'
```

| Command | Action |
| --- | --- |
| `<cmd> --help`, `man <cmd>`, `help <cmd>`, `whatis pwd` | Get help for a command `<cmd>` |

## Redirecting output

| Redirecting sign | Action |
| --- | --- |
| `1>` | Output stdout to file, e.g. `good_command 1> stdout.txt` |
| `2>` | Output stderror to file, e.g. `bad_command 2> stderr.txt` |
| `>` | Redirect both stderr and stdout |


**File management**:
- Create nested dirs ```mkdir -p```
- Move several files to a dir ```mv file1.txt file2.txt dirname```
- Delete dir with files ```rm -r``` or ask before delete ```rm -ri```

# chmod

Give permission to run an executable `chmod +x <filename>`

# Variables

```bash
# Assign variables:
a="Hello"; b=22; c="${a}, I am ${b} years old!"; 
# Assign expression to a variable via subshell
d=$(( b - 6 ))
d=$(echo $VAR | sed 's/_/-/')

echo "$(echo ' M e ')."

# Read user input
read VARNAME
# Use a variable
echo $a

# Check variables and their values
declare -p VARNAME
```
- Print number of variables passed `$#`    
- Arithmetic operation (INT-based) with the variable: `b=$(( a + 100 ))`
- Give default value to a variable if a value not assigned: `VAR1="${1:-you}" `

## String
echo "Welcome, $1"

Slice strings: 
- `echo '((string))' | awk '{print substr($0, 3, length($0) - 4)}'`
- `v1='((string))'; echo "${v1:2:-2}"`

Concatenate string: `echo $a$b`   
In string, sort unique values `echo $a | grep -o "[a-zA-Z]" |sort|uniq| tr -d "\n\r"`

## Array

```bash
arr1=("a" "b" "c")

arr1=(
  "item1"
  "item2"
)

# Access a list's item by its index
echo ${arr1[0]}

# Print the whole array
echo ${arr1[@]} # or...
echo ${arr1[*]}
```

# Date and time
```bash
start_time=$SECONDS # Get current time in seconds
elapsed=$(( SECONDS - start_time )) # How many seconds have passed

# Get current time
now=$(date +"%FORMAT") # where FORMAT - different arguments
```
date FORMAT arguments
| Argument | Function |
| --- | --- |
| `-R` | Mon, 26 Jun 2022 HH:MM:SS GMT |
| `+"%T"` | HH:MM:SS (24-hr format) |
| `+"%r"` | HH:MM:SS PM (12-hr format) |
| `+"%I:%M:%S"` | HH:MM:SS (12-hour) |
| `+'%m/%d/%Y'` | mm/dd/yyyy  |

Some interesting abilities:
```bash
cal # print calendar
```


# Regular expressions
Meta characters which need to be escaped with a backslash ```\``` : ```.[{(\^$|?*+```

| Command | Action |
| :----------- | :------------------------------------------------------------ |
| `*` | Zero or more characters. |
| `?` | Zero or one character. |
| `.` | One occurrence of a character. |
| `[abc]` | Any of the stated characters. |
| `[^abc]` | Any character NOT specified. |
| `\` | Removes special meaning of a character. |
| `|` | Logical OR operator. |
| `^X` | Character at the line start. |
| `X$` | Character at the line end. |
| `{}` | FOR loop. |
| `[[ hello =~ el ]]` | pattern matching: does "hello" contain "el"? |
| `+` | any number of character to the left of "+" |


Example: 
- Print all these files: `echo {a,b,c}.txt` or `echo {1..5}.txt`
- Expression start with "h", has at least one character after it, and ends with "d": `^h.+d$`
- Check if variable var1 ends with "?": `[[ $var1 =~ \?$ ]]`
- Is a string a number? `[[ a =~ [0-9] ]]`
- Does the string NOT consist of any number of numbers from start to end? `[[ ! 11 =~ ^[0-9]+$ ]]; echo $?`


# FOR loop

Var 1
```bash
for ((i=1; i<=10; i++)); do echo "a"; done
```
Var2
```bash
for i in {START..STOP..STEP}; do echo $i; done
```

Print the same character N times: 
```bash
b=10; 
for i in $(seq 1 $b); do echo -n 'a'; done; echo '' 
```


# Conditional statements

## IF

```bash
# Version 1 (use $ sign to denote variables):
if [[ condition ]]; then STATEMENT; fi
if [[ condition ]]; then STATEMENT1; elif [[ condition2 ]]; then STATEMENT2; else STATEMENT3; fi
# Version 2 (don't use $ sign to denote variables):
if (( condition )); 
```

| Operator | Description |
| :--- | :--- |
| `-gt` | Greater than **(arithmetic operators)** |
| `-ge` | Greater or equal to |
| `-eq` | Equal to |
| `-ne` | Not equal to |
| `-le` | Less or equal to |
| `-lt` | Less than |
| `==` | Check if two strings are the same **(string operators)** |
| `!=` | Check if two strings are NOT the same |
| `-z` | True if length of the string is zero; `[[ -z $VAR ]]` |
| `-n` | True if length of the string is non-zero |
| `-d` | Check the existence of a directory **(file operators)** |
| `-e` | Check the existence of a file |
| `&&` | AND **(Comparison operators)** |
| `||` | OR |

```if [ $a -eq 0 ]; then echo "a"; else echo "b"; fi```   
```if [ $1 == "Johnny" ]; then echo "a"; else echo "$1"; fi```     
Check if directory exists: `if [ -d "Dirname" ]; then echo "Exists!"; fi`   
Create directory if it does not exist: `if [ ! -d "Dirname" ]; then mkdir Dirname; fi`   
    

## WHILE 

```bash
while [[ CONDITION ]]; do STATEMENTS; done
```

```x=1; while [ $x -le 5 ]; do echo "Welcome $x times"; x=$(( $x + 1 )); done```

## UNTIL

```bash
until [[ condition ]]; do STATEMENT; done
```


# Math

- Work with int ```let "var = $var + 5"```
- Work with floats ```echo "$a*0.7" | bc```
- Modulo - give the division remainder: `%`
- Check if $factor is factor of $base: `if (($base%$factor == 0)); then echo "true"; else echo "false"; fi`

`echo $(( a * b ))`

# Function definition

Here is an example:    
```bash
function functName {
  echo "Hello world!"
}
```
or
```bash
functname() {
 echo "Hello $1"
}
 
functName "Joe"
```

Here's how to return the output of the function:
```bash
my_function () {
  local func_result="some result"
  echo "$func_result"
}

func_result="$(my_function)"
```

# File handling

`mkdir -p nested1/nested2` - create a nested directory

Let's say you have a `file.csv` file:
```csv
name,surname
John,Doe
Jane,Doe
Chris,Evans
```

Iterate row-by-row, printing one column only
```bash
cat file.csv | while IFS="," read NAME SURNAME
do
  echo SURNAME
done
```

Another function worth mentioning is opening online links:
```bash
xdg-open <http://link_here>
```

# Main functions

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

## CD

```bash
cd /mnt/c/Users/your-username-here/Desktop # In WSL, make Desktop your workdir
```

## CP
- Copy multiple files to a dir ```cp {file1,file2,file3}.txt dir```
- Flags:
  - -v: with verbose

## CUT
- Print column 7  ```cut -f 7 input.txt``` 
- Print columns 1, 2  ```cut -f 1,2 input.txt``` or ```cut -f 1-2 input.txt``` 
- Print column 3 and up  ```cut -f 3- input.txt```

## ECHO_PRINTF

```bash
echo "Hello, world!"

# Print multiple lines
echo "asdf
asdf"
```

Flags for ECHO:   
| Flag | Action |
| :--- | :--- |
| `-e` | Interpret newlines, e.g. `echo -e "\ntext\n"` |
| `-n` | Do not output the trailing newline. |
| `for i in {1..75}; do echo -n "-"; done` | Print header line in Linux |

PRINTF: echo but without newline. 

## FIND

`Find` command is used to search directories for files. 

`find` - view the file tree from the current directory. 

| Flag | Function |
| --- | --- |
| `-name` | Search for the specific file / directory, e.g. `find -name index.html` |

## GREP

Flags:

| Flag | Meaning |
| - | - |
| `-i`      | ignore case |
| `-c`      | print line count |
| `-v`      | lines that don't contain ... |
| `-n`      | specified line number in which the query was found |
| `-nC`     |  1: prints 1 line before and after the matching line |
| `-r`      | recursive search, case-sensitive |
| `-E`      | **allows to use extended regexp** |
| `-o`      | matches more than once per each line |
| `--color` | color matches within lines |


Examples: 
```bash

# Print lines containing one of the specified substring
grep -iE "string1|string2" 
# Print lines containing one letter within A-Z 
grep -w "[A-Z]" input.txt
# Print lines containing one letter within A-Z at start of line 
grep "^[A-Z]" input.txt
# Print lines with 'h' at the start of the line 
grep "^h" file.txt
# Print lines containing string with a letter at the end 
grep -E "string[a-z]" file.txt
# Search words that start with dog or woof
grep 'dog[a-z]* | woof[a-z]*'
```

## LS
- Flags:
  - -1: one per line
  - -s: sort by size
  - -a: all files including hidden ones
  - -t: sorted by time
  - -l: list of extended information
  - -h: human-readable

## RANDOM

Internal BASH function (or a BASH environment variable), returns a pseudorandom integer in the range 0 - 32767.

`echo $(( RANDOM % 4 ))` # Generate a random integer from 0 to 3 inclusive. 
`echo $(( RANDOM % 4 + 1 ))` # Genearte a random integer from 1 to 3 inclusive

`N=$(( RANDOM % 4 ))` 

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
- Remove spaces in a string ```echo $1 | sed 's/ //g'```
- Replace all occurrences of str1 with str2 ```sed 's/str1/str2/g' file.txt```
- Replace delim '\t' with ';' ```sed 's/\t/;/g' file.txt```
- Replace multiple patterns: `sed 's/pattern1/replacement1/; s/pattern2/replacement2/'`

`SED` can be used with regex:
```bash
echo "$(echo '   M e ' | sed 's/^ *//g' )." # Remove all leading spaces
echo "$(echo '   M e   ' | sed 's/ *$//g' )." # Remove all trailing spaces
echo "$(echo '   M e   ' | sed -r 's/^ *| *$//g' )." # Do both 
```
Replace SED flags:
- `-g`: regex flag = replace all instances of a pattern
- `-i`: ignore the case of a pattern
- `-r`: use extended regexp, such as "+"


## SHUF
- Get N random lines `shuf -n N input >output`

## SORT
- Randomly shuffle 10 non-repeating sample items ```shuf -n 10 input.txt``` or ```sort --random-sort input.txt```
- Sort by col3, then by col4 ```sort -k3 -k4 file.txt```
- Flags for ```sort```:
  - -u: sort and print unique lines
  - -V: sort alphanumerically - numbers, then letters
  - -r: reverse sort
  - -n: numerical sort (10, then 100)

## TR
- Trim delete newlines ```tr -d '\n\r'```
- Trim carriage returns "\r" `tr -d '\r'`

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

## ZIP_GZIP
- Zip (.gz) a file ```gzip -k filename.txt```
- Zip (.zip) all files in the current dir ```zip archiveName *``` or ```zip archiveName *.tsv```
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

# Bioinformatics commands
- Take VCF file and output the most commonly-encountered REF nucleotide ```sed '/##/d' input.vcf | awk '{print $1, $4}' | grep "^15" | awk '{print$2}' | grep -w "[A-Z]" | sort | uniq -c | sort -r | head -1```
- Convert Fastq to Fasta ```cat input.fastq | paste - - - - | sed 's/^@/>/g' | cut -f1-2 | tr '\t' '\n'``` or ```sed -n '1~4s/^@/>/p;2~4p' input.fastq > output.fasta```
- Download multiple .fasta files from the uniprot website by their ID given in a text file ```for i in $(cat fasta_list.txt | tr -d '\r'); do wget "https://www.uniprot.org/uniprot/$i.fasta"; done```
  - Here, fasta list looks like this: P94485 \n Q7CPU9 \n Q802Y8
  - Note: the script removes the cryptic newline '\r' from the end of each line

# BASH scripting

Shebang: `#!/bin/bash`
  
Print all arguments passed to the scriplt `$*`

- Concatenate a string: ```var1="I really enjoy"; var1+="programming"``` or ```var1="I really"; var2=" prog"; var3="${var1} enjoy ${var2}"```
- Debug script: 
  - Debug ```set -x```
  - Prohibits overwriting existing regular files ``` set -C```
- Slicing a string ```echo "string1" | cut -c1-3``` 
