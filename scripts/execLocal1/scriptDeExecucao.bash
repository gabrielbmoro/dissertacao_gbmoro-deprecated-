	#!/bin/bash

	pathOfNAS="/home/gabrielbmoro/Programas/NPB3.3.1/NPB3.3-OMP/bin"

	apps=("ft.B.x" "cg.B.x" "mg.B.x")

	export OMP_NUM_THREADS=4
	export GOMP_CPU_AFFINITY=0-4

	for i in ${apps[@]}; do

		export SCOREP_ENABLE_PROFILING=true 
		export SCOREP_ENABLE_TRACING=true 
		export SCOREP_TOTAL_MEMORY=3G 
		export SCOREP_METRIC_PAPI=PAPI_L2_TCA,PAPI_L2_DCM 
		export SCOREP_METRIC_RUSAGE=ru_utime,ru_stime
		export SCOREP_EXPERIMENT_DIRECTORY=$i-4threads_exp5
		
		sudo -E $pathOfNAS/$i

	done