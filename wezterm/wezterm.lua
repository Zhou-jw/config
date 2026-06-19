-- ~/.wezterm.lua
local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

local modules = {
    "config.appearance",
    "config.launch_menu",
    "config.mouse",
    "config.tab_bar",
    "config.keybindings",
}

for _, name in ipairs(modules) do
    local module = require(name)
    if module and module.apply then
        module.apply(config)
    end
end

return config
