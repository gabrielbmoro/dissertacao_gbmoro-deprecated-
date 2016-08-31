#!bin/bash
cd scripts

nameFile="../dados/exp4NAS_semlikwid/exp4NASDesign.csv"

ref=$(cat $nameFile)

i=0

for row in ${ref[@]}; do
	if [ $i -gt 0 ]; then
		name=$(echo "$row" | cut -d ',' -f1)
		runId=$(echo "$row" | cut -d ',' -f2)
		runNumber=$(echo "$row" | cut -d ',' -f3)
		runStd=$(echo "$row" | cut -d ',' -f4)
		version=$(echo "$row" | cut -d ',' -f5 | sed 's/"//g')
		threads=$(echo "$row" | cut -d ',' -f6 | sed 's/"//g')
		time=0
		
		export OMP_NUM_THREADS=$threads

		time=$(./$version | grep -i time | sed 's/Time[[:space:]]in[[:space:]]seconds//g' | sed 's/=//g' | sed 's/[[:space:]]//g')
		echo "$name,$runId,$runNumber,$runStd,$version,$threads,$time" >> "Results.csv"
	else
		echo $row | sed 's/,,/,/g' >> "Results.csv"
		let i=$i+1
	fi
done
