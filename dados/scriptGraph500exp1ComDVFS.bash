#!/bin/bash

nameFile="/home/gabrielbmoro/dissertacao_gbmoro/dados/expGraph500Governors.csv"
pathOfApps="/home/gabrielbmoro/Programs/graph500/omp-csr/omp-csr"
pcm_path="/home/gabrielbmoro/Programs/IntelPerformanceCounterMonitor-V2.11/pcm.x"
outputFile="../dados/ResultExpGraph500_diferentesGovernors.csv"
numberOfCpus=32
c=0
ref=$(cat $nameFile)

tmp=""

i=0

for row in ${ref[@]}; do
   if [ $i -gt 0 ]; then		
         name=$(echo "$row" | cut -d ',' -f1)
         runId=$(echo "$row" | cut -d ',' -f2)
         runNumber=$(echo "$row" | cut -d ',' -f3)
         runStd=$(echo "$row" | cut -d ',' -f4)
         governors=$(echo "$row" | cut -d ',' -f5 | sed 's/"//g')
         threads=$(echo "$row" | cut -d ',' -f6 | sed 's/"//g')

	   while [ $c -lt $numberOfCpus ]; do 
		sudo echo -n "$governors" > "/sys/devices/system/cpu/cpu$c/cpufreq/scaling_governor"
		let c=$c+1
	   done
	   c=0
	   
         #definindo o número de threads e pinando-as em um core específico
          export OMP_NUM_THREADS=$threads
          export GOMP_CPU_AFFINITY="0-$threadNumber"

          sudo -E $pcm_path  --noJKTWA -r --external-program $pathOfApps -s 23 >> tmp.log
          cpuEnergy=$(cat tmp.log | awk ' { print $4 } ' | tail -n 1)
	  rm tmp.log		
	  timeSeconds=$($pathOfApps -s 23 | grep -i mean_time: | awk ' { print $2 } ' )
		
	  echo "$name,$runId,$runNumber,$runStd,$governors,$threads,$cpuEnergy,$timeSeconds" >> $outputFile
	else
		echo $row >> $outputFile
		let i=$i+1
	fi
done
