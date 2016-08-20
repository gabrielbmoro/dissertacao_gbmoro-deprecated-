#!bin/bash
rm -rf log_NASExp2FT
mkdir log_NASExp2FT

benchpath=/home/aulapinroot/Programs/NPB3.3.1/NPB3.3-OMP/bin

ft_command=$benchpath/ft.B.x

sudo likwid-perfctr -t 100ms -f -c N:0-31 -g L3CACHE $ft_command >> log_NASExp2/saidaFt100l3_2.log 2>> log_NASExp2/saidaFt100l3_1.log 

sudo likwid-perfctr -t 100ms -f -c N:0-31 -g L2CACHE $ft_command >> log_NASExp2/saidaFt100l2_2.log 2>> log_NASExp2/saidaFt100l2_1.log 
