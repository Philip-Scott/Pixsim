#include <stdio.h>
#include "pixsim.h"

//*(matrix + j + y * i) //Go to (i,j)
//User clicked on (j,k) 
//TODO Program funcion
//TODO Save clicks to stack
int click (int j, int k) {
	
	if(*matrix[j][k] == 0) //Cambiar el color del cuadro en el que se dio click
		*matrix[j][k] = 1;
	else
		*matrix[j][k] = 0;
	
	if((k-1) > 0){ //Cambiar cuadro de arriba
		if(*matrix[j][k-1] == 0)
			*matrix[j][k-1] = 1;
		else
			*matrix[j][k-1] = 0; 
	}
	if((k+1) < y){ //Cambiar cuadro de abajo
	 	if(*matrix[j][k+1] == 0)
			*matrix[j][k+1] = 1;
		else
			*matrix[j][k+1] = 0; 
	}
	if((j-1) > 0){ //Cambiar cuadro de la izq
		if(*matrix[j-1][k] == 0)
			*matrix[j-1][k] = 1;
		else
			*matrix[j-1][k] = 0;
	}
	if((j+1) < x){ //Cambiar cuadro de la der
		if(*matrix[j+1][k] == 0)
			*matrix[j+1][k] = 1;
		else
			*matrix[j+1][k] = 0;
	}	
}
