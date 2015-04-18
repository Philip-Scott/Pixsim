#include <stdio.h>
#include "pixsim.h"

// Prepare enviroment variables. 
int setup (int *set_matrix, int set_y, int set_x) {
	x = set_x;
	y = set_y;
	matrix = set_matrix;
	printf ("C DEBUG: X = %d, Y = %d,\n", x, y);
 	return 1;
}
