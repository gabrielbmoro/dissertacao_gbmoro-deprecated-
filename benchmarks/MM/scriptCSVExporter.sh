scorepFolders=$( ls | grep -i "exec_")

threads=4

for i in ${scorepFolders[@]};
do
      cd $i
      
      array=$(/home/gbmoro/Programas/scorep-2.0.2/bin/otf2-print traces.otf2 | awk '{ print $1,$2,$3,$4,$5,$8,$11,$16,$19,$24,$27,$28,$31 }' | grep -i THREAD_TEAM_BEGIN | awk ' { print $2 } ')

	x=1
	
	echo "Folder: $i"
	while [ $x -le $threads ];
	do
		echo "Thread visited: $x"
    		idTmp=$(echo $array | cut -d ' ' -f$x)
		/home/gbmoro/Programas/scorep-2.0.2/bin/otf2-print traces.otf2 | sed 's/(//g' | sed 's/)//g' | sed 's/\"P/P/g' | sed 's/\"/,/g' | sed 's/C[[:space:]]/C,/g' | sed 's/[[:space:]]M/,M/g' | sed 's/[[:space:]]R/,R/g'  | sed 's/AVE[[:space:]]/AVE,/g' | sed 's/ER[[:space:]]/ER,/g' | awk '{ print $1,$2,$3,$4,$5,$8,$11,$16,$19,$24,$27,$28,$31 }' | grep -i $idTmp >> thread_$idTmp.csv
		x=$((x+1))
	done
	cd ..
done
