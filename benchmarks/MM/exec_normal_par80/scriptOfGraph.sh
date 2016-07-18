#path: benchmarks/MM/exec_normal_par80/

threadsFiles=$(ls | grep -i thre)

for x in ${threadsFiles[@]};
do
	array=$(cat $x | awk '{ print $6 $7"\n"$8 $9"\n"$10 $11"\n"$12 $13}' | sed 's/(//g' | sed 's/)//g' | sed 's/\"/,/g' | sed 's/,,/,/g')
	idThread=$(echo $x | sed 's/.csv//g'| sed 's/thread_//g')

	for i in ${array[@]};
	do
    	if [[ $i =~ .*@.* || $i =~ .*\<.* || $i =~ .*Threads.* ]]; then
	   		continue	    
		else
		    	echo "$idThread,$i" >> threadAnalyse.csv
		fi
	done
done

echo "thread,hardwareCounter,value" >> threadAnalyseOutput.csv
cat threadAnalyse.csv | sed 's/,,/,/g' |  sed 's/,*$//' >> threadAnalyseOutput.csv
rm threadAnalyse.csv 
