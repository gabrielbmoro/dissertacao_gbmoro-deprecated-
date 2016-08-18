#!bin/bash

apps=( 
    "continuos_par" 
    "continuos_parT" 
    "normal_par" 
    "normal_parT" 
    "tiling_par" 
    "tiling_parT" 
)

inputSizes=( 
    50 
    60 
    80 
    100 
)

export SCOREP_ENABLE_TRACING=true
export SCOREP_TOTAL_MEMORY=3G
export SCOREP_PAGE_SIZE=800000
export SCOREP_METRIC_PAPI=PAPI_L1_DCM,PAPI_L1_ICM,PAPI_L1_TCM,PAPI_L2_DCM,PAPI_L2_ICM,PAPI_L2_TCM,PAPI_L2_ICA,PAPI_L3_ICA
export SCOREP_METRIC_RUSAGE=ru_utime,ru_stime


for j in ${apps[@]}
do 
  for i in ${inputSizes[@]}
  do
    echo "Running app: $j size: $i"
    export SCOREP_EXPERIMENT_DIRECTORY="exec_$jsize$i"
    sudo -E ./$j $i
  done
done
