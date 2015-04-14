extern int setup(int[,] a);
extern int populate ();

void main () { 
	int hight = 2;
	int length = 7;
	
	var matrix = new int[hight,length];
	
	for (int i = 0; i < hight; i++) {  
	for (int j = 0; j < length; j++) {
		matrix[i,j] = 1;
	}}
	 
	setup (matrix); 
 	populate ();
 	
	for (int i = 0; i < hight; i++) { 
	for (int j = 0; j < length; j++) {
		stdout.printf (@"$(matrix[i,j]) ");
	}
		stdout.printf ("\n");
	}
}
