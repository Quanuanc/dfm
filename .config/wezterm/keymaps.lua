local wezterm = require("wezterm")
return {
	{ key = "H", mods = "SHIFT|CTRL", action = wezterm.action.DisableDefaultAssignment },
	{ key = "L", mods = "SHIFT|CTRL", action = wezterm.action.DisableDefaultAssignment },
	{ key = "Enter", mods = "META", action = wezterm.action.DisableDefaultAssignment },
	{ key = "1", mods = "CMD", action = wezterm.action.DisableDefaultAssignment },
}
