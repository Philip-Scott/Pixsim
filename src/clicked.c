#include <stdio.h>
#include "pixsim.h"
#include "pilas.h"

struct Pila* movesj;
struct Pila* movesk;
int movimientos = 0;
//*(matrix + j + x * i) //Go to (i,j)
//User clicked on (j,k) 
//TODO Program funcion
//TODO Save clicks to stack
int undo () {
	int j,k;
	
	if(!isEmpty(movesj) && !isEmpty(movesk)){
		j = pop(&movesj);
		k = pop(&movesk);	
		click(j,k,1);
		movimientos--;	
	}
	
	return 1;

}

int click (int j, int k, int undo) {
	//Debug 
	if (undo == 0) {
		if(top(movesj) != j && top(movesk) != k){
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
