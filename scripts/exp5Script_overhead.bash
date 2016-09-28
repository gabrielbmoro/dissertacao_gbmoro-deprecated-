#!bin/bash

nameFile="../dados/exp5NAS_overhead/exp5NASDesign_overhead.csv"
pathOfApps="/home/aulapinroot/NPB3.0/NPB3.0-OMP/bin"

outputFile="../dados/exp5NAS_overhead/ResultExp5_overhead.csv"

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
	   sampling=$(echo "$row" | cut -d ',' -f7 | sed 's/"//g')
	   use=$(echo "$row" | cut -d ',' -f8 | sed 's/"//g')

	   export OMP_NUM_THREADS=$threads

	   if [ $user == "com" ]; then 
		timeSeconds=$(sudo likwid-perfctr -t 100ms -f -c N:0-31 -g L2CACHE "$pathOfApps/$versions" | grep -i "Time in seconds" | sed 's/[[:space:]]//g' | sed 's/[a-zA-Z=]//g')
	   else
		timeSeconds=$("$pathOfApps/$versions" | grep -i "Time in seconds" | sed 's/[[:space:]]//g' | sed 's/[a-zA-Z=]//g')
	   fi	   	

	   echo "$name,$runId,$runNumber,$runStd,$versions,$threads,$sampling,$use,$timeSeconds" >> $outputFile
	else
		echo $row >> $outputFile
		let i=$i+1
	fi
done
