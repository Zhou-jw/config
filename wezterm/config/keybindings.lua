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
        { key = "p",     mods = "LEADER", action = act.ShowLauncherArgs({
            title = "🔗 SSH 连接",
            flags = "FUZZY|LAUNCH_MENU_ITEMS",
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