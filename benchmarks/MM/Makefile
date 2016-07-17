
# Gabriel Bronzatti Moro
# gabrielbronzattimoro.es@gmail.com

# FLAGS
FLAGS := -Wall -Wextra -O2
COMPILER := /home/gbmoro/Programas/scorep-2.0.2/bin/scorep gcc

# TARGET RULES
all: normal_seq normal_par continuos_seq continuos_par tiling_seq tiling_par normal_seqT normal_parT continuos_seqT continuos_parT tiling_seqT tiling_parT

normal_seq.o: normal.c
	$(COMPILER) $(FLAGS) -o $@ -c $<

normal_seq: hpcelo.c normal_seq.o
	$(COMPILER) $(FLAGS) -o $@ $+

normal_par.o: normal.c
	$(COMPILER) $(FLAGS) -fopenmp -o $@ -c $<

normal_par: hpcelo.c normal_par.o
	$(COMPILER) $(FLAGS) -fopenmp -o $@ $+

continuos_seq.o: continuos.c
	$(COMPILER) $(FLAGS) -o $@ -c $<

continuos_seq: hpcelo.c continuos_seq.o
	$(COMPILER) $(FLAGS) -o $@ $+

continuos_par.o: continuos.c
	$(COMPILER) $(FLAGS) -fopenmp -o $@ -c $<

continuos_par: hpcelo.c continuos_par.o
	$(COMPILER) $(FLAGS) -fopenmp -o $@ $+

tiling_seq.o: tiling.c
	$(COMPILER) $(FLAGS) -o $@ -c $<

tiling_seq: hpcelo.c tiling_seq.o
	$(COMPILER) $(FLAGS) -o $@ $+

tiling_par.o: tiling.c
	$(COMPILER) $(FLAGS) -fopenmp -o $@ -c $<

tiling_par: hpcelo.c tiling_par.o
	$(COMPILER) $(FLAGS) -fopenmp -o $@ $+

normal_seqT.o: normalT.c
	$(COMPILER) $(FLAGS) -o $@ -c $<

normal_seqT: hpcelo.c normal_seqT.o
	$(COMPILER) $(FLAGS) -o $@ $+

normal_parT.o: normalT.c
	$(COMPILER) $(FLAGS) -fopenmp -o $@ -c $<

normal_parT: hpcelo.c normal_parT.o
	$(COMPILER) $(FLAGS) -fopenmp -o $@ $+

continuos_seqT.o: continuosT.c
	$(COMPILER) $(FLAGS) -o $@ -c $<

continuos_seqT: hpcelo.c continuos_seqT.o
	$(COMPILER) $(FLAGS) -o $@ $+

continuos_parT.o: continuosT.c
	$(COMPILER) $(FLAGS) -fopenmp -o $@ -c $<

continuos_parT: hpcelo.c continuos_parT.o
	$(COMPILER) $(FLAGS) -fopenmp -o $@ $+

tiling_seqT.o: tilingT.c
	$(COMPILER) $(FLAGS) -o $@ -c $<

tiling_seqT: hpcelo.c tiling_seqT.o
	$(COMPILER) $(FLAGS) -o $@ $+

tiling_parT.o: tilingT.c
	$(COMPILER) $(FLAGS) -fopenmp -o $@ -c $<

tiling_parT: hpcelo.c tiling_parT.o
	$(COMPILER) $(FLAGS) -fopenmp -o $@ $+

clean:
	rm -f *.o 
	rm normal_seq normal_par continuos_seq continuos_par tiling_seq tiling_par normal_seqT normal_parT continuos_seqT continuos_parT tiling_seqT tiling_parT
