using Gtk;
using Math;
using Granite.Services;

namespace Pixsim {
public int[,] Value_Matrix;
public Light[,] Light_Matrix;

public class Board : Grid {
	
	public Board (int x = 3, int y = 3) {
		set_row_spacing (4);
		set_column_spacing (4);
		set_row_homogeneous  (true);
		set_column_homogeneous (true);
				
		Value_Matrix = new int[x,y];
		Light_Matrix = new Light[x,y];
		
		for (int i = 0; i < x; i++) { 
		for (int j = 0; j < y; j++) {
			Light_Matrix[i,j] = new Light (); 
			this.attach (Light_Matrix[i,j], j, i, 1, 1);
		}}
	}

}}
