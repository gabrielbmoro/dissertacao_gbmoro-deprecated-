cd benchmarks/Graph500/log_Graph500exp/

numberOfCores=32
count=0

tmp="timeStamp"
while [ $count -lt $numberOfCores ]
do
	tmp=$tmp",C'$count'runtime_rdstc,C'$count'runtime_unshall,C'$count'clock,C'$count'cpi,C'$count'l2reqrate,C'$count'l2missrate,C'$count'l2missratio"
	count=$(echo "$count+1" | bc)
done

echo "$tmp" >> graph500L2CACHEg.csv
echo "$tmp" >> graph500L3CACHEg.csv

cat saidaGraph500L2_1.log | awk ' { for(i=4; i<=NF; i++) printf "%s",$i (i==NF?ORS:OFS) } ' | sed 's/[[:space:]]/,/g' >>  graph500L2CACHEg.csv

cat saidaGraph500L3_1.log | awk ' { for(i=4; i<=NF; i++) printf "%s",$i (i==NF?ORS:OFS) } ' | sed 's/[[:space:]]/,/g' >>  graph500L3CACHEg.csv

mv graph500L2CACHEg.csv ../../../dados/
mv graph500L3CACHEg.csv ../../../dados/
