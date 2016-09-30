#!bin/bash

nameFile="../dados/exp4NAS_semlikwid/exp4NASDesign.csv"
pathOfApps="/home/aulapinroot/NPB3.0/NPB3.0-OMP/bin"

outputFile="../dados/exp4NAS_semlikwid/ResultExp4.csv"

ref=$(cat $nameFile)

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

	   timeWithoutLikwid=$("$pathOfApps/$versions" | grep -i "Time in seconds" | sed 's/[[:space:]]//g' | sed 's/[a-zA-Z=]//g')
	   timeWithLikwid=$(sudo likwid-perfctr -t 100ms -f -c N:0-31 -g L2CACHE "$pathOfApps/$versions" | grep -i "Time in seconds" | sed 's/[[:space:]]//g' | sed 's/[a-zA-Z=]//g')

	   echo "$name,$runId,$runNumber,$runStd,$versions,$threads,$timeWithoutLikwid,$timeWithLikwid" >> $outputFile
	else
		echo $row >> $outputFile
		let i=$i+1
	fi
done
