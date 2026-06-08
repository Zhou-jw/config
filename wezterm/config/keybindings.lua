-- local wezterm = require("wezterm")

-- local M = {}

-- function M.apply(config)
--     local act = wezterm.action

--     -- 禁用默认快捷键
--     -- config.disable_default_key_bindings = false

--     -- Leader 键
--     config.leader = {
--         key = "a",
--         mods = "CTRL",
--         timeout_milliseconds = 1000,
--     }

--     -- 构建配色方案选择器的选项
--     config.keys = {
--         -- ========== 窗口管理 ==========
--         { key = "F11",        mods = "NONE",       action = act.ToggleFullScreen },
--         { key = "m",          mods = "LEADER",     action = act.Hide },

--         -- ========== 标签页管理 ==========
--         { key = "n",          mods = "LEADER",     action = act.SpawnTab("CurrentPaneDomain") },
--         { key = "w",          mods = "LEADER",     action = act.CloseCurrentTab({ confirm = false }) },
--         { key = "Tab",        mods = "LEADER",     action = act.ActivateTabRelative(1) },
--         { key = "t",          mods = "LEADER",     action = act.EmitEvent("toggle-tab-bar") },

--         -- ========== 窗格分割 ==========
--         { key = "\\",         mods = "LEADER",     action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
--         { key = "-",          mods = "LEADER",     action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

--         -- ========== 窗格导航 (Leader + 方向键) ==========
--         { key = "LeftArrow",  mods = "LEADER",     action = act.ActivatePaneDirection("Left") },
--         { key = "DownArrow",  mods = "LEADER",     action = act.ActivatePaneDirection("Down") },
--         { key = "UpArrow",    mods = "LEADER",     action = act.ActivatePaneDirection("Up") },
--         { key = "RightArrow", mods = "LEADER",     action = act.ActivatePaneDirection("Right") },

--         -- ========== 窗格大小调整 (Ctrl+Shift + 方向键) ==========
--         { key = "LeftArrow",  mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
--         { key = "DownArrow",  mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
--         { key = "UpArrow",    mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
--         { key = "RightArrow", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },

--         -- ========== 窗格关闭 ==========
--         { key = "w",          mods = "CTRL|SHIFT", action = act.CloseCurrentPane({ confirm = true }) },

--         -- 复制：Ctrl+C（有选中内容时复制，无选中时正常发送中断信号）
--         -- { key = "c",          mods = "CTRL",       action = act.CopyTo("ClipboardAndPrimarySelection") },
--         -- { key = "c", mods = "CTRL", action = act.CopyOrSendInterrupt({ select_all = false }) },
--         -- 粘贴：Ctrl+V
--         -- { key = "v",          mods = "CTRL",       action = act.PasteFrom("Clipboard") },

--         -- ========== 搜索与命令 ==========
--         { key = "f",          mods = "CTRL",       action = act.Search("CurrentSelectionOrEmptyString") },
--         {
--             key = "p",
--             mods = "LEADER",
--             action = act.ShowLauncherArgs({
--                 title = "🚀 启动菜单",
--                 flags = "FUZZY|LAUNCH_MENU_ITEMS",
--             }),
--         },
--         { key = "k",    mods = "LEADER", action = act.ClearScrollback("ScrollbackAndViewport") },
--         {
--             key = "Space",
--             mods = "LEADER",
--             action = act.ShowLauncherArgs({
--                 flags = "FUZZY|LAUNCH_MENU_ITEMS|DOMAINS|KEY_ASSIGNMENTS",
--             }),
--         },

--         -- ========== 滚动 ==========
--         { key = "Home", mods = "LEADER", action = act.ScrollToTop },
--         { key = "End",  mods = "LEADER", action = act.ScrollToBottom },

--         -- ========== 复制模式（类似 Vim 的键盘选择模式）==========
--         { key = "c",    mods = "LEADER", action = act.ActivateCopyMode },

--         -- ========== 配色方案切换 (Leader+s) ==========
--         -- {
--         --     key = "s",
--         --     mods = "LEADER",
--         --     action = act.InputSelector({
--         --         title = "🎨 选择配色方案",
--         --         choices = color_scheme_choices,
--         --         action = wezterm.action_callback(function(window, _pane, _id, label)
--         --             if label then
--         --                 window:set_config_overrides({ color_scheme = label })
--         --                 wezterm.log_info("配色方案已切换为: " .. label)
--         --             end
--         --         end),
--         --     }),
--         -- },

--         -- ========== SSH 域连接 (Leader+o) ==========
--         {
--             key = "o",
--             mods = "LEADER",
--             action = act.ShowLauncherArgs({
--                 title = "🔗 SSH 连接",
--                 flags = "FUZZY|DOMAINS",
--             }),
--         },

--         -- ========== 远程粘贴（发送剪贴板内容到远程 Vim/Helix）==========
--         -- Leader+v: 使用 Bracketed Paste 模式粘贴（适用于支持该模式的编辑器）
--         {
--             key = "v",
--             mods = "LEADER",
--             action = act.PasteFrom("Clipboard"),
--         },
--         -- Ctrl+Shift+V: 直接发送剪贴板文本（SendString 模式，适用于所有终端程序）
--         {
--             key = "V",
--             mods = "CTRL|SHIFT",
--             action = wezterm.action_callback(function(window, pane)
--                 -- 获取剪贴板内容并直接发送到终端
--                 local clipboard = window:copy_clipboard("Clipboard")
--                 if clipboard then
--                     pane:send_text(clipboard)
--                 end
--             end),
--         },
--     }
-- end

-- return M

local wezterm = require("wezterm")

local M = {}

function M.apply(config)
    local act = wezterm.action

    -- Leader 键（保留，但可以改为 Ghostty 风格）
    config.leader = {
        key = "Space",  -- Ghostty 使用空格作为 Leader
        mods = "CTRL",
        timeout_milliseconds = 1000,
    }

    -- 禁用默认快捷键（只保留基本复制粘贴）
    config.disable_default_key_bindings = false  -- 保留默认的 Ctrl+C/Ctrl+V

    -- 构建键位映射
    config.keys = {
        -- ========== 基础键位 (Alt 对应 macOS 的 Cmd) ==========
        { key = "c",          mods = "ALT",       action = act.CopyTo("ClipboardAndPrimarySelection") },
        { key = "v",          mods = "ALT",       action = act.PasteFrom("Clipboard") },
        -- { key = "a",          mods = "ALT",       action = act.SelectAll() },
        { key = "t",          mods = "ALT",       action = act.SpawnTab("CurrentPaneDomain") },
        -- { key = "w",          mods = "ALT",       action = act.CloseCurrentTab({ confirm = false }) },
        { key = "w",          mods = "ALT",       action = act.CloseCurrentPane({ confirm = true }) },
        { key = "n",          mods = "ALT",       action = act.SpawnWindow },
        { key = "f",          mods = "ALT",       action = act.ToggleFullScreen },
        { key = "k",          mods = "ALT",       action = act.ClearScrollback("ScrollbackAndViewport") },
        { key = "r",          mods = "ALT",       action = act.ReloadConfiguration },
        
        -- ========== 标签页管理 (类似 macOS Safari/Chrome) ==========
        { key = "Tab",        mods = "CTRL",      action = act.ActivateTabRelative(1) },
        { key = "Tab",        mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
        { key = "[",          mods = "ALT",       action = act.ActivateTabRelative(-1) },
        { key = "]",          mods = "ALT",       action = act.ActivateTabRelative(1) },
        { key = "1",          mods = "ALT",       action = act.ActivateTab(0) },
        { key = "2",          mods = "ALT",       action = act.ActivateTab(1) },
        { key = "3",          mods = "ALT",       action = act.ActivateTab(2) },
        { key = "4",          mods = "ALT",       action = act.ActivateTab(3) },
        { key = "5",          mods = "ALT",       action = act.ActivateTab(4) },
        { key = "6",          mods = "ALT",       action = act.ActivateTab(5) },
        { key = "7",          mods = "ALT",       action = act.ActivateTab(6) },
        { key = "8",          mods = "ALT",       action = act.ActivateTab(7) },
        { key = "9",          mods = "ALT",       action = act.ActivateTab(8) },
        { key = "0",          mods = "ALT",       action = act.ActivateTab(-1) },  -- 最后一个标签页
        
        -- ========== 窗格管理 (Ghostty/现代终端风格) ==========
        { key = "d",          mods = "ALT",       action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },  -- Alt+D 垂直分屏
        { key = "d",          mods = "ALT|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) }, -- Alt+Shift+D 水平分屏
        { key = "w",          mods = "ALT|SHIFT", action = act.CloseCurrentPane({ confirm = false }) },  -- Alt+Shift+W 关闭窗格
        { key = "x",          mods = "ALT",       action = act.CloseCurrentPane({ confirm = true }) },  -- Alt+X 关闭窗格（确认）
        
        -- ========== 窗格导航 (Alt + 方向键) ==========
        { key = "LeftArrow",  mods = "ALT",       action = act.ActivatePaneDirection("Left") },
        { key = "RightArrow", mods = "ALT",       action = act.ActivatePaneDirection("Right") },
        { key = "UpArrow",    mods = "ALT",       action = act.ActivatePaneDirection("Up") },
        { key = "DownArrow",  mods = "ALT",       action = act.ActivatePaneDirection("Down") },
        
        -- 快速跳转到特定方向的窗格
        { key = "h",          mods = "ALT",       action = act.ActivatePaneDirection("Left") },
        { key = "l",          mods = "ALT",       action = act.ActivatePaneDirection("Right") },
        { key = "k",          mods = "ALT",       action = act.ActivatePaneDirection("Up") },
        { key = "j",          mods = "ALT",       action = act.ActivatePaneDirection("Down") },
        
        -- ========== 窗格大小调整 (Alt+Shift + 方向键) ==========
        { key = "LeftArrow",  mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
        { key = "RightArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },
        { key = "UpArrow",    mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
        { key = "DownArrow",  mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
        
        -- ========== 搜索与命令 (类似 Ghostty) ==========
        { key = "f",          mods = "CTRL",      action = act.Search({ CaseSensitiveString = "" }) },  -- Ctrl+F 搜索
        { key = "f",          mods = "CTRL|SHIFT", action = act.Search({ Regex = "" }) },  -- Ctrl+Shift+F 正则搜索
        { key = "p",          mods = "CTRL|SHIFT", action = act.ActivateCommandPalette },  -- Ctrl+Shift+P 命令面板
        
        -- ========== 滚动 (类似 macOS/iTerm2) ==========
        { key = "PageUp",     mods = "ALT",       action = act.ScrollByPage(-1) },
        { key = "PageDown",   mods = "ALT",       action = act.ScrollByPage(1) },
        { key = "Home",       mods = "ALT",       action = act.ScrollToTop },
        { key = "End",        mods = "ALT",       action = act.ScrollToBottom },
        
        -- ========== 鼠标选择模式 (类似 Ghostty 的块选择) ==========
        { key = "v",          mods = "CTRL|SHIFT", action = act.ActivateCopyMode },  -- Ctrl+Shift+V 进入块选择模式
        
        -- ========== 高级功能 (Leader 键触发) ==========
        { key = "Enter",      mods = "LEADER",     action = act.QuickSelect },  -- Leader+Enter 快速选择
        { key = "s",          mods = "LEADER",     action = act.EmitEvent("toggle-tab-bar") },  -- Leader+S 切换标签栏显示
        -- { key = "c",          mods = "LEADER",     action = act.ShowLauncherArgs({  -- Leader+C 颜色方案切换
        --     title = "🎨 选择配色方案",
        --     flags = "FUZZY|COLOR_SCHEMES",
        -- }) },
        { key = "o",          mods = "LEADER",     action = act.ShowLauncherArgs({  -- Leader+O 连接 SSH
            title = "🔗 SSH 连接",
            flags = "FUZZY|DOMAINS",
        }) },
        
        -- ========== 字体大小调整 (类似浏览器) ==========
        { key = "=",          mods = "CTRL",      action = act.IncreaseFontSize },  -- Ctrl+= 放大字体
        { key = "-",          mods = "CTRL",      action = act.DecreaseFontSize },  -- Ctrl+- 缩小字体
        { key = "0",          mods = "CTRL",      action = act.ResetFontSize },     -- Ctrl+0 重置字体大小
        
        -- ========== 复制模式 (Vim 风格) ==========
        { key = "[",          mods = "CTRL|SHIFT", action = act.ActivateCopyMode },  -- Ctrl+Shift+[ 进入复制模式
    }
    
    -- 鼠标绑定
    config.mouse_bindings = {
        -- 中键粘贴
        {
            event = { Down = { streak = 1, button = "Middle" } },
            mods = "NONE",
            action = act.PasteFrom("PrimarySelection"),
        },
        -- 右键上下文菜单
        {
            event = { Down = { streak = 1, button = "Right" } },
            mods = "NONE",
            action = act.ShowLauncherArgs({
                flags = "FUZZY|LAUNCH_MENU_ITEMS",
            }),
        },
        -- 滚轮调整字体大小
        {
            event = { Down = { streak = 1, button = { WheelUp = 1 } } },
            mods = "CTRL",
            action = act.IncreaseFontSize,
        },
        {
            event = { Down = { streak = 1, button = { WheelDown = 1 } } },
            mods = "CTRL",
            action = act.DecreaseFontSize,
        },
    }
end

return M