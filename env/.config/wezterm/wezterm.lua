local wezterm = require('wezterm')

local config = wezterm.config_builder()

-- config.color_scheme = 'Default (dark) (terminal.sexy)'
config.font = wezterm.font {
    family = 'JetBrains Mono',
    weight = 'Medium',
}
config.font_size = 14
config.colors = require("cyberdream")

config.use_fancy_tab_bar = false
config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'

return config
