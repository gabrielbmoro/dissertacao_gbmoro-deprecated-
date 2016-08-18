cd benchmarks/NAS-OMP/log_NASExp1/

numberOfCores=32
count=0

tmp="timeStamp"
while [ $count -lt $numberOfCores ]
do
	tmp=$tmp",C'$count'runtime_rdstc,C'$count'runtime_unshall,C'$count'clock,C'$count'cpi,C'$count'l2reqrate,C'$count'l2missrate,C'$count'l2missratio"
	count=$(echo "$count+1" | bc)
done

echo "$tmp" >> btexp1L2CACHEg.csv

cat saidaBt_1.log | awk ' { for(i=4; i<=NF; i++) printf "%s",$i (i==NF?ORS:OFS) } ' | sed 's/[[:space:]]/,/g' >> btexp1L2CACHEg.csv

cat btexp1L2CACHEg.csv

mv btexp1L2CACHEg.csv ../../../dados/
