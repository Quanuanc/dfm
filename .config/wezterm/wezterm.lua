local wezterm = require("wezterm")
local keys = require("keymaps")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Dracula+"
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.initial_cols = 155
config.initial_rows = 44
config.font_size = 13
config.leader = { key = ";", mods = "CTRL" }
config.keys = keys
config.front_end = "WebGpu"

local platform = wezterm.target_triple

if string.find(platform, "windows") then
	config.default_prog = { "powershell.exe" }
elseif string.find(platform, "darwin") then
	config.font = wezterm.font_with_fallback({
		"JetBrains Mono",
		"PingFang SC",
	})
end

return config
