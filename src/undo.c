#include <stdio.h>
#include "pixsim.h"

int undo () {
	int j,k;
	
	j = pop(&movesj);
	k = pop(&movesk);
	
	click(j,k);
		
}
