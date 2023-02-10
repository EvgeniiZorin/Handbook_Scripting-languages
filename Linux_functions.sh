# Define function to get string between the words "Here" and "string"
GetString(){
	echo $1 | grep -o -P '(?<=Here).*(?=string)'
}

GetString "Here is my string"