#!bin/bash

function toExport() {
	export SCOREP_ENABLE_TRACING=true
	export SCOREP_METRIC_RUSAGE=ru_utime,ru_stime
	export SCOREP_TOTAL_MEMORY=3G
}

function execute() {
	scorepPath=/home/aulapinroot/Programs/scorep-2.0.2/bin

	cat expDesign_MM.csv | head -1 >> Results_expMM.csv

	lines=$(cat expDesign_MM.csv)

	count=0
	h=0
	for i in ${lines[@]}; do

		if [ $h -gt 1 ]; then
		    
			echo "definindo variáveis de ambiente"
			echo "exportando as variáveis utilizadas pelo scorep"

			toExport

			name=$(echo $i | cut -d ',' -f1)
			runNoInStdOrder=$(echo $i | cut -d ',' -f2)
			runNo=$(echo $i | cut -d ',' -f3)
			runRP=$(echo $i | cut -d ',' -f4)
			app=$(echo $i | cut -d ',' -f5 | sed 's/\"//g')
			size=$(echo $i | cut -d ',' -f6 | sed 's/\"//g')

			echo "$app"

			export SCOREP_METRIC_PAPI=PAPI_L2_DCH,PAPI_L2_DCA,PAPI_L1_TCM
			export SCOREP_EXPERIMENT_DIRECTORY="tmp"

			timeOfExecution=$(sudo -E ./$app $size | sed 's/HPCELO://g')
			
			$result1=$($scorepPath/otf2-print /tmp/traces.otf2 | awk ' { print $1,$3,$11,$15,$19,$20} ' | sed 's/[\")(,]//g')

			toExport

			export SCOREP_METRIC_PAPI=PAPI_L2_TCM,PAPI_L3_TCM,PAPI_FP_OPS
			export SCOREP_EXPERIMENT_DIRECTORY="tmp2"

			sudo -E ./$app $size
			
			$result2=$($scorepPath/otf2-print /tmp2/traces.otf2 | awk ' { print $1,$3,$11,$15,$19,$20} ' | sed 's/[\")(,]//g') 

			sizeOfElements=$(echo $result1 | wc -l)

			while [ $count -lt $sizeOfElements ];
			do
				$name,$runNoInStdOrder,$runNo,$runRP,$app,$size,$timeOfExecution,${result1[$count]},${result2[$count]} >> Results_expMM.csv
				let count=$count+1;
			done;

			count=0
			sudo rm -rf tmp tmp2
		fi

		let h=$h+1;

	done
}

execute
