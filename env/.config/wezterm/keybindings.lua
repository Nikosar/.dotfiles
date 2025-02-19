local wezterm = require("wezterm")
local act = wezterm.action

return {
    apply = function(config)
        config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
        config.keys = {
            { key = 'h', mods = "LEADER", action = act.ActivatePaneDirection 'Left' },
            { key = 'l', mods = "LEADER", action = act.ActivatePaneDirection 'Right' },
            { key = 'k', mods = "LEADER", action = act.ActivatePaneDirection 'Up' },
            { key = 'j', mods = "LEADER", action = act.ActivatePaneDirection 'Down' },

            { key = 'v', mods = "LEADER", action = act.ActivateCopyMode },
            { key = 'c', mods = "LEADER", action = act.SpawnTab 'CurrentPaneDomain' },

            { key = 'a', mods = "LEADER", action = wezterm.action.SendString "\x01" },

            { key = 'v', mods = "CTRL", action = wezterm.action.PasteFrom "Clipboard" },
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
    end
}
