local wezterm = require("wezterm")
local config = wezterm.config_builder()

--------------------------------------------------------
-- Basic
--------------------------------------------------------
config.automatically_reload_config = true
config.font_size = 12.0
config.use_ime = true
config.window_background_opacity = 0.85
config.macos_window_background_blur = 20
config.font = wezterm.font("JetBrainsMono Nerd Font")

-- tmuxをデフォルトで起動 (mainがあればattach、なければnew)
config.default_prog = { "zsh", "-lc", "tmux new-session -A -s main" }

-- TrueColorを安定させたい場合 (tmuxは別途 terminal-overrides 推奨)
config.term = "wezterm"

--------------------------------------------------------
-- Tab
--------------------------------------------------------
-- タイトルバーを非表示
config.window_decorations = "RESIZE"
-- タブバーの表示
config.show_tabs_in_tab_bar = true
-- タブが一つの時は非表示
config.hide_tab_bar_if_only_one_tab = true
-- falseにするとタブバーの透過が効かなくなる
-- config.use_fancy_tab_bar = false

-- タブバーの透過
config.window_frame = {
	inactive_titlebar_bg = "none",
	active_titlebar_bg = "none",
}

-- タブバーの背景色に合わせる
config.window_background_gradient = {
	colors = { "#000000" },
}

-- タブの追加ボタンを非表示
config.show_new_tab_button_in_tab_bar = false
-- nightlyのみ使用可能
-- タブの閉じるボタンを非表示
config.show_close_tab_button_in_tabs = false

-- タブ同士の境界線を非表示
config.colors = {
	tab_bar = {
		inactive_tab_edge = "none",
	},
}

-- タブの形をカスタマイズ
-- タブの左型を装飾
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local background = "#5c6d74"
	local foreground = "#FFFFFF"
	local edge_background = "none"
	if tab.is_active then
		background = "#ae8b2d"
		foreground = "#FFFFFF"
	end
	local edge_foreground = background
	local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "
	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

--------------------------------------------------------
-- keybinds
--------------------------------------------------------
config.leader = nil
config.key_tables = nil
config.disable_default_key_bindings = true
config.keys = {
	-- フォントサイズ (WezTerm固有の便利枠)
	{ key = "+", mods = "SUPER|SHIFT", action = wezterm.action.IncreaseFontSize },
	{ key = "-", mods = "SUPER", action = wezterm.action.DecreaseFontSize },
	{ key = "0", mods = "SUPER", action = wezterm.action.ResetFontSize },

	-- クリップボード
	{ key = "c", mods = "SUPER", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "v", mods = "SUPER", action = wezterm.action.PasteFrom("Clipboard") },

	-- フルスクリーン
	{ key = "Enter", mods = "SUPER", action = wezterm.action.ToggleFullScreen },
}

return config
