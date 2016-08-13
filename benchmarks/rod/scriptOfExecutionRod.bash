#!bin/bash

mkdir log_rodiniaExp1

benchpath=$HOME/Programs/rodinia_3.1/openmp

kmeans_command=$benchpath/kmeans/kmeans_openmp/kmeans -i ../../../data/kmeans/819200.txt -n 32
bfs_command=$benchpath/bfs/bfs 32 ../../data/bfs/graph1MW_6.txt
leukocyte_command=$benchpath/leukocyte/OpenMP/leukocyte 30 32 ../../../data/leukocyte/testfile.avi

#aqui o rastro vai ter cerca de 11 amostras 
sudo likwid-perfctr -t 1ms -f -c N:0-31 -g L2CACHE $bfs_command >> log_rodiniaExp1/saidaBfs_2.log 2>> log_rodiniaExp1/saidaBfs_1.log

#aqui o rastro vai ter cerca de 27 amostras
sudo likwid-perfctr -t 10ms -f -c N:0-31 -g L2CACHE $k_means_command >> log_rodiniaExp1/saidaKmeans_2.log 2>> log_rodiniaExp1/saidaKmeans_1.log

#aqui o rastro vai ter cerca de 24 amostras
sudo likwid-perfctr -t 50ms -f -c N:0-31 -g L2CACHE $leukocyte_command >> log_rodiniaExp1/saidaLeucocyte_2.log 2>> log_rodiniaExp1/saidaLeucocyte_1.log
