#!/bin/bash

_keysPath="$1"
_origin="$2"

function help()
{
  printf "\nUse keysPath to load a file with a list of files or paths to find in specific path \nUse Origin path for set source with list of files to compare \nUse $2 path to set the file to compare\n"
  printf "\nExample compare list_files path_to_find \n\n"
}

function buscar()
{
filepath="/"${_origin}"/"$line
# echo "$filepath"

   if [[ -e "$filepath" ]];  then
       echo $filepath >> ~/Escritorio/compareResultExist.txt
   else
     echo $filepath >> ~/Escritorio/compareResultNoExist.txt
   fi
}

function runProgram()
{
_pathResult="~/Escritorio/compareResult"
if [ ! -d $_pathResult ]; then
	mkdir -p $_pathResult
	touch $_pathResult"/Exist.txt"
	touch $_pathResult"/NotExist.txt"
fi

for line in $(cat "$_keysPath"); do buscar "$line"; done
}

if [ $(whoami) != 'root' ];
   then 
     echo "You must be a root user"
     exit 1
 fi  

if [[ "$_keysPath" == "" ]] || [[ "$_origin" == "" ]];   then 
       help
       exit 1
fi
runProgram