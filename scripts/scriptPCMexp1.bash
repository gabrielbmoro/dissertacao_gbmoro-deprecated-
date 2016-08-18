pathOfIntelPCM=/home/aulapinroot/Programs/IntelPerformanceCounterMonitor-V2.11

app=normal_par

size=6000

flag=0

timeOfCollet=0.002 #em segundos
timeAcc=0.0

echo "The application $app is being executed..."
#disparando a aplicação alvo
./$app $size &

#cabeçalho do arquivo
echo "TimeStamp,L3miss,L2miss,L3hit,L2hit" >> Results.csv

while [ $flag -eq 0 ]; do
	echo "Time stamp - $timeAcc"

	#recuperando o estado do processo para ver se o mesmo está executando
	stateOfProcess=$(ps ux | grep -i $app | head -1 | awk ' { print $8 } ')

	#pegar a quantidade de Rs nesse fluxo de caracteres
	amountOfR=$(echo $stateOfProcess | grep R | wc -l | bc)	

	#se existir um R, então o processo está execuntando
	if [ $amountOfR == 1 ]; then
		flag=0;
	else
	    	flag=1;
	fi

	#aqui executo algum processo leve
	sudo -E $pathOfIntelPCM/pcm.x --noJKTWA -r --external-program clean >> tmp.log

	l3miss=$(cat tmp.log | grep -i "TOTAL *" | head -1 | awk ' { print $7,$8 } ')
	l3miss=$(echo $l3miss | sed -e 's/[[:space:]]K/*1024/g')
	l3miss=$(echo $l3miss | sed -e 's/[[:space:]]M/*1024*1024/g')
	l3miss=$(echo $l3miss | sed -e 's/[[:space:]]G/*1024*1024*1024/g')
	l3miss=$(echo $l3miss | bc)

	l2miss=$(cat tmp.log | grep -i "TOTAL *" | head -1 | awk ' { print $9,$10 } ')
	l2miss=$(echo $l2miss | sed -e 's/[[:space:]]K/*1024/g')
	l2miss=$(echo $l2miss | sed -e 's/[[:space:]]M/*1024*1024/g')
	l2miss=$(echo $l2miss | sed -e 's/[[:space:]]G/*1024*1024*1024/g')
	l2miss=$(echo $l2miss | bc)

	l3hit=$(cat tmp.log | grep -i "TOTAL *" | head -1 | awk ' { print $11 } ')
	l2hit=$(cat tmp.log | grep -i "TOTAL *" | head -1 | awk ' { print $12 } ')

	echo "$timeAcc,$l3miss,$l2miss,$l3hit,$l2hit" >> Results.csv

	#sleep $timeOfCollet

	#timeAcc=$(echo "$timeAcc+$timeOfCollet" | bc)
	timeAcc=$(echo "$timeAcc+1" | bc);
	rm tmp.log
done
