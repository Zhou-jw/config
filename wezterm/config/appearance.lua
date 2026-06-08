-- -- local constants = require("config.constants")

-- local M = {}
-- local wezterm = require("wezterm")

-- function M.apply(config)
--     -- 配色方案（默认）
--     config.color_scheme = 'Catppuccin Mocha'

--     -- tab bar
--     config.enable_tab_bar = true
--     config.hide_tab_bar_if_only_one_tab = false
--     config.use_fancy_tab_bar = false
--     config.tab_max_width = 25
--     config.show_tab_index_in_tab_bar = false
--     config.switch_to_last_active_tab_when_closing_tab = true
--     config.tab_bar_style = {
--       active_tab_left = wezterm.format {
--         { Background = { Color = '#0b0022' } },
--         { Foreground = { Color = '#2b2042' } },
--         -- { Text = SOLID_LEFT_ARROW },
--       },
--       active_tab_right = wezterm.format {
--         { Background = { Color = '#0b0022' } },
--         { Foreground = { Color = '#2b2042' } },
--         -- { Text = SOLID_RIGHT_ARROW },
--       },
--       inactive_tab_left = wezterm.format {
--         { Background = { Color = '#0b0022' } },
--         { Foreground = { Color = '#1b1032' } },
--         -- { Text = SOLID_LEFT_ARROW },
--       },
--       inactive_tab_right = wezterm.format {
--         { Background = { Color = '#0b0022' } },
--         { Foreground = { Color = '#1b1032' } },
--         -- { Text = SOLID_RIGHT_ARROW },
--       },
--     }

--     -- 渲染设置
--     config.max_fps = 120
--     config.front_end = "WebGpu"
--     config.webgpu_power_preference = "HighPerformance"

--     -- 窗口透明度
--     config.window_background_opacity = 1
--     config.font = wezterm.font('Hack Nerd Font Mono')

--     -- 背景图片（如需启用请取消注释）
--     -- config.window_background_image = constants.CONFIG_DIR .. "/images/4.jpg"

--     -- 窗口边距
--     -- config.window_padding = {
--     --     left = 0,
--     --     right = 0,
--     --     top = 0,
--     --     bottom = 0,
--     -- }

--     -- 滚动条颜色
--     config.enable_scroll_bar = true
--     config.colors = config.colors or {}
--     -- config.colors.scrollbar_thumb = "#242936"

--     -- 命令面板样式（磨砂深色）
--     config.command_palette_bg_color = "rgba(12, 14, 20, 0.92)"
--     config.command_palette_fg_color = "#e6e9ef"
-- end

-- return M

-- local constants = require("config.constants")

local M = {}
local wezterm = require("wezterm")

-- 类似 Ghostty 的极简 tab 格式化
wezterm.on("format-tab-title", function(tab, tabs, panes, cfg, hover, max_width)
    local is_active = tab.is_active
    local is_hover = hover
    local bg_color, fg_color
    
    if is_active then
        -- 激活标签 - 较亮的背景
        bg_color = "#323844"  -- 深灰蓝
        fg_color = "#e6e9ef"  -- 亮灰
    elseif is_hover then
        -- 悬停标签 - 稍微亮一点
        bg_color = "#2a2e38"  -- 中灰蓝
        fg_color = "#c0c5d1"  -- 中灰
    else
        -- 非激活标签 - 较暗
        bg_color = "#1e2129"  -- 深灰
        fg_color = "#8a8f9a"  -- 暗灰
    end
    
    -- 简单截断标题
    local title = wezterm.truncate_right(tab.active_pane.title, max_width - 4)
    
    -- 返回格式化数组
    return {
        { Background = { Color = bg_color } },
        { Foreground = { Color = fg_color } },
        { Text = " " .. title .. " " },
    }
end)

function M.apply(config)
    -- 配色方案（Catppuccin Mocha）
    config.color_scheme = 'Catppuccin Mocha'
    
    -- 自定义 colors 确保与 Ghostty 风格一致
    config.colors = config.colors or {}
    
    -- Tab bar 颜色 - 极简风格
    config.colors.tab_bar = {
        -- Tab bar 背景（与窗口背景一致）
        background = "#0b0022",  -- 可以改为 Catppuccin 的基础色 "#11111b"
        
        -- 活动标签
        active_tab = {
            bg_color = "#323844",  -- 标签背景
            fg_color = "#e6e9ef",  -- 标签文字
        },
        
        -- 非活动标签
        inactive_tab = {
            bg_color = "#1e2129",  -- 更暗的背景
            fg_color = "#8a8f9a",   -- 更暗的文字
        },
        
        -- 悬停标签
        inactive_tab_hover = {
            bg_color = "#2a2e38",  -- 稍微亮一点
            fg_color = "#c0c5d1",  -- 稍微亮一点
        },
        
        -- 新标签按钮
        new_tab = {
            bg_color = "#1e2129",
            fg_color = "#8a8f9a",
        },
        
        new_tab_hover = {
            bg_color = "#2a2e38",
            fg_color = "#c0c5d1",
        },
    }
    
    -- Tab bar 设置
    config.enable_tab_bar = true
    config.hide_tab_bar_if_only_one_tab = false
    config.use_fancy_tab_bar = false
    config.tab_max_width = 25
    config.show_tab_index_in_tab_bar = false
    config.switch_to_last_active_tab_when_closing_tab = true
    
    -- 标签分隔符（简单分隔线，无箭头）
    config.tab_bar_at_bottom = false
    config.show_new_tab_button_in_tab_bar = true
    
    -- 渲染设置
    config.max_fps = 120
    config.front_end = "WebGpu"
    config.webgpu_power_preference = "HighPerformance"
    
    -- 窗口设置
    config.window_background_opacity = 1.0
    config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

    config.window_padding = {
        left = 4,
        right = 4,
        top = 4,
        bottom = 4,
    }
    
    -- 字体设置
    config.font = wezterm.font_with_fallback({
        'Hack Nerd Font Mono',
        'JetBrains Mono',
        'Cascadia Code',
    })
    config.font_size = 12.0
    config.line_height = 1.1
    
    -- 光标样式
    config.default_cursor_style = "BlinkingBlock"
    config.cursor_blink_rate = 500
    config.cursor_blink_ease_in = "Constant"
    config.cursor_blink_ease_out = "Constant"
    
    -- 滚动条设置
    config.enable_scroll_bar = true
    config.colors.scrollbar_thumb = "#4a4f5c"
    
    -- 命令面板样式
    config.command_palette_bg_color = "rgba(12, 14, 20, 0.95)"
    config.command_palette_fg_color = "#e6e9ef"
    config.command_palette_font_size = 13.0
    
    -- 窗口帧样式
    config.window_frame = {
        active_titlebar_bg = "#0b0022",  -- 窗口顶部背景
        inactive_titlebar_bg = "#0b0022",
        font = wezterm.font('Hack Nerd Font Mono', { weight = 'Bold' }),
        font_size = 12.0,
    }
    
    -- 其他设置
    config.warn_about_missing_glyphs = false
    config.check_for_updates = false
    config.scrollback_lines = 10000
    config.default_workspace = "main"
    
    -- 关闭标签页确认
    config.window_close_confirmation = "NeverPrompt"
    
    -- 背景图片（如需启用请取消注释）
    -- config.window_background_image = constants.CONFIG_DIR .. "/images/4.jpg"
    -- config.window_background_image_hsb = {
    --     brightness = 0.05,
    --     hue = 1.0,
    --     saturation = 1.0,
    -- }
    -- config.window_background_opacity = 0.92
end

return M