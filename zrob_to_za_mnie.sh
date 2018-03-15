#!/bin/bash

#Skrypt automatujacy robienie wykresow do sprawozdania
#Lokalizacja makra!:
macro_root="../GrafOsc.cpp"

lokalizacja=$(pwd)
echo "Odpaliłem się w: $lokalizacja"
for file in $lokalizacja/*
do
	echo "Rozpoznałem plik: $file"
	if [[ $file == *.txt ]]
	then
		plik=`basename $file`
		bash ./convert_elvis2.sh $plik
		echo "Przetwarzam: $file"
		root -q -l "$macro_root+(\"converted_$plik\")"
		#Uwaga z tym!:
		#rm converted_*
	else
		echo "Pomijanie: $file"
	fi
done
