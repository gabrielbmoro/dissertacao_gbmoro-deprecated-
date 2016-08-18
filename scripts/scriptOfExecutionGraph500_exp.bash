#!bin/bash
rm -rf log_Graph500exp
mkdir log_Graph500exp

benchpath=/home/aulapinroot/Programs/graph500/omp-csr

graph500_command=$benchpath/omp-csr

sudo likwid-perfctr -t 30ms -f -c N:0-31 -g L2CACHE $graph500_command >> log_Graph500exp/saidaGraph500L2_2.log 2>> log_Graph500exp/saidaGraph500L2_1.log 
sudo likwid-perfctr -t 30ms -f -c N:0-31 -g L3CACHE $graph500_command >> log_Graph500exp/saidaGraph500L3_2.log 2>> log_Graph500exp/saidaGraph500L3_1.log 
