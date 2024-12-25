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
-- config.window_background_opacity = 0.5
-- config.win32_system_backdrop = 'Acrylic'
config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'

return config
