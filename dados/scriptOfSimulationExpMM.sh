#!bin/bash


function toClear() {
	sudo rm -rf tmp tmp2 tmp.csv tmp2.csv Results_expMM.csv
}

function toExport() {
	export SCOREP_ENABLE_TRACING=true
	export SCOREP_METRIC_RUSAGE=ru_utime,ru_stime
	export SCOREP_TOTAL_MEMORY=3G
}

function execute() {
	scorepPath=/home/aulapinroot/Programs/scorep-2.0.2/bin

	cat expDesign_MM.csv | head -1 >> Results_expMM.csv

	lines=$(cat expDesign_MM.csv)

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

			echo "Executando -- $app"

			export SCOREP_METRIC_PAPI=PAPI_L2_DCH,PAPI_L2_DCA,PAPI_L1_TCM
			export SCOREP_EXPERIMENT_DIRECTORY="tmp"

			timeOfExecution=$(sudo -E ./$app $size | sed 's/HPCELO://g')
			
			$scorepPath/otf2-print tmp/traces.otf2 | awk ' { print $1,$3,$11,$15,$19,$20} ' | sed 's/[\")(,]//g' | sed 's/\ /,/g' | sed 's/,,,,//g' | sed 's/,ru_utime//g' >> tmp.csv
			
			toExport

			export SCOREP_METRIC_PAPI=PAPI_L2_TCM,PAPI_L3_TCM,PAPI_FP_OPS
			export SCOREP_EXPERIMENT_DIRECTORY="tmp2"

			sudo -E ./$app $size
			
			$scorepPath/otf2-print tmp2/traces.otf2 | awk ' { print $1,$3,$11,$15,$19,$20} ' | sed 's/[\")(,]//g' | sed 's/\ /,/g' | sed 's/,,,,//g' | sed 's/,ru_utime//g' >> tmp2.csv 


			paste tmp.csv tmp2.csv > tmpR.csv
			
			sed -i 's/\t/,/g' tmpR.csv

			res=$(cat tmpR.csv)

			for count in ${res[@]}; do
				echo "$name,$runNoInStdOrder,$runNo,$runRP,$app,$size,$timeOfExecution,$count" >> Results_expMM.csv
			done;

			
			sudo rm -rf tmp tmp2 tmp.csv tmp2.csv tmpR.csv 
		fi

		let h=$h+1;
		echo "interation $h"
	done
}

toClear

execute
