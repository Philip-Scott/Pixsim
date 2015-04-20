using Gtk;
using Math;
using Granite.Services;

extern int setup(int[,] a);
extern int populate ();

namespace Pixsim {
public int[,] Value_Matrix;
public Light[,] Light_Matrix;


public class Board : Grid {

	public signal void Light_Clicked ();
	public signal void Update ();
		
	public Board (int x = 3, int y = 3) {
		set_row_spacing (4);
		set_column_spacing (4);
		set_row_homogeneous  (true);
		set_column_homogeneous (true);
		
		//Button Matrix		
		Value_Matrix = new int[x,y];
		Light_Matrix = new Light[x,y];
		
		for (int i = 0; i < x; i++) { 
		for (int j = 0; j < y; j++) {
			Light_Matrix[i,j] = new Light (i,j, this); 
			this.attach (Light_Matrix[i,j], j, i, 1, 1);
		}}
		
		//Create and fill matrix with 0s
		for (int i = 0; i < x; i++) {  
		for (int j = 0; j < y; j++) {
			Value_Matrix[i,j] = 0;
		}}
		
		Light_Clicked.connect (() => {
			Update ();
		});
		
		setup (Value_Matrix); 
 		populate ();
		this.show_all ();
	}

}}
