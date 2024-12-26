local wezterm = require('wezterm')
local act = wezterm.action
local config = wezterm.config_builder()

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

-- Configuring key bindings
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
    { key = 'h', mods = "LEADER", action = act.ActivatePaneDirection 'Left' },
    { key = 'l', mods = "LEADER", action = act.ActivatePaneDirection 'Right' },
    { key = 'k', mods = "LEADER", action = act.ActivatePaneDirection 'Up' },
    { key = 'j', mods = "LEADER", action = act.ActivatePaneDirection 'Down' },

    { key = 'v', mods = "LEADER", action = act.ActivateCopyMode },
    { key = 'c', mods = "LEADER", action = act.SpawnTab 'CurrentPaneDomain' },
}

for i = 1, 8 do
  -- LEADER + number to activate that tab
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'LEADER',
    action = act.ActivateTab(i - 1),
  })

  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CTRL|ALT',
    action = act.ActivateTab(i - 1),
  })
end

local copy_mode = nil
if wezterm.gui then
    copy_mode = wezterm.gui.default_key_tables().copy_mode
    table.insert(
        copy_mode,
        { key = 'y', mods = "LEADER", action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection' }
    )
end

return config
