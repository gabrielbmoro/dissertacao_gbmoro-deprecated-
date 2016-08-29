#!bin/bash
rm -rf log_NASExp3
mkdir log_NASExp3

benchpath=/home/aulapinroot/Programs/NPB3.3.1/NPB3.3-OMP/bin

bt_command=$benchpath/bt.B.x
cg_command=$benchpath/cg.B.x
ft_command=$benchpath/ft.B.x
lu_command=$benchpath/lu.B.x
sp_command=$benchpath/sp.B.x
ua_command=$benchpath/ua.B.x

sudo likwid-perfctr -t 100ms -f -c N:0-31 -g L2CACHE -g L3CACHE  $bt_command >> log_NASExp3/saidaBt_2.log 2>> log_NASExp3/saidaBt_1.log 
sudo likwid-perfctr -t 50ms -f -c N:0-31 -g L2CACHE -g L3CACHE $cg_command >> log_NASExp3/saidaCg_2.log 2>> log_NASExp3/saidaCg_1.log 
sudo likwid-perfctr -t 30ms -f -c N:0-31 -g L2CACHE -g L3CACHE $ft_command >> log_NASExp3/saidaFt_2.log 2>> log_NASExp3/saidaFt_1.log 
sudo likwid-perfctr -t 100ms -f -c N:0-31 -g L2CACHE -g L3CACHE $lu_command >> log_NASExp3/saidaLu_2.log 2>> log_NASExp3/saidaLu_1.log 
sudo likwid-perfctr -t 225ms -f -c N:0-31 -g L2CACHE -g L3CACHE $sp_command >> log_NASExp3/saidaSp_2.log 2>> log_NASExp3/saidaSp_1.log 
sudo likwid-perfctr -t 110ms -f -c N:0-31 -g L2CACHE -g L3CACHE $ua_command >> log_NASExp3/saidaUa_2.log 2>> log_NASExp3/saidaUa_1.log 
