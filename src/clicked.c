#include <stdio.h>
#include "pixsim.h"
#include "pilas.h"
#include "colas.h"

struct Pila* movesj = NULL;
struct Pila* movesk = NULL;

struct Cola* stepsj = NULL; //Recordar inicializar pilas y colas a nulo
struct Cola* stepsk = NULL;

struct Pila* solvej = NULL;
struct Pila* solvek = NULL;

int pasos = 0;
int movimientos = 0;
//*(matrix + j + x * i) //Go to (i,j)
//User clicked on (j,k) 

//Setup enviroment variables
int setup (int *set_matrix, int set_y, int set_x) {
    while (!isEmpty(movesj)) {
        pop (&movesj);
    }
    
    while (!isEmpty(movesk)) {
        pop (&movesk);
    }
    
	x = set_x;
	y = set_y;
	matrix = set_matrix;
	movimientos = 0;	
	printf ("C DEBUG: X = %d, Y = %d,\n", x, y);
 	return 0;
}

//Setup game
int populate (int moves) {
	pasos = moves;

	int i, j, a, randomx, randomy;
	for(i = 0; i < y; i++) { // X Axis
	for (j = 0; j < x; j++) { // Y Axis
		array = 1;
	}}  
	
	srand(time(NULL));
    for (a = 0; a < moves; a++) {
        randomx = rand() % x;
        randomy = rand() % y;
        q_push(&stepsj, randomx); //Guardo movimientos generados en cola
        q_push(&stepsk, randomy);
        push(&solvej, randomx); //Save in a stack
        push(&solvek, randomy);
	    click (randomx, randomy, 1);
    }
}

int reset (int moves) { //Con esta función se genera un tablero igual al anterior
    int i, j, a;
    for(i = 0; i < y; i++) { // X Axis
        for (j = 0; j < x; j++) { // Y Axis
            array = 1;
        }}
    
    //Voy a hacer click usando los movimientos generados en populate guardados en la cola
    for (a = 0; a < 5; a++) {
        click (1, 1, 1);
    }
}

int undo () {
	int j,k;
	if(!isEmpty(movesj) && !isEmpty(movesk)){
		j = pop(&movesj);
		k = pop(&movesk);	
		click(j,k,1);
		movimientos--;	
	}
	
	return movimientos;

}

int click (int j, int k, int undo) {
	//Debug 
	if (undo == 0) {
		if(top(movesj) != j || top(movesk) != k){
			push(&movesj,j);
			push(&movesk,k);
			movimientos++;
		}
		else{
			pop(&movesj);
			pop(&movesk);
			movimientos--;
		}
	}
	
	printf ("Clicked: x: %d y: %d\n",j,k);
	
	if(*(matrix + j + x * k) == 1) //Cambiar el color del cuadro en el que se dio click
		*(matrix + j + x * k) = 0;
	else
		*(matrix + j + x * k) = 1;
	
	if((k-1) >= 0){ //Cambiar cuadro de arriba
		if(*(matrix + j + x * (k - 1)) == 1)
			*(matrix + j + x * (k - 1)) = 0;
		else
			*(matrix + j + x * (k - 1)) = 1; 
	}
	if((k+1) < x){ //Cambiar cuadro de abajo
	 	if(*(matrix + j + x * (k + 1)) == 1)
			*(matrix + j + x * (k + 1)) = 0;
		else
			*(matrix + j + x * (k + 1)) = 1; 
	}
	if((j-1) >= 0){ //Cambiar cuadro de la izq
		if( *(matrix + (j - 1)+ x * k) == 1)
			 *(matrix + (j - 1)+ x * k) = 0;
		else
			 *(matrix + (j - 1)+ x * k) = 1;
	}
	if((j+1) < y){ //Cambiar cuadro de la der
		if( *(matrix + (j + 1)+ x * k) == 1)
			 *(matrix + (j + 1)+ x * k) = 0;
		else
			 *(matrix + (j + 1)+ x * k) = 1;
	}	
	
	int a,b,c;
	
	printf ("C DEBUG\n");
	for(a = 0; a < x; a++) { // X Axis
	for (b = 0; b < y; b++) { // Y Axis
		c = *(matrix + b + (x * a));
		printf (" %d ",c);
	}
		printf ("\n");
	}  
	printf ("\n");
	printf ("\n");
	
	return movimientos;
}

int solve () {
	printf ("Solve\n");
    if (!q_isEmpty(solvej) && !q_isEmpty(solvek)) {
        click(pop(&solvej),pop(&solvek),1);

    }
    
    return pasos;    
}
