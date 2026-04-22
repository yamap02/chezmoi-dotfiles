local wezterm = require("wezterm")
local act = wezterm.action -- A helper function for my fallback fonts
local utils = require("utils")
local options = require("options")
local keybinds = require("keybinds")
require("on")

-- function font_with_fallback(name, params)
--     local names = { name, 'Noto Color Emoji', 'JetBrains Mono' }
--     return wezterm.font_with_fallback(names, params)
-- end

-- Show which key table is active in the status area
wezterm.on("update-right-status", function(window, pane)
    local name = window:active_key_table()
    if name then
        name = "TABLE: " .. name
    end
    window:set_right_status(name or "")
end)

-- wezterm.on('gui-startup', function(cmd)
--   local tab, pane, window = mux.spawn_window(cmd or {width=100, height=36})
--   window:gui_window():set_position(0,0)
--   window:set_inner_size(800, 1020)
-- end)

-- /etc/ssh/sshd_config
-- AcceptEnv TERM_PROGRAM_VERSION COLORTERM TERM TERM_PROGRAM WEZTERM_REMOTE_PANE
-- sudo systemctl reload sshd

---------------------------------------------------------------
--- functions
---------------------------------------------------------------
-- local function enable_wayland()
-- 	local wayland = os.getenv("XDG_SESSION_TYPE")
-- 	if wayland == "wayland" then
-- 		return true
-- 	end
-- 	return false
-- end

-- Use config_builder if available
local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- Apply general options from modular file
options.apply_to_config(config)

-- Apply keybinds from modular file
config.keys = keybinds.default_keybinds
config.key_tables = keybinds.key_tables

-- Original local config logic
--- load local_config
-- Write settings you don't want to make public, such as ssh_domains
package.path = os.getenv("HOME") .. "/.local/share/wezterm/?.lua;" .. package.path
-- local function load_local_config(module) ... -- Moved logic to inline check
local ok, local_config = pcall(require, "local")
if ok and type(local_config) == "table" then
    config = utils.merge_tables(config, local_config)
end

-- Add SSH domains (Original function logic moved to utils)
config = utils.insert_ssh_domain_from_ssh_config(config)

return config
