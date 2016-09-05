#!bin/bash

nameFile="../dados/exp4NAS_semlikwid/exp4NASDesign.csv"
pathOfApps="/home/aulapinroot/NPB3.0/NPB3.0-OMP/bin"

#AUTHOR GABRIEL BRONZATTI MORO
#EXPERIMENT: Matrices Multiplication

nameFile="desingExp1.csv"

ref=$(cat desingExp1.csv)

tmp=""

i=0

for row in ${ref[@]}; do
   if [ $i -gt 0 ]; then		
	   name=$(echo "$row" | cut -d ',' -f1)
	   runId=$(echo "$row" | cut -d ',' -f2)
         runNumber=$(echo "$row" | cut -d ',' -f3)
	   runStd=$(echo "$row" | cut -d ',' -f4)
	   versions=$(echo "$row" | cut -d ',' -f5 | sed 's/"//g')
	   threads=$(echo "$row" | cut -d ',' -f6 | sed 's/"//g')

	   export OMP_NUM_THREADS=$threads
		
	   timeWithoutLikwid=$(./$version | grep -i "Time in seconds" | sed 's/[[:space:]]//g' | sed 's/[a-zA-Z=]//g')
	   timeWithLikwid=$(sudo likwid-perfctr -t 100ms -f -c N:0-31 -g L2CACHE ./$version | grep -i "Time in seconds" | sed 's/[[:space:]]//g' | sed 's/[a-zA-Z=]//g')

	   time=$(echo $time | sed 's/HPCELO://g' | bc)
	   echo "$name,$runId,$runNumber,$sizeTmp,$version,$timeWithoutLikwid,$timeWithLikwid" 
       >> "ResultExp1.csv"
	else
		echo $row >> "ResultExp1.csv"
		let i=$i+1
	fi
done
