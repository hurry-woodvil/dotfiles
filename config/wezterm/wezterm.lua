local wezterm = require("wezterm")

local config = wezterm.config_builder()

require("appearance").apply(config)
require("keymaps").apply(config)
require("launch").apply(config)

return config
