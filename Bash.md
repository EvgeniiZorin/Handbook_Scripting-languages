# Bash handbook 


> This is a practical handbook about the basic functions and concepts in BASH that I wrote for my own reference in case I forget a certain BASH function. If you stumble upon this handbook and find it useful, the pleasure is mine :)    
> .   
> Evgenii Zorin

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC_BY_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)

# Contents
- [Bash handbook](#bash-handbook)
- [Contents](#contents)
- [General info](#general-info)
  - [Nano](#nano)
- [Standard streams](#standard-streams)
- [chmod](#chmod)
- [Variables](#variables)
- [Data Types](#data-types)
  - [String](#string)
  - [Array](#array)
  - [Int and float](#int-and-float)
- [Date and time](#date-and-time)
- [Regular expressions](#regular-expressions)
- [Conditional statements and loops](#conditional-statements-and-loops)
  - [IF](#if)
  - [WHILE](#while)
  - [UNTIL](#until)
  - [FOR](#for)
  - [CASE statements](#case-statements)
- [Function definition](#function-definition)
- [File handling](#file-handling)
  - [Encoding](#encoding)
- [Main functions](#main-functions)
  - [Running jobs](#running-jobs)
  - [AWK](#awk)
  - [CAT](#cat)
  - [CD](#cd)
  - [Compression](#compression)
  - [CP](#cp)
  - [CURL](#curl)
  - [CUT](#cut)
  - [ECHO\_PRINTF](#echo_printf)
  - [FIND](#find)
  - [GREP](#grep)
  - [HEAD](#head)
  - [LS](#ls)
  - [RANDOM](#random)
  - [RENAME](#rename)
  - [SCREEN](#screen)
  - [SED](#sed)
  - [SHUF](#shuf)
  - [SORT](#sort)
  - [TAIL](#tail)
  - [TMUX](#tmux)
  - [TR](#tr)
  - [TREE](#tree)
  - [UNIQ](#uniq)
  - [WC](#wc)
  - [WGET](#wget)
  - [XARGS](#xargs)
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
- Print history: `history`
- Find a specific command within history: `history | grep "<command>"`
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
| `du -h file.txt`, `du -hc directory` | Check size of file or directory |
| `df -H` | Check available memory |
| `top` | An older command. Shows processes that consume system resources. |
| `htop` | A more modern version of `top`. Show every process currently ongoing. |
| `nvtop`, `watch -n0.1 nvidia-smi` | A command to show the GPU status for the brands such as AMD, Intel, and Nvidia |

**Deleting files and directories**

Flags:
- `-d`: remove empty directory
- `-r`: remove non-empty directory and its contents
- `-f`: ignore any prompt when deleting a file

```bash
### Remove SILENTLY a non-empty folder with all its contents
rm -rf dirname
### Remove all contents of the folder (including all interior folders) but not the folder itself
rm -rf /path/to/directory/*
```

## Nano

Here are some useful hotkeys to use in Nano:

**(Note: where applicable, `Alt+R` or `Esc+R` toggles REGEXP)**

Edit lines
| Shortcut | Action|
| - | - |
| `Alt+6`, `Ctrl+K`, `Ctrl+U` | Copy, cut, and paste selected text |
| `Ctrl+K` | Delete current line |
| `Ctrl+\` | Replace string with something else. |
| `Alt+3` | Comment / uncomment the current line |

Navigation
| Shortcut | Action |
| - | - |
| `Alt+▲`, `Alt+▼` | Scroll up / down one line without moving the cursor |
| `Ctrl+_` | Go to line and column number ... |
| `Ctrl+◀` and `Ctrl+▶` | Go backward / forward one word. |
| `Ctrl+A` and `Ctrl+E` | Go to start / end of the current line. |
| `Ctrl+P` and `Ctrl+N` | Go to previous / next line. |
| `Ctrl+W` | Search forward for the first occurrence. |
| `Ctrl+Q` | Search backwards for occurrence. You can navigate forward with `Alt+W` and backward with `Alt+Q`. |
| `Ctrl+A`, `Ctrl+E` | Move cursor to the start / end of the line |

Time travel
| Shortcut | Action |
| - | - |
| `Alt+U` | Undo |
| `Alt+E` | Redo |

Information / preferences
| `Ctrl+G` | Display help text |
| `Alt+X` | Enable / disable help mode |
| `Alt+S` | Toggle soft wrapping of overlong lines |
| `Alt+N`, `Alt+Shift+3` | Toggle line numbering on the left |
| `Alt+P` | Toggle whitespace display |
| `Ctrl+I` | Toggle auto indent |


# Standard streams

One of the most important features in bash is **piping**, which sends command output to other commands. For example, 
```bash
echo "Hello there" | grep "there"
```

Output / input redirection

| Redirecting sign | Action |
| --- | --- |
| `1>` | Output stdout to file, e.g. `good_command 1> stdout.txt` |
| `2>` | Output stderror to file, e.g. `bad_command 2> stderr.txt` |
| `>` | Write to a file; redirect both stderr and stdout. If file exists, **rewrites the file** |
| `>>` | Appends to a file if exists. |
| `<` | Direct input from file on the right to the command on the left. |

Examples:
```bash
### Redirect terminal output (stdout) to a file
SomeCommand > SomeFile.txt  

### Same but append
SomeCommand >> SomeFile.txt

### If you want stderr as well use this:
SomeCommand &> SomeFile.txt  

### or this to append:
SomeCommand &>> SomeFile.txt  

###if you want to have both stderr and output displayed on the console and in a file use this:
SomeCommand 2>&1 | tee SomeFile.txt
```


**File management**:
- Create nested dirs ```mkdir -p```
- Move several files to a dir ```mv file1.txt file2.txt dirname```
- Delete dir with files ```rm -r``` or ask before delete ```rm -ri```

# chmod

We can check permission by running `ls -l` in a directory. Each file / directory will have 10 lines associated with permissions:
- 1st character: type of entry. `-` for file, `d` for directory
- 2-4 show user permissions
- 5-7 show group permissions
- 8-10 show other permissions

The chmod command operates on the WHO-WHAT-WHICH principle:
- WHO: Who we are setting permissions for.
- WHAT: What change are we making? Are we adding or removing the permission?
- WHICH: Which of the permissions are we setting?

WHO - Main arguments for specifying for whom the permissions are set:
- `u` - user
- `g` - group
- `o` - others
- `a` - all

WHAT:
- `–` Minus sign. Removes the permission.
- `+` Plus sign. Grants the permission. The permission is added to the existing permissions. If you want to have this permission and only this permission set, use the = option, described below.
- `=` Equals sign. Sets very specific permissions, removing all the others that are not specified.

WHICH - Three main arguments for actions: 
- `r` - read: a file can be viewed and opened
- `w` - write: a file can be edited and deleted
- `x` - execute: a file can be run

Let's consider some example commands:


Let's say that we have a file with all permisions: `-rwxrwxrwx 1 root root 13 May 19 10:01 textfile.txt`

If we want for the user to be able to read, write, and execute, and for group and other - to read only, while removing all permissions that you don't explicitly specify,
you can set like this: `chmod u=rwx,og=r textfile.txt`

We can later add some extra permissions, so that the group can edit: `chmod g+w textfile.txt`

Settings permissions for multiple files: `chmod o-r *.sh`




Give permission to run an executable `chmod +x <filename>`

# Variables

Environment variables:
| Action with env vars | Command | 
| - | - |
| Print all | `printenv`, `env` |
| Print a specific one | `echo $NAME`, `printenv NAME` |
| Permanently set an env var | `nano ~/.bashrc`, then add the var value at the end: `export VAR_NAME="value"`, finally update the .bashrc file using the command: `source .bashrc` |


```bash
# Assign variables:
a="Hello"; b=22; c="${a}, I am ${b} years old!"; 
VAR1="Name"
# Assign expression to a variable via subshell
d=$(( b - 6 ))
d=$(echo $VAR | sed 's/_/-/')
var1=$(ls | wc -l)

echo "$(echo ' M e ')."

# Read user input
read VARNAME
echo "You wrote this variable: \"$VARNAME\""

# Use a variable
echo $a
echo $a more stuff
echo "${a} is the username."

# Check variables and their values
declare -p VARNAME

```
- Print number of variables passed `$#`    
- Arithmetic operation (INT-based) with the variable: `b=$(( a + 100 ))`
echo $(($var1 + 2)) # or
echo $(($(ls | wc -l) - 2))

- Give default value to a variable if a value not assigned: `VAR1="${1:-you}" `

`${1,,}` - means consider variable as lowercase.

**Environmental variables in Linux**

You can check the available environmental variables by the commands `env`, `printenv`; alternatively, print a specific env variable by `printenv NAME` or `echo $NAME`. 

To permanently assign an environmental variable, perform the following steps:
- `nano ~/.bashrc`
- At the bottom of the file, add the following line: `export NAME="value"`
- Subsequently, update the .bashrc file: `source .bashrc`

# Data Types

## String
echo "Welcome, $1"

Slice strings: 
- `echo '((string))' | awk '{print substr($0, 3, length($0) - 4)}'`
- `v1='((string))'; echo "${v1:2:-2}"`

Concatenate string: `echo $a$b`   
In string, sort unique values `echo $a | grep -o "[a-zA-Z]" |sort|uniq| tr -d "\n\r"`

## Array

```bash
arr1=(a b c)

arr1=("a" "b" "c")

arr1=(
  "item1"
  "item2"
)

# Print the first item
echo $arr1

# Access a list's item by its index
echo ${arr1[0]}

# Print the whole array
echo ${arr1[@]} # or...
echo ${arr1[*]}
```

## Int and float

```bash
var1=$(( 5 + 5 ))
var2=$(( $var1 + 5))

echo $(( a * b ))

x=$(( $x + 1 ))
```

Check if $factor is factor of $base: 
```if (($base%$factor == 0)); then echo "true"; else echo "false"; fi```

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



# Conditional statements and loops

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

Examples:
```bash
if [ $a -eq 0 ]; then echo "a"; else echo "b"; fi
if [ $1 == "Johnny" ]; then echo "a"; else echo "$1"; fi
if [ ${1,,} == "johnny" ]; then echo "yes"; else echo "no"; fi
```

Check if directory exists: `if [ -d "Dirname" ]; then echo "Exists!"; fi`   
Create directory if it does not exist: `if [ ! -d "Dirname" ]; then mkdir Dirname; fi`   
    

## WHILE 

```bash
while [[ CONDITION ]]; do STATEMENTS; done
```

Examples:
```bash
# Print a string until you exit
while : ; do echo "Press <CTRL+C> to exit."; sleep 1; done

x=1; while [ $x -le 5 ]; do echo "Welcome $x times"; x=$(( $x + 1 )); done
```



## UNTIL

```bash
until [[ condition ]]; do STATEMENT; done
```

## FOR

This loop is needed to iterate for some kind of values. 

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

Examples:
```bash
for var in "first" "second" "third"; do echo "The $var item"; done

# iterate over an array
MY_FIRST_LIST=(a b c)
for item in ${MY_FIRST_LIST[@]}; do echo -n $item | wc -c; done
```

## CASE statements

Case statements are better than if/elif/else statements when we check for multiple values.

```bash
case EXPRESSION in 
  PATTERN) STATEMENTS ;;
  PATTERN) STATEMENTS ;;
  PATTERN) STATEMENTS ;;
  *) STATEMENTS ;;
esac
```

```bash
# Check the first positional argument (in lowercase) for multiple belonging
# note the "|" OR statement
case ${1,,} in 
  boss | manager | CEO)
    echo "Hello, boss!"
    ;;
  help)
    echo "let me help you: just enter your username"
    ;;
  *)
    echo "Option not recognised. Please write your username"
esac
  
```

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

## Encoding

```bash
# check file encoding
file -bi file.txt
# change file encoding
iconv -f utf-16le -t UTF-8 file.txt -o file_proc.txt
```

# Main functions

## Running jobs
- Run a job in the background ```sleep 50 &```
- Check jobs in the background ```jobs```
- Terminate background job ID=2 ```kill %2```

<hr />

## AWK

AWK is a powerful text-processing tool in Bash scripting that allows for pattern scanning and processing data.

- Operators: 
  - AND ```$$```
  - OR ```||```
- Print columns 1 and 2 ```awk '{print $1,$2}' file.txt```
- Print rows when column 3 == "expr" (no whitespaces present) ```awk '$3 == "expr"'``` or ```awk '{if ($3 == "expr") print $0;}'```
- Print column 1 if its length is 1 ```awk 'length($1) == 1 {print $1}' filename.txt```
- Print column 1 (delim = ,) ```awk -F, '{print $1}' file.txt```
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

`cd` command can be used with relative and absolute paths:
| Environment | Current directory | Path to cd | Resulting path |
| - | - | - | - |
| Local (Windows) | `c:/tmp` | Relative: `dir1` | `c:/tmp/dir1` |
| Local (Windows) | `c:/tmp` | Relative: `dir1/dir2` | `c:/tmp/dir1/dir2` |
| Local (Windows) | `c:/tmp` | Absolute: `c:/another/one` | `c:/another/one` |
| Remote (Linux) | `/var` | Relative: `dir1` | `/var/dir1` |
| Remote (Linux) | `/var` | Absolute: `/home/users` | `/home/users` |


```bash
cd /mnt/c/Users/your-username-here/Desktop # In WSL, make Desktop your workdir
```

## Compression

Main types of archives: `.gz`, `.tar.gz`, `.zip`, `.7z`

| Compression algorithm model | Description | Pack | Unpack |
| - | - | - | - |
| `.gz` | **Archive**. Archives only individual files, never a directory. Uses less memory / is fast for compression / decompression, but compresses less memory-wise. *Note: .gz and .gzip can both be used, but .gz is a much more conventional extension to use.* | `gzip example.fasta`, `gzip -k filename.txt` | `gunzip example.fasta.gz` |
| `.tar` | **Container**. Utility `tar` containerises a folder. Usually, that container is then archived with `gzip` to get an archive `.tar.gz` | `tar -czvf example.tar.gz folder_name`, `tar -czvf example.tar.gz file1.txt file2.txt file3.txt` | `tar -xzvf example.tar.gz` |
| `.tar.gz` | | | Extract a .tar.gz file with verbose ```tar -xvf archive.tar.gz``` |
| `.zip` | **Archive**. Algorithm that is highly portable across OS's.  | Zip all files in the current directory: `zip archivename.zip *` <br> Zip all files in a specified directory: `zip example.zip folder_name/*` <br> Zip a directory: `zip -r output.zip inputDir` <br> Zip multiple files: `zip zipped.zip file1.txt file2.txt file3.txt` | `unzip example.zip` |
| `.7z` | Compresses more space-wise, but uses more memory / runtime to compress / decompress. Install with `sudo apt-get install p7zip-full` | `7z a output.7z directory-or-file-to-archive` | |
| `.tgz` | tar gzip | | `tar xzf housing.tgz` |


## CP
- Copy multiple files to a dir ```cp {file1,file2,file3}.txt dir```

Copy a directory to the parent directory: ```cp -r dirname ..```

- Flags:
  - -v: with verbose

## CURL

```bash
# GET request
curl -X 'GET' https://api-project1-efbh.onrender.com/random_quote
```

Flags:
- `-X`: Allows you to specify the request type. In this case it is a POST request.
- `-d`: Stands for data and allows you to attach data to the request.
- `-H`: Stands for Headers and it allows you to pass additional information through the request. In this case it is used to the tell the server that the data is sent in a JSON format.

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

# Use a variable
echo "Home current user is: $HOME"
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

Some examples of use:
```bash
### Remove all zero-byte files from the filesystem
!find /tmp/data/ -size 0 -exec rm {} +
### removes any file that does not have a .jpg extension
!find /tmp/data/ -type f ! -name "*.jpg" -exec rm {} +
```

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

Command: `grep "<pattern>" <file>`

Examples: 
```bash

# Print lines with 'h' at the start of the line 
grep "^h" file.txt

# Print lines containing one of the specified substring
grep -iE "string1|string2" 
# Print lines containing one letter within A-Z 
grep -w "[A-Z]" input.txt
# Print lines containing one letter within A-Z at start of line 
grep "^[A-Z]" input.txt
# Print lines containing string with a letter at the end 
grep -E "string[a-z]" file.txt
# Search words that start with dog or woof
grep 'dog[a-z]* | woof[a-z]*'

# Save to another file all lines from the original file that do not match the pattern
cat conda-env1.yml | grep -vE "pywin32=305|vs2015_runtime|vc=14.2" > conda-env2.yml
```

## HEAD

General syntax: `head [option] [file]`

**Options**:
```bash
# Print out first 10 lines
-n 3
# Exclude the last 3 lines
-n -15
# Print the first 10 characters
-c 10
```

## LS
- Flags:
  - `-1`: one per line
  - `-s`: sort by size
  - `-a`: all files including hidden ones
  - `-t`: sorted by time
  - `-l`: list of extended information, including permissions
  - `-h`: human-readable

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

A stream editor for bash. Can be used either with a file (`sed <command> <file>`) or from a printed text (`cat <file> | sed <command>`)

Main commands:

```bash
######################################################################
#####   PRINT   ######################################################
######################################################################
### Print a specified line
sed -n 2p file.txt #or
sed -n '2p' file.txt
### Print several lines, e.g. line 1 and line 3 only
sed -n '1p;3p' file.txt
### Print from line 1 to line 3
sed -n '2,3p' file.txt
### Print lines starting from 1 with step of 2 lines
sed -n '1~2p' file.txt

######################################################################
#####   DELETE   #####################################################
######################################################################
# If you want to delete inplace, add a flag `-i`
### Delete line 7
sed '7d' file.txt
### Delete lines 7 to 9 inclusive
sed '7,9d' file.txt

######################################################################
#####   SUBSTITUTE   #################################################
######################################################################
# Pattern substitution command. Supports regex. 
# First argument: s - substitute
# Last argument: g - global (all occurrences)
# Slash is the default separating symbol, but any other symbol can be used. E.g., sed 's|1|5|g', sed 's%1%5%g', etc.
### Replace pattern 1 with pattern 2 (all occurrences)
sed 's/pattern 1/pattern 2/g' file.txt
### Remove all spaces in a string
sed 's/ //g' file.txt
### Replace delim '\t' with ';'
sed 's/\t/;/g' file.txt
### Replace multiple patterns
sed 's/pattern 1/replace 1/; s/pattern 2/replace 2/'

### Replace 1st occurrence only
sed -z 's/pattern 1/pattern 2/1' file.txt
### Replace 5th occurrence only
sed -z 's/pattern 1/pattern 2/5' file.txt

### Replace pattern ("equal" sign, then a sequence of any length of letters, numbers, or dots) with nothing
cat file1.txt | sed -r 's/=[0-9.a-zA-Z]+//g' > file2.txt
```



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

## TAIL

General syntax: `tail [option] [file]`

**Options**:
```bash
# Print out the last 3 lines
-n 3
# Print lines after a specific line
-n +17
# Print the last 10 characters
-c 10
```

## TMUX

Tmux is a terminal multiplexer 
Programa para dejar terminal abierto. 

Tmux handles the processes as sessions. These sessions will continue running even if your connection to the terminal closes. 
```bash
### Create new session 
tmux new -s <session_name>
### Check sessions
tmux ls
tmux list-sessions
### Then you can close terminal, to return to the terminal 
tmux attach -t <session_name>
### leave / detach from session (minimise terminal) 
tmux detach
# `ctrl + b`, then `d`
### Rename a session
tmux rename-session [-t current-name] [new-name]
### Close the session (delete session) 
tmux kill-session -t <name>

```

## TR
- Trim delete newlines ```tr -d '\n\r'```
- Trim carriage returns "\r" `tr -d '\r'`

## TREE

https://www.cyberciti.biz/faq/linux-show-directory-structure-command-line/

The syntax is as follows: `tree [options]`

```bash
### List directories only
tree -d
```

```txt
  ------- Listing options -------
  -a            All files are listed.
  -d            List directories only.
  -l            Follow symbolic links like directories.
  -f            Print the full path prefix for each file.
  -x            Stay on current filesystem only.
  -L level      Descend only level directories deep.
  -R            Rerun tree when max dir level reached.
  -P pattern    List only those files that match the pattern given.
  -I pattern    Do not list files that match the given pattern.
  --ignore-case Ignore case when pattern matching.
  --matchdirs   Include directory names in -P pattern matching.
  --noreport    Turn off file/directory count at end of tree listing.
  --charset X   Use charset X for terminal/HTML and indentation line output.
  --filelimit # Do not descend dirs with more than # files in them.
  --timefmt <f> Print and format time according to the format <f>.
  -o filename   Output to file instead of stdout.
  -------- File options ---------
  -q            Print non-printable characters as '?'.
  -N            Print non-printable characters as is.
  -Q            Quote filenames with double quotes.
  -p            Print the protections for each file.
  -u            Displays file owner or UID number.
  -g            Displays file group owner or GID number.
  -s            Print the size in bytes of each file.
  -h            Print the size in a more human readable way.
  --si          Like -h, but use in SI units (powers of 1000).
  -D            Print the date of last modification or (-c) status change.
  -F            Appends '/', '=', '*', '@', '|' or '>' as per ls -F.
  --inodes      Print inode number of each file.
  --device      Print device ID number to which each file belongs.
  ------- Sorting options -------
  -v            Sort files alphanumerically by version.
  -t            Sort files by last modification time.
  -c            Sort files by last status change time.
  -U            Leave files unsorted.
  -r            Reverse the order of the sort.
  --dirsfirst   List directories before files (-U disables).
  --sort X      Select sort: name,version,size,mtime,ctime.
  ------- Graphics options ------
  -i            Don't print indentation lines.
  -A            Print ANSI lines graphic indentation lines.
  -S            Print with CP437 (console) graphics indentation lines.
  -n            Turn colorization off always (-C overrides).
  -C            Turn colorization on always.
  ------- XML/HTML/JSON options -------
  -X            Prints out an XML representation of the tree.
  -J            Prints out an JSON representation of the tree.
  -H baseHREF   Prints out HTML format with baseHREF as top directory.
  -T string     Replace the default HTML title and H1 header with string.
  --nolinks     Turn off hyperlinks in HTML output.
  ---- Miscellaneous options ----
  --version     Print version and exit.
  --help        Print usage and this help message and exit.
  --            Options processing terminator.
```


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

## WGET

Downloads files. 

```wget <link>```

Flags:
- Save the file in a certain name: `-O filename.txt`


## XARGS
- Use output of file.txt as args in function 'rm' ```cat file.txt | xargs rm```
- ```find . -size +1M | xargs ls -lh```


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

Put a shebang at the top of the shell script: `#!/bin/bash`

Print all arguments passed to the scriplt `$*`

- Concatenate a string: ```var1="I really enjoy"; var1+="programming"``` or ```var1="I really"; var2=" prog"; var3="${var1} enjoy ${var2}"```
- Debug script: 
  - Debug ```set -x```
  - Prohibits overwriting existing regular files ``` set -C```
- Slicing a string ```echo "string1" | cut -c1-3``` 


