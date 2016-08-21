cd benchmarks/Graph500/log_Graph500exp/

numberOfCores=32

count=0

tmp="timeStamp"
while [ $count -lt $numberOfCores ]
do
	tmp=$tmp",C'$count'runtime_rdstc,C'$count'runtime_unshall,C'$count'clock,C'$count'cpi,C'$count'l2reqrate,C'$count'l2missrate,C'$count'l2missratio"
	count=$(echo "$count+1" | bc)
done

echo "$tmp" >> graph500L2.csv
echo "$tmp" >> graph500L3.csv

cat saidaGraph500L2_1.log | awk ' { for(i=4; i<=NF; i++) printf "%s",$i (i==NF?ORS:OFS) } ' | sed 's/[[:space:]]/,/g' >> graph500L2.csv
cat saidaGraph500L3_1.log | awk ' { for(i=4; i<=NF; i++) printf "%s",$i (i==NF?ORS:OFS) } ' | sed 's/[[:space:]]/,/g' >> graph500L3.csv

mv *.csv ../../../dados/
