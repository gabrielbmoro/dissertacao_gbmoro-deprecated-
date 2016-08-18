cd exec_normal_par80/
array=$(/home/gbmoro/Programas/scorep-2.0.2/bin/otf2-print traces.otf2 | awk '{ print $1,$2,$3,$4,$5,$8,$11,$16,$19,$24,$27,$28,$31 }' | grep -i THREAD_TEAM_BEGIN | awk ' { print $2 } ')

threads=4

x=1

while [ $x -le $threads ];
do
      echo $array | cut -d ' ' -f$x
	x=$((x+1))
done
