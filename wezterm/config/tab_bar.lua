local wezterm = require("wezterm")
local M = {}

-- 核心：只做一次配色解析（缓存），避免重复计算
local cached_scheme = nil
local function get_scheme(config)
    if cached_scheme then
        return cached_scheme
    end
    -- 只解析一次内置/自定义配色
    local scheme_name = config.color_scheme
    if not scheme_name then
        cached_scheme = {
            foreground = "#c0c0c0",
            background = "#1b1d2b",
            ansi = { nil, nil, nil, nil, nil, nil, nil, "#808080" }
        }
        return cached_scheme
    end
    -- 优先自定义配色，其次内置配色
    local scheme = config.color_schemes and config.color_schemes[scheme_name]
        or wezterm.get_builtin_color_schemes()[scheme_name]
    -- 兜底：确保关键颜色字段存在
    cached_scheme = {
        foreground = scheme.foreground or "#c0c0c0",
        background = scheme.background or "#1b1d2b",
        ansi = scheme.ansi or { nil, nil, nil, nil, nil, nil, nil, "#808080" },
        brights = scheme.brights or {}
    }
    return cached_scheme
end

function M.apply(config)
    -- 基础标签栏配置（仅保留必要项）
    config.enable_tab_bar = true
    config.hide_tab_bar_if_only_one_tab = false  -- 始终显示标签栏
    config.tab_max_width = 30 -- 限制标签宽度，避免重绘卡顿
    config.show_close_tab_button_in_tabs = true  -- 显示每个标签的关闭按钮（X）

    -- 核心：标签栏颜色和主题一致（只解析一次）
    local scheme = get_scheme(config)
    config.colors = config.colors or {}
    config.colors.tab_bar = {
        -- 标签栏整体背景 = 主题背景色
        background = scheme.background,
        -- 活跃标签 = 主题前景色（加粗）+ 主题背景色
        active_tab = {
            bg_color = scheme.background,
            fg_color = scheme.foreground,
            intensity = "Bold"
        },
        -- 非活跃标签 = 主题灰色（ANSI第8色）+ 主题背景色
        inactive_tab = {
            bg_color = scheme.background,
            fg_color = scheme.ansi[8] or "#808080"
        },
        -- 非活跃标签悬浮 = 轻微高亮 + 主题前景色
        inactive_tab_hover = {
            bg_color = scheme.background,
            fg_color = scheme.foreground,
            intensity = "Bold"
        },
        -- 新建标签按钮 = 主题颜色一致
        new_tab = {
            bg_color = scheme.background,
            fg_color = scheme.ansi[8] or "#808080"
        },
        new_tab_hover = {
            bg_color = scheme.background,
            fg_color = scheme.foreground
        }
    }

    -- 极简标签标题格式化（只显示索引+标题，无冗余计算）
    wezterm.on("format-tab-title", function(tab)
        return wezterm.format({
            { Text = string.format(" %d: %s ", tab.tab_index + 1, tab.active_pane.title) }
        })
    end)
end

return M