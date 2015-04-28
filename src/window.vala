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
public NewGameDialog new_game_menu;
public MoveCounter moves;
public Button about_button;
public Board board;
public ActionBar actionbar;
public Grid main_grid;

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
		
		actionbar = new ActionBar ();
		main_grid = new Grid ();
		
		about_button = new Button.from_icon_name ("help-info-symbolic", IconSize.BUTTON);
		moves = new MoveCounter ();
		
		main_grid.set_orientation (Orientation.VERTICAL);
		
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
		
		var new_game_button = new NewGameButton ();
        start_game ();
        main_grid.add (actionbar); 
		
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
			about.visible = true;
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
		
		
        new_game_menu.new_game.connect ((x,y,dificulty) => {
            start_game (x,y,dificulty);
            
        });
	}
	
	public void start_game (int x = 4, int y = 4, int dificulty = 5) {
	    board.destroy ();
 	    board = new Board (x,y,dificulty);
 	    board.set_vexpand (true);
		board.set_vexpand_set (true);
 	    
 	    moves.change_generated (dificulty);
	    moves.change_user (0);
	    main_grid.attach (board,0,1,1,1);
		
		this.resize (100,300);
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
 //New device dialog
public class NewGameDialog : Gtk.Dialog {
	public signal void new_game (int x, int y, int dificulty);
	public Scale setup_x;
	public Scale setup_y;
	public Scale dificulty;
	public Gtk.Button start;
	
	protected override bool delete_event (Gdk.EventAny event) {
		this.hide(); 	
		return true;		
	}
	
	public NewGameDialog () {
		this.remove (this.get_child ());
		this.set_border_width (12);
		this.set_modal (true);
		var title 			= new Label ("<b>New Game: </b>");
		var width_label 	= new Label ("Width: ");
		var hight_label 	= new Label ("Hight: ");
		var dificulty_label = new Label ("Dificulty");
		
		title.set_use_markup (true);
		title.xalign = 0;
		width_label.xalign = 0;
		hight_label.xalign = 0;
		
		set_keep_above (true);
		set_size_request (420, 300);
		resizable = false;
		
		var x_values = new Adjustment (4, 4, 7, 1, 1, 1);
		var y_values = new Adjustment (4, 4, 8, 1, 1, 1);
		var dificulty_values = new Adjustment (3, 1, 51, 1, 1, 1);
			 	
	 	setup_x = new Scale (Orientation.HORIZONTAL, x_values);	
        setup_y = new Scale (Orientation.HORIZONTAL, y_values);
        dificulty = new Scale (Orientation.HORIZONTAL, dificulty_values);
        
        setup_x.set_digits (0);
        setup_y.set_digits (0);
        dificulty.set_digits (0);
        
        setup_y.set_size_request (10,40);
        setup_x.set_value_pos (PositionType.LEFT);
        setup_y.set_value_pos (PositionType.LEFT);
        dificulty.set_value_pos (PositionType.LEFT);
        
		start = new Button.with_label ("Start");
		
		start.clicked.connect (() => {
		    new_game ((int) x_values.value,(int) y_values.value, (int) dificulty_values.value);
		    this.hide ();
		});
		
	 	var grid = new Grid ();
        
	 	grid.attach (title,			0,  0,  1,  1);
		grid.attach (width_label, 	0,	1, 	1,	1);
		grid.attach (setup_x,  		1,	1, 	2,	1);
		grid.attach (hight_label, 	0,	2, 	1,	1);
		grid.attach (setup_y,  		1,	2, 	2,	1);
		grid.attach (dificulty_label,0, 3,  1,  1);
		grid.attach (dificulty,  	1,	3, 	2,	1);
        grid.attach (start,         2,  4,  1,  1);
        
        this.add (grid);
        
        grid.set_column_homogeneous (true);
		grid.set_row_homogeneous (true);
		grid.row_spacing = 12;
		grid.set_column_spacing (5);
		grid.show_all ();           
	}
}

public class NewGameButton : Grid {
	public Button new_game_button;
	public Button setup_button;
		
	public NewGameButton () {
		this.get_style_context ().add_class ("linked");
		this.set_orientation (Orientation.HORIZONTAL);
		var arrow = new Arrow (ArrowType.DOWN, ShadowType.NONE);
		new_game_menu = new NewGameDialog ();

		arrow.get_style_context ().add_class ("close");
		new_game_button = new Button.with_label ("New Game");
		setup_button = new Button ();
		setup_button.add (arrow);
		
		this.add (new_game_button);
		this.add (setup_button);
		
		this.setup_button.clicked.connect (() => {
			new_game_menu.visible = true;
		});
		
		this.new_game_button.clicked.connect (() => {
    		new_game_menu.new_game (board.x, board.y, board.dificulty);
		});
		
		headerbar.pack_start (this);
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
	
	public void change_user (int a = 0) {
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
			board.user_moves = undo ();
			moves.change_user (board.user_moves);
			board.Update ();
		});
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
