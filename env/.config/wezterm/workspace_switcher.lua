local wezterm = require("wezterm")
local workspace_switcher = wezterm.plugin.require("https://github.com/Nikosar/smart_workspace_switcher.wezterm")
local is_windows = wezterm.target_triple:find("windows")

-- replace zoxide search with personal projects find
function workspace_switcher.choices.get_zoxide_elements(choice_table, opts)
	if opts == nil then
		opts = { extra_args = "", workspace_ids = {} }
	end

    local cmd = nil
    if is_windows then
        cmd = 'Get-ChildItem -Path ~/personal -Directory'
    else
        cmd = 'find ~/personal -maxdepth 1 -mindepth 1 -type d'
    end

    local success, stdout, stderr = wezterm.run_child_process({ 'zsh', '-c', cmd })
    if not success then
        wezterm.log_error(stderr)
        return {}
    end

	for _, path in ipairs(wezterm.split_by_newlines(stdout)) do
		local updated_path = string.gsub(path, wezterm.home_dir, "~")
		if not opts.workspace_ids[updated_path] then
			table.insert(choice_table, {
				id = path,
				label = updated_path,
			})
		end
	end
	return choice_table
end


return {
    apply = function(config)
        table.insert(config.keys, {
            key = "f",
            mods = "LEADER",
            action = workspace_switcher.switch_workspace(),
        })
    end
}
