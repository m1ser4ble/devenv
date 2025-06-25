local wezterm = require("wezterm")

config = wezterm.config_builder()

config = {
	automatically_reload_config = true,
	enable_tab_bar = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE", -- disable the title bar but enable the reizable border
	default_cursor_style = "BlinkingBar",
	color_scheme = "cyberpunk",
	font = wezterm.font("Hack Nerd Font Mono", { weight = "Bold" } ),
	font_size = 12.5,
	background = {
	{
		source= {
			Color = "#282c35",
		},
		width = "100%",
		height = "100%",
		opacity = 0.55,
	},
	}
}
return config
