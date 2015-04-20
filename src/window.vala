using Gtk;
using Math;
using Granite.Services;

//valac-0.26 --pkg gtk+-3.0 --pkg granite --thread --target-glib 2.32 src/window.vala src/light.vala src/board.vala 

//This is how we link up the program to a c function
extern int undo (); 

namespace Pixsim {
public HeaderBar headerbar;
public HbButton undo_button;
public HbButton solve_button;
public CssProvider custom_css;
public MoveCounter moves;
public Button about_button;
public Board board;

public class App : Gtk.Window {
	public App () {
		headerbar = new HeaderBar ();
		headerbar.title = "Pixsim";
 		headerbar.show_close_button = false;
		this.set_titlebar (headerbar);
		this.destroy.connect(Gtk.main_quit);
		this.set_size_request (100,300);
		
		undo_button = new HbButton.Undo ();	
		solve_button = new HbButton.Solve ();
		headerbar.pack_end (solve_button);
		headerbar.pack_end (undo_button);
		
		var actionbar = new ActionBar ();
		var main_grid = new Grid ();
		board = new Board (4,4);
		about_button = new Button.from_icon_name ("help-info-symbolic", IconSize.BUTTON);
		moves = new MoveCounter ();
		main_grid.set_orientation (Orientation.VERTICAL);
		main_grid.add (board);
		main_grid.add (actionbar);
		actionbar.set_center_widget (moves);
		actionbar.pack_end (about_button);
		this.add (main_grid);
		var about = new About ();
		headerbar.set_decoration_layout ("");
		var close_button = new Button ();
		var close_label = new Label (" <b>x</b> ");
		close_button.add (close_label);
		close_label.set_use_markup (true);
		close_button.get_style_context ().add_class ("close");
		close_label.get_style_context ().add_class ("close");
		headerbar.pack_start (close_button);
		
		close_button.clicked.connect (() => {
			this.destroy ();
		});
				
		moves.changed.connect (() => {
			undo_button.check_undos ();
		});
		
		board.Light_Clicked.connect (() => {
			moves.change_user (moves.user_steps.label.to_int () + 1);
			undo_button.check_undos ();
		});
		
		about_button.clicked.connect (() => {
			about.visible = true;;
		});
		
		
		actionbar.set_hexpand (true);
		actionbar.set_hexpand_set (true);
		board.set_vexpand (true);
		board.set_vexpand_set (true);
		
		custom_css = new CssProvider ();
		var css_file = @"$user/custom.css";
		Gtk.Settings.get_default ().gtk_application_prefer_dark_theme = true;
		Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), custom_css, Gtk.STYLE_PROVIDER_PRIORITY_USER);
		custom_css.load_from_path (css_file);
		this.show_all ();
	}			
}

public class About : Gtk.Popover {
	public About () {
		var title = 	new Label ("Pixsim");
		var subtitle = 	new Label ("\"Simpix\" clone for linux\nwritten in C and Vala");
		var team = 		new Label ("By: \n- Felipe Bojorquez\n- Felipe Escoto\n- Fernando Villanueva");
		var grid = 		new Grid ();
		grid.set_orientation (Orientation.VERTICAL);
		grid.set_row_spacing (4);
		title.get_style_context ().add_class ("h2");
		subtitle.get_style_context ().add_class ("h3");
		team.get_style_context ().add_class ("h6");
		team.xalign = 0; 
		title.xalign = 0;
		subtitle.xalign = 0;
		
		this.border_width = 4;
		this.set_relative_to (about_button);
		this.add (grid);
		grid.add (title);
		grid.add (subtitle);
		grid.add (team);
		
		grid.show_all ();
	}
}

public class MoveCounter : Grid {
	public Label gen_steps;
	public Label user_steps;
	public signal void changed ();
	
	public MoveCounter () {
		this.set_orientation (Orientation.HORIZONTAL);
		var slash = new Label (" / ");
		gen_steps = new Label ("5"); 	//Place Holder
		user_steps = new Label ("0");		//Place Holder
		gen_steps.get_style_context ().add_class ("counter");
		user_steps.get_style_context ().add_class ("counter");
		slash.get_style_context ().add_class ("slash");
		
		this.add (gen_steps);
		this.add (slash);
		this.add (user_steps);
		this.set_tooltip_text ("Generated Steps / User Steps");
		this.set_margin_top (4);
		this.set_margin_left (12);
		this.set_margin_right (12);
	}
	
	public void change_user (int a) {
		user_steps.label = @"$a";
		changed ();
	}
	
	public void change_generated (int a) {
		gen_steps.label = @"$a";
		changed ();
	}
}

public class HbButton : Button {
	//public HbButton () {}
	private void commons (string a) {
		this.label = a;
		this.can_focus = false;
		
	}
	public int check_undos () {
		if (moves.user_steps.label == "0") {
			this.set_sensitive (false);
		} else {
			this.set_sensitive (true);
		}
		return 0;
	}
	
	public HbButton.Undo () {
		this.commons (" Undo");
		this.get_style_context ().add_class (@"button-left");
		this.clicked.connect (() => {
			moves.change_user (moves.user_steps.label.to_int () - 1);
			undo ();
			board.Update ();gi
	}
	public HbButton.Solve () {
		this.commons ("Solve ");
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
