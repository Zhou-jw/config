local wezterm = require("wezterm")
local M = {}

wezterm.on("format-tab-title", function(tab, tabs, panes, cfg, hover, max_width)
    local bg, fg
    if tab.is_active then
        bg = "#323844"
        fg = "#e6e9ef"
    elseif hover then
        bg = "#2a2e38"
        fg = "#c0c5d1"
    else
        bg = "#1e2129"
        fg = "#8a8f9a"
    end

    local title = tab.active_pane.title

    return {
        { Background = { Color = bg } },
        { Foreground = { Color = fg } },
        { Text = " " .. title .. " " },
    }
end)

function M.apply(config)
    config.color_scheme = "Catppuccin Mocha"

    config.colors = config.colors or {}
    config.colors.tab_bar = {
        background = "#0b0022",

        active_tab = {
            bg_color = "#323844",
            fg_color = "#e6e9ef",
        },

        inactive_tab = {
            bg_color = "#1e2129",
            fg_color = "#8a8f9a",
        },

        inactive_tab_hover = {
            bg_color = "#2a2e38",
            fg_color = "#c0c5d1",
        },

        new_tab = {
            bg_color = "#1e2129",
            fg_color = "#8a8f9a",
        },

        new_tab_hover = {
            bg_color = "#2a2e38",
            fg_color = "#c0c5d1",
        },
    }

    config.enable_tab_bar = true
    config.hide_tab_bar_if_only_one_tab = false
    config.use_fancy_tab_bar = false

    config.max_fps = 120
    config.front_end = "WebGpu"
    config.webgpu_power_preference = "HighPerformance"

    config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
    config.integrated_title_button_style = "Gnome"
end

return M