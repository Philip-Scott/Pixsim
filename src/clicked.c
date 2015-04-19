#include <stdio.h>
#include "pixsim.h"

//*(matrix + j + x * i) //Go to (i,j)
//User clicked on (j,k) 
//TODO Program funcion
//TODO Save clicks to stack
int click (int j, int k) {
	//Debug 
	
	printf ("Clicked: x: %d y: %d\n",j,k);
	/*  j,k (1,2)
	0 0 0 0 0 0 0 0	0 * 0 0
	matrix + 1 + y * 2
	*/
	if(*(matrix + j + x * k) == 0) //Cambiar el color del cuadro en el que se dio click
		*(matrix + j + x * k) = 1;
	else
		*(matrix + j + x * k) = 0;
	
	if((k-1) >= 0){ //Cambiar cuadro de arriba
		if(*(matrix + j + x * (k - 1)) == 0)
			*(matrix + j + x * (k - 1)) = 1;
		else
			*(matrix + j + x * (k - 1)) = 0; 
	}
	if((k+1) < y){ //Cambiar cuadro de abajo
	 	if(*(matrix + j + x * (k + 1)) == 0)
			*(matrix + j + x * (k + 1)) = 1;
		else
			*(matrix + j + x * (k + 1)) = 0; 
	}
	if((j-1) >= 0){ //Cambiar cuadro de la izq
		if( *(matrix + (j - 1)+ x * k) == 0)
			 *(matrix + (j - 1)+ x * k) = 1;
		else
			 *(matrix + (j - 1)+ x * k) = 0;
	}
	if((j+1) < x){ //Cambiar cuadro de la der
		if( *(matrix + (j + 1)+ x * k) == 0)
			 *(matrix + (j + 1)+ x * k) = 1;
		else
			 *(matrix + (j + 1)+ x * k) = 0;
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
