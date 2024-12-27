local wezterm = require('wezterm')
local act = wezterm.action
local config = wezterm.config_builder()

local target = wezterm.target_triple

if target:find("windows") then
    config.default_prog = { "pwsh" }
end
-- config.color_scheme = 'Default (dark) (terminal.sexy)'
config.font = wezterm.font {
    family = 'JetBrains Mono',
    weight = 'Medium',
}
config.font_size = 14
config.colors = require("cyberdream")

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
config.audible_bell = 'Disabled'

require("workspace_switcher").apply(config)

return config
