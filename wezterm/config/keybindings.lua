-- local wezterm = require("wezterm")

-- local M = {}

-- function M.apply(config)
--     local act = wezterm.action

--     -- Leader 键（保留，但可以改为 Ghostty 风格）
--     config.leader = {
--         key = "Space",  -- Ghostty 使用空格作为 Leader
--         mods = "CTRL",
--         timeout_milliseconds = 1000,
--     }

--     -- 禁用默认快捷键（只保留基本复制粘贴）
--     config.disable_default_key_bindings = false  -- 保留默认的 Ctrl+C/Ctrl+V

--     -- 构建键位映射
--     config.keys = {
--         -- ========== 基础键位 (Alt 对应 macOS 的 Cmd) ==========
--         { key = "c",          mods = "ALT",       action = act.CopyTo("ClipboardAndPrimarySelection") },
--         { key = "v",          mods = "ALT",       action = act.PasteFrom("Clipboard") },
--         -- { key = "a",          mods = "ALT",       action = act.SelectAll() },
--         { key = "t",          mods = "ALT",       action = act.SpawnTab("CurrentPaneDomain") },
--         -- { key = "w",          mods = "ALT",       action = act.CloseCurrentTab({ confirm = false }) },
--         { key = "w",          mods = "ALT",       action = act.CloseCurrentPane({ confirm = true }) },
--         { key = "n",          mods = "ALT",       action = act.SpawnWindow },
--         { key = "f",          mods = "ALT",       action = act.ToggleFullScreen },
--         { key = "k",          mods = "ALT",       action = act.ClearScrollback("ScrollbackAndViewport") },
--         { key = "r",          mods = "ALT",       action = act.ReloadConfiguration },
        
--         -- ========== 标签页管理 (类似 macOS Safari/Chrome) ==========
--         { key = "Tab",        mods = "CTRL",      action = act.ActivateTabRelative(1) },
--         { key = "Tab",        mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
--         { key = "[",          mods = "ALT",       action = act.ActivateTabRelative(-1) },
--         { key = "]",          mods = "ALT",       action = act.ActivateTabRelative(1) },
--         { key = "1",          mods = "ALT",       action = act.ActivateTab(0) },
--         { key = "2",          mods = "ALT",       action = act.ActivateTab(1) },
--         { key = "3",          mods = "ALT",       action = act.ActivateTab(2) },
--         { key = "4",          mods = "ALT",       action = act.ActivateTab(3) },
--         { key = "5",          mods = "ALT",       action = act.ActivateTab(4) },
--         { key = "6",          mods = "ALT",       action = act.ActivateTab(5) },
--         { key = "7",          mods = "ALT",       action = act.ActivateTab(6) },
--         { key = "8",          mods = "ALT",       action = act.ActivateTab(7) },
--         { key = "9",          mods = "ALT",       action = act.ActivateTab(8) },
--         { key = "0",          mods = "ALT",       action = act.ActivateTab(-1) },  -- 最后一个标签页
        
--         -- ========== 窗格管理 (Ghostty/现代终端风格) ==========
--         { key = "d",          mods = "ALT",       action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },  -- Alt+D 垂直分屏
--         { key = "d",          mods = "ALT|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) }, -- Alt+Shift+D 水平分屏
--         { key = "w",          mods = "ALT|SHIFT", action = act.CloseCurrentPane({ confirm = false }) },  -- Alt+Shift+W 关闭窗格
--         { key = "x",          mods = "ALT",       action = act.CloseCurrentPane({ confirm = true }) },  -- Alt+X 关闭窗格（确认）
        
--         -- ========== 窗格导航 (Alt + 方向键) ==========
--         { key = "LeftArrow",  mods = "ALT",       action = act.ActivatePaneDirection("Left") },
--         { key = "RightArrow", mods = "ALT",       action = act.ActivatePaneDirection("Right") },
--         { key = "UpArrow",    mods = "ALT",       action = act.ActivatePaneDirection("Up") },
--         { key = "DownArrow",  mods = "ALT",       action = act.ActivatePaneDirection("Down") },
        
--         -- 快速跳转到特定方向的窗格
--         { key = "h",          mods = "ALT",       action = act.ActivatePaneDirection("Left") },
--         { key = "l",          mods = "ALT",       action = act.ActivatePaneDirection("Right") },
--         { key = "k",          mods = "ALT",       action = act.ActivatePaneDirection("Up") },
--         { key = "j",          mods = "ALT",       action = act.ActivatePaneDirection("Down") },
        
--         -- ========== 窗格大小调整 (Alt+Shift + 方向键) ==========
--         { key = "LeftArrow",  mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
--         { key = "RightArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },
--         { key = "UpArrow",    mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
--         { key = "DownArrow",  mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
        
--         -- ========== 搜索与命令 (类似 Ghostty) ==========
--         { key = "f",          mods = "CTRL",      action = act.Search({ CaseSensitiveString = "" }) },  -- Ctrl+F 搜索
--         { key = "f",          mods = "CTRL|SHIFT", action = act.Search({ Regex = "" }) },  -- Ctrl+Shift+F 正则搜索
--         { key = "p",          mods = "CTRL|SHIFT", action = act.ActivateCommandPalette },  -- Ctrl+Shift+P 命令面板
        
--         -- ========== 滚动 (类似 macOS/iTerm2) ==========
--         { key = "PageUp",     mods = "ALT",       action = act.ScrollByPage(-1) },
--         { key = "PageDown",   mods = "ALT",       action = act.ScrollByPage(1) },
--         { key = "Home",       mods = "ALT",       action = act.ScrollToTop },
--         { key = "End",        mods = "ALT",       action = act.ScrollToBottom },
        
--         -- ========== 鼠标选择模式 (类似 Ghostty 的块选择) ==========
--         { key = "v",          mods = "CTRL|SHIFT", action = act.ActivateCopyMode },  -- Ctrl+Shift+V 进入块选择模式
        
--         -- ========== 高级功能 (Leader 键触发) ==========
--         { key = "Enter",      mods = "LEADER",     action = act.QuickSelect },  -- Leader+Enter 快速选择
--         { key = "s",          mods = "LEADER",     action = act.EmitEvent("toggle-tab-bar") },  -- Leader+S 切换标签栏显示
--         -- { key = "c",          mods = "LEADER",     action = act.ShowLauncherArgs({  -- Leader+C 颜色方案切换
--         --     title = "🎨 选择配色方案",
--         --     flags = "FUZZY|COLOR_SCHEMES",
--         -- }) },
--         { key = "o",          mods = "LEADER",     action = act.ShowLauncherArgs({  -- Leader+O 连接 SSH
--             title = "🔗 SSH 连接",
--             flags = "FUZZY|DOMAINS",
--         }) },
        
--         -- ========== 字体大小调整 (类似浏览器) ==========
--         { key = "=",          mods = "CTRL",      action = act.IncreaseFontSize },  -- Ctrl+= 放大字体
--         { key = "-",          mods = "CTRL",      action = act.DecreaseFontSize },  -- Ctrl+- 缩小字体
--         { key = "0",          mods = "CTRL",      action = act.ResetFontSize },     -- Ctrl+0 重置字体大小
        
--         -- ========== 复制模式 (Vim 风格) ==========
--         { key = "[",          mods = "CTRL|SHIFT", action = act.ActivateCopyMode },  -- Ctrl+Shift+[ 进入复制模式
--     }
    
--     -- 鼠标绑定
--     config.mouse_bindings = {
--         -- 中键粘贴
--         {
--             event = { Down = { streak = 1, button = "Middle" } },
--             mods = "NONE",
--             action = act.PasteFrom("PrimarySelection"),
--         },
--         -- 右键上下文菜单
--         {
--             event = { Down = { streak = 1, button = "Right" } },
--             mods = "NONE",
--             action = act.ShowLauncherArgs({
--                 flags = "FUZZY|LAUNCH_MENU_ITEMS",
--             }),
--         },
--         -- 滚轮调整字体大小
--         {
--             event = { Down = { streak = 1, button = { WheelUp = 1 } } },
--             mods = "CTRL",
--             action = act.IncreaseFontSize,
--         },
--         {
--             event = { Down = { streak = 1, button = { WheelDown = 1 } } },
--             mods = "CTRL",
--             action = act.DecreaseFontSize,
--         },
--     }
-- end

-- return M
local wezterm = require("wezterm")

local M = {}

-- 根据平台自动决定修饰键
local function get_mods()
    -- 在 macOS 上，ALT 对应 Option 键
    -- 真正的 Cmd 键是 SUPER
    if wezterm.target_triple:find("darwin") then
        return {
            mod = "SUPER",      -- macOS 的 Cmd
            alt = "ALT",        -- macOS 的 Option
            shift = "SHIFT",
            ctrl = "CTRL"
        }
    else
        return {
            mod = "ALT",        -- Windows/Linux 的 Alt
            alt = "ALT",        -- Windows/Linux 的 Alt
            shift = "SHIFT",
            ctrl = "CTRL"
        }
    end
end

function M.apply(config)
    local act = wezterm.action
    local mods = get_mods()

    -- Leader 键（空格键，兼容多平台）
    config.leader = {
        key = "Space",
        mods = "CTRL",  -- 在 macOS 上这是 Ctrl+Space，不会和 Cmd+Space 冲突
        timeout_milliseconds = 1000,
    }

    -- 禁用默认快捷键
    config.disable_default_key_bindings = false

    -- 构建键位映射
    config.keys = {
        -- ========== 基础键位（多平台统一） ==========
        -- 复制：在 Windows/Linux 是 Alt+C，在 macOS 是 Cmd+C
        { key = "c", mods = mods.mod, action = act.CopyTo("ClipboardAndPrimarySelection") },
        -- 粘贴：在 Windows/Linux 是 Alt+V，在 macOS 是 Cmd+V
        { key = "v", mods = mods.mod, action = act.PasteFrom("Clipboard") },
        -- 新建标签页：在 Windows/Linux 是 Alt+T，在 macOS 是 Cmd+T
        { key = "t", mods = mods.mod, action = act.SpawnTab("CurrentPaneDomain") },
        -- 关闭标签页/窗格：在 Windows/Linux 是 Alt+W，在 macOS 是 Cmd+W
        { key = "w", mods = mods.mod, action = act.CloseCurrentPane({ confirm = true }) },
        -- 新建窗口：在 Windows/Linux 是 Alt+N，在 macOS 是 Cmd+N
        { key = "n", mods = mods.mod, action = act.SpawnWindow },
        -- 全屏：在 Windows/Linux 是 Alt+F，在 macOS 是 Cmd+F
        { key = "f", mods = mods.mod, action = act.ToggleFullScreen },
        -- 清除滚动缓冲：在 Windows/Linux 是 Alt+K，在 macOS 是 Cmd+K
        { key = "k", mods = mods.mod, action = act.ClearScrollback("ScrollbackAndViewport") },
        -- 重新加载配置：在 Windows/Linux 是 Alt+R，在 macOS 是 Cmd+R
        { key = "r", mods = mods.mod, action = act.ReloadConfiguration },
        
        -- ========== 标签页管理 ==========
        -- 下一个标签页：Ctrl+Tab
        { key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
        -- 上一个标签页：Ctrl+Shift+Tab
        { key = "Tab", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
        -- 上一个标签页：Mod+[
        { key = "[", mods = mods.mod, action = act.ActivateTabRelative(-1) },
        -- 下一个标签页：Mod+]
        { key = "]", mods = mods.mod, action = act.ActivateTabRelative(1) },
        
        -- 跳转到标签页 1-9
        { key = "1", mods = mods.mod, action = act.ActivateTab(0) },
        { key = "2", mods = mods.mod, action = act.ActivateTab(1) },
        { key = "3", mods = mods.mod, action = act.ActivateTab(2) },
        { key = "4", mods = mods.mod, action = act.ActivateTab(3) },
        { key = "5", mods = mods.mod, action = act.ActivateTab(4) },
        { key = "6", mods = mods.mod, action = act.ActivateTab(5) },
        { key = "7", mods = mods.mod, action = act.ActivateTab(6) },
        { key = "8", mods = mods.mod, action = act.ActivateTab(7) },
        { key = "9", mods = mods.mod, action = act.ActivateTab(8) },
        -- 最后一个标签页：Mod+0
        { key = "0", mods = mods.mod, action = act.ActivateTab(-1) },
        
        -- ========== 窗格管理 ==========
        -- 垂直分屏：Mod+D
        { key = "d", mods = mods.mod, action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
        -- 水平分屏：Mod+Shift+D
        { key = "d", mods = mods.mod .. "|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
        -- 关闭窗格：Mod+Shift+W
        { key = "w", mods = mods.mod .. "|SHIFT", action = act.CloseCurrentPane({ confirm = false }) },
        -- 关闭窗格（确认）：Mod+X
        { key = "x", mods = mods.mod, action = act.CloseCurrentPane({ confirm = true }) },
        
        -- ========== 窗格导航 ==========
        -- 方向键导航
        { key = "LeftArrow",  mods = mods.mod, action = act.ActivatePaneDirection("Left") },
        { key = "RightArrow", mods = mods.mod, action = act.ActivatePaneDirection("Right") },
        { key = "UpArrow",    mods = mods.mod, action = act.ActivatePaneDirection("Up") },
        { key = "DownArrow",  mods = mods.mod, action = act.ActivatePaneDirection("Down") },
        
        -- Vim 风格导航
        { key = "h", mods = mods.mod, action = act.ActivatePaneDirection("Left") },
        { key = "l", mods = mods.mod, action = act.ActivatePaneDirection("Right") },
        { key = "k", mods = mods.mod, action = act.ActivatePaneDirection("Up") },
        { key = "j", mods = mods.mod, action = act.ActivatePaneDirection("Down") },
        
        -- ========== 窗格大小调整 ==========
        { key = "LeftArrow",  mods = mods.mod .. "|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
        { key = "RightArrow", mods = mods.mod .. "|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },
        { key = "UpArrow",    mods = mods.mod .. "|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
        { key = "DownArrow",  mods = mods.mod .. "|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
        
        -- ========== 搜索与命令 ==========
        -- Ctrl+F 搜索
        { key = "f", mods = "CTRL", action = act.Search({ CaseSensitiveString = "" }) },
        -- Ctrl+Shift+F 正则搜索
        { key = "f", mods = "CTRL|SHIFT", action = act.Search({ Regex = "" }) },
        -- Ctrl+Shift+P 命令面板
        { key = "p", mods = "CTRL|SHIFT", action = act.ActivateCommandPalette },
        
        -- ========== 滚动 ==========
        { key = "PageUp",   mods = mods.mod, action = act.ScrollByPage(-1) },
        { key = "PageDown", mods = mods.mod, action = act.ScrollByPage(1) },
        { key = "Home",     mods = mods.mod, action = act.ScrollToTop },
        { key = "End",      mods = mods.mod, action = act.ScrollToBottom },
        
        -- ========== 复制模式 ==========
        { key = "v", mods = "CTRL|SHIFT", action = act.ActivateCopyMode },
        { key = "[", mods = "CTRL|SHIFT", action = act.ActivateCopyMode },
        
        -- ========== 高级功能（Leader 键） ==========
        { key = "Enter", mods = "LEADER", action = act.QuickSelect },
        { key = "s",     mods = "LEADER", action = act.EmitEvent("toggle-tab-bar") },
        { key = "o",     mods = "LEADER", action = act.ShowLauncherArgs({
            title = "🔗 SSH 连接",
            flags = "FUZZY|DOMAINS",
        }) },
        
        -- ========== 字体大小调整 ==========
        { key = "=", mods = "CTRL", action = act.IncreaseFontSize },
        { key = "-", mods = "CTRL", action = act.DecreaseFontSize },
        { key = "0", mods = "CTRL", action = act.ResetFontSize },
        
        -- ========== 特殊功能 ==========
        -- 快速选择：Ctrl+Shift+Enter
        { key = "Enter", mods = "CTRL|SHIFT", action = act.QuickSelect },
    }
    
    -- 在 Windows/Linux 上添加额外快捷键
    if not wezterm.target_triple:find("darwin") then
        -- 在 Windows/Linux 上，Alt+Space 通常用于系统菜单
        -- 我们改为 Ctrl+Alt+Space
        table.insert(config.keys, { key = "Space", mods = "CTRL|ALT", action = act.ShowTabNavigator })
    end
    
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
        -- Ctrl+滚轮调整字体大小
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
    
    -- 额外配置：为不同平台设置
    if wezterm.target_triple:find("darwin") then
        -- macOS 特有设置
        config.native_macos_fullscreen_mode = true
    end
end

return M