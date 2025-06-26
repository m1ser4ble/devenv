local wezterm = require("wezterm")

config = wezterm.config_builder()
local home = wezterm.home_dir
config = {
	automatically_reload_config = true,
	enable_tab_bar = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE", -- disable the title bar but enable the reizable border
	default_cursor_style = "BlinkingBar",
	color_scheme = "cyberpunk",
	font = wezterm.font("Hack Nerd Font Mono", { weight = "Bold" } ),
	font_size = 30,
	background = {
		{
		   source = {
		      File = home .. "/.config/wezterm/backgrounds/cyberpunk.png",
		    },
		    hsb = {
		            hue=1.0,
		            saturation=1.02,
		            brightness=0.25,
		    },
		    width="100%",
		    height="100%",

		},

		{
			source= {
				Color = "#282c35",
			},
			width = "100%",
			height = "100%",
			opacity = 0.55,
		},
	},
  initial_rows = 100,
  initial_cols = 180,
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = false,

}
return config
