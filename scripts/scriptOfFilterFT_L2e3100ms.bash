cd benchmarks/NAS-OMP/log_NASExp2FT/

numberOfCores=32

count=0

tmp="timeStamp"
while [ $count -lt $numberOfCores ]
do
	tmp=$tmp",C'$count'runtime_rdstc,C'$count'runtime_unshall,C'$count'clock,C'$count'cpi,C'$count'l2reqrate,C'$count'l2missrate,C'$count'l2missratio"
	count=$(echo "$count+1" | bc)
done

echo "$tmp" >> ftexp2L3CACHEg100ms.csv
echo "$tmp" >> ftexp2L2CACHEg100ms.csv

cat saidaFt100l2_1.log | awk ' { for(i=4; i<=NF; i++) printf "%s",$i (i==NF?ORS:OFS) } ' | sed 's/[[:space:]]/,/g' >> ftexp2L3CACHEg100ms.csv
cat saidaFt100l3_1.log | awk ' { for(i=4; i<=NF; i++) printf "%s",$i (i==NF?ORS:OFS) } ' | sed 's/[[:space:]]/,/g' >> ftexp2L3CACHEg100ms.csv

mv *.csv ../../dados/
