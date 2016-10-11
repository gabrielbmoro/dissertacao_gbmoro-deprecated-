
# Gabriel Bronzatti Moro
# gabrielbronzattimoro.es@gmail.com

# FLAGS
FLAGS := -Wall -Wextra

# TARGET RULES
all: main_par main_parGuided main_parStatic main_seq

main_par.o : Mandelbrot_par.c
	gcc $(FLAGS) -fopenmp -o $@ -c $<

main_par: cmp134.c main_par.o
	gcc $(FLAGS) $(FLAGS) -fopenmp -o $@ $+

main_parGuided.o : Mandelbrot_parGuided.c
	gcc $(FLAGS) -fopenmp -o $@ -c $<

main_parGuided: cmp134.c main_parGuided.o
	gcc $(FLAGS) $(FLAGS) -fopenmp -o $@ $+

main_parStatic.o : Mandelbrot_parStatic.c
	gcc $(FLAGS) -fopenmp -o $@ -c $<

main_parStatic: cmp134.c main_parStatic.o
	gcc $(FLAGS) $(FLAGS) -fopenmp -o $@ $+

main_seq.o : Mandelbrot_seq.c
	gcc $(FLAGS) -o $@ -c $<

main_seq: cmp134.c main_seq.o
	gcc $(FLAGS) -o $@ $+
	
clean:
	rm -f *.o 
	rm main_seq main_par main_parGuided main_parStatic
