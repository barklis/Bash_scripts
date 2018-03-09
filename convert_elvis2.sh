#!/bin/bash

#Skrypt konwertujący pliki z elvisa do użytecznej formy

file=converted_$1
tail -n +6 $1 | awk -F '\t' '{printf("%s %s %s\n", $1, $2, $4)}' | awk -F' ' '{printf("%s\t%s\t%s\n", $2, $3, $4)}' > $file
cat $file | awk -F',' '{print $2}' | awk '{print $1}' | cut -c 2- > temp_converter.txt
let value=$(head -n 1 temp_converter.txt)
sed -e "s/$/ $value/" -i temp_converter.txt
awk '{printf("%f\n",($1-$2)/1000000)}' temp_converter.txt > temp_converter2.txt
awk 'NR > 3 { getline f2 < "temp_converter2.txt"; printf("%f %s %s\n",f2,$2,$3) }' $file > temp_converter.txt
cat temp_converter.txt > $file
sed -i 's/\,/\./g' $file
rm temp_converter.txt
rm temp_converter2.txt
