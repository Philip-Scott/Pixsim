using Gtk;
using Math;
using Granite.Services;

extern int setup(int[,] a);
extern int populate (int dificulty);

namespace Pixsim {
public int[,] Value_Matrix;
public Light[,] Light_Matrix;


public class Board : Grid {
	public int user_moves = 0;
	public signal void Light_Clicked ();
	public signal void Update ();
	public int x;
	public int y;
	public int dificulty;
	
	public Board (int x_ = 3, int y_ = 3, int dificulty_ = 5) {
	    x = x_;
	    y = y_;
	    dificulty = dificulty_;
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
			moves.change_user (this.user_moves);
		});
		
		setup (Value_Matrix); 
 		populate (dificulty);
 		Update ();
		this.show_all ();
	}

}}
