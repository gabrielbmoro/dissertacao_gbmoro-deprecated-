cd benchmarks/NAS-OMP/log_NASExp1/

numberOfCores=32

count=0

tmp="timeStamp"
while [ $count -lt $numberOfCores ]
do
	tmp=$tmp",C'$count'runtime_rdstc,C'$count'runtime_unshall,C'$count'clock,C'$count'cpi,C'$count'l2reqrate,C'$count'l2missrate,C'$count'l2missratio"
	count=$(echo "$count+1" | bc)
done

echo "$tmp" >> cgexp1L2CACHEg.csv
echo "$tmp" >> ftexp1L2CACHEg.csv
echo "$tmp" >> luexp1L2CACHEg.csv
echo "$tmp" >> spexp1L2CACHEg.csv
echo "$tmp" >> uaexp1L2CACHEg.csv

cat saidaCg_1.log | awk ' { for(i=4; i<=NF; i++) printf "%s",$i (i==NF?ORS:OFS) } ' | sed 's/[[:space:]]/,/g' >> cgexp1L2CACHEg.csv
cat saidaFt_1.log | awk ' { for(i=4; i<=NF; i++) printf "%s",$i (i==NF?ORS:OFS) } ' | sed 's/[[:space:]]/,/g' >> ftexp1L2CACHEg.csv
cat saidaLu_1.log | awk ' { for(i=4; i<=NF; i++) printf "%s",$i (i==NF?ORS:OFS) } ' | sed 's/[[:space:]]/,/g' >> luexp1L2CACHEg.csv
cat saidaSp_1.log | awk ' { for(i=4; i<=NF; i++) printf "%s",$i (i==NF?ORS:OFS) } ' | sed 's/[[:space:]]/,/g' >> spexp1L2CACHEg.csv
cat saidaUa_1.log | awk ' { for(i=4; i<=NF; i++) printf "%s",$i (i==NF?ORS:OFS) } ' | sed 's/[[:space:]]/,/g' >> uaexp1L2CACHEg.csv


mv *.csv ../../../dados/
