#!/bin/bash

#Skrypt automatujacy robienie wykresow do sprawozdania
#Jak narazie obsluguje pliki pochodzace z ELVIS'a
#Lokalizacja makra!:
macro_root1="../GrafOsc.c"
macro_root2="../GrafSim.c"

lokalizacja=$(pwd)
echo "Odpaliłem się w: $lokalizacja"
for file in $lokalizacja/*
do
	plik=`basename $file`
	echo "Rozpoznałem plik: $plik"
	if [[ $plik == *.txt ]]
	then
		if [[ $plik == *sim* || $plik == *elvis* ]]
		then
			echo "Przetwarzam dane z elvisa: $plik"
			#nalezy zrobic na to poprawke XD coś w stylu:
			#cat dev1elvis_2.txt | tail -n +4 | awk '{print $1, "\t", $2}' > dev1elvis_2phase.txt
			#sed -i 's/\,/\./g' dev1elvis_2phase.txt
			#albo poprawic skrypt convert_elvis2.sh
			root -l "$macro_root2+(\"converted_$plik\")"
		else
			echo "Przetwarzam: $plik"
			bash ./convert_elvis2.sh $plik
			root -l "$macro_root1+(\"converted_$plik\")"
			#Uwaga z tym!:
			#rm converted_*
		fi
	else
		echo "Pomijanie: $file"
	fi
done
