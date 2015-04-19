#include <stdio.h>
#include "pixsim.h"
#include "pilas.h"

//*(matrix + j + x * i) //Go to (i,j)
//User clicked on (j,k) 
//TODO Program funcion
//TODO Save clicks to stack
int click (int j, int k) {
	//Debug 
	push(&movesj,j);
	push(&movesk,k);
	
	printf ("Clicked: x: %d y: %d\n",j,k);
	/*  j,k (1,2)
	0 0 0 0 0 0 0 0	0 * 0 0
	matrix + 1 + y * 2
	*/
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
}
