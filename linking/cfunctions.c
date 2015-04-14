#include <stdio.h>
#define array *(matrix + j + y * i)

int x;
int y;
int* matrix;

int setup (int *set_matrix, int set_y, int set_x) {
	x = set_x;
	y = set_y;
	matrix = set_matrix;
	printf ("C DEBUG: X = %d, Y = %d,\n", x, y);
	
 	return 1;
}

int populate () {
	int i,j;
	int a = 1;
	for(i = 0; i < x; i++) { // X Axis
	for (j = 0; j < y; j++) { // Y Axis
		array = a++;
	}}  

}
