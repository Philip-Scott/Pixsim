using Gtk;
using Math;
using Granite.Services;

namespace Pixsim {
public class Light : Gtk.ToggleButton {

	public Light () {
		set_size_request (90,90);
		this.clicked.connect (() => {
			theme ();
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
