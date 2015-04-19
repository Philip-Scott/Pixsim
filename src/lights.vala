using Gtk;
using Math;
using Granite.Services;

extern int click (int x, int y);

namespace Pixsim {
public class Light : Gtk.ToggleButton {
	private int x;
	private int y;

	public Light (int set_x, int set_y) {
		int x = set_x;
		int y = set_y;
		set_size_request (90,90);
		this.clicked.connect (() => {
			theme ();
			click (x,y);
			
			for (int i = 0; i < 4; i++) { 
			for (int j = 0; j < 3; j++) {
				stdout.printf (@"$(Value_Matrix[i,j]) ");
			}
				stdout.printf ("\n");
			}
		});
	}
	
	private void theme () {
		if (this.get_active () == true) {
			this.get_style_context ().add_class ("lighton");
		} else {
			this.get_style_context ().remove_class ("lighton");
		}
	}
}}
