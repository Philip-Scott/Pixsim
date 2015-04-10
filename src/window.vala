using Gtk;
using Math;
using Granite.Services;

//valac-0.26 --pkg gtk+-3.0 --pkg granite --thread --target-glib 2.32 src/window.vala src/light.vala src/board.vala 
//This is how we link up the program to a c function
//extern int cfunction(); 

namespace Pixsim {
public HeaderBar headerbar;
public HbButton undo_button;
public HbButton solve_button;
public CssProvider custom_css;

public class App : Gtk.Window {
	public App () {
		headerbar = new HeaderBar ();
		headerbar.title = "Pixsim";
 		headerbar.show_close_button = true;
		this.set_titlebar (headerbar);
		this.destroy.connect(Gtk.main_quit);
		this.set_size_request (100,300);
		
		undo_button = new HbButton.Undo ();	
		solve_button = new HbButton.Solve ();
		headerbar.pack_end (solve_button);
		headerbar.pack_end (undo_button);
		
		custom_css = new CssProvider ();
		var css_file = @"/home/$user/Code/Pixsim/custom.css";
		Gtk.Settings.get_default ().gtk_application_prefer_dark_theme = true;
		Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), custom_css, Gtk.STYLE_PROVIDER_PRIORITY_USER);
		custom_css.load_from_path (css_file);
	}		
}

public class HbButton : Button {
	//public HbButton () {}
	private void commons () {
		this.can_focus = false;
		
	}
	
	public HbButton.Undo () {
		this.commons ();
		this.label = "Undo";
		this.get_style_context ().add_class (@"button-left");
		this.clicked.connect (() => {
			//TODO: Connect to C Function
		});
	}
	public HbButton.Solve () {
		this.commons ();
		this.label = "Solve";
		this.get_style_context ().add_class (@"button-right");
		this.clicked.connect (() => {
			//TODO: Connect to C Function
		});
	}
}

public class SolveButton : Button {
	public SolveButton () {
		this.label = "Solve";
		//TODO Set CSS Class
		
		this.clicked.connect (() => {
			//TODO: Connect to C Function
		});
	}
}

public static int main(string[] args) {
    Gtk.init(ref args);
	var app = new App();
	
	app.show_all ();
	Gtk.main();
    return 0;
}

}
