local wezterm = require("wezterm")
local M = {}



function M.apply(config)
    config.color_scheme = "Catppuccin Mocha"

    config.max_fps = 120
    config.front_end = "WebGpu"
    config.webgpu_power_preference = "HighPerformance"

    config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
    config.integrated_title_button_style = "Gnome"

    config.font = wezterm.font_with_fallback({
        'Maple Mono Normal NL NF CN',
        'Hack Nerd Font Mono',
        -- 'JetBrains Mono',
        -- 'Cascadia Code',
    })
    config.font_size = 12.0
    -- config.line_height = 1.1

    -- tab bar
    config.enable_tab_bar = true
    config.hide_tab_bar_if_only_one_tab = false  -- 始终显示标签栏
    config.tab_max_width = 30 -- 限制标签宽度，避免重绘卡顿
    config.show_close_tab_button_in_tabs = true  -- 显示每个标签的关闭按钮（X）
    config.use_fancy_tab_bar = false
    wezterm.on("format-tab-title", function(tab, tabs, panes, cfg, hover, max_width)
        return {
            { Text = string.format(" %d: %s ", tab.tab_index + 1, tab.active_pane.title) },
        }
    end)

    -- 滚动条设置
    config.enable_scroll_bar = true
    -- config.colors.scrollbar_thumb = "#4a4f5c"
end

return M