using Gtk;
using Math;
using Granite.Services;

extern int click (int x, int y, int undo);

namespace Pixsim {
public class Light : Gtk.Button {
	private int x;
	private int y;
	private bool active;
	
	public Light (int set_x, int set_y, Board board) {
		x = set_x;
		y = set_y;
		set_size_request (90,90);
		this.can_focus = false;
		this.clicked.connect (() => {
			theme ();
			board.user_moves = click (x,y,0);			
			board.Light_Clicked ();
			moves.change_user (board.user_moves);
		});
		
		board.Update.connect (() => {
			if (Value_Matrix[y,x] == 1) this.active = (true);
			else this.active = (false);
			theme ();
		});
	}
	
	public void update () {
		theme ();
	}
	
	private void theme () {
		if (this.active == true) {
			this.get_style_context ().add_class ("lighton");
		} else {
			this.get_style_context ().remove_class ("lighton");
		}
	}
}}
