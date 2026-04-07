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

-- -- Helper: check if executable exists in Windows PATH
-- local function exe_exists(name)
--   local ok, _stdout, _stderr = wezterm.run_child_process { 'where', name }
--   return ok
-- end

-- local has_pwsh       = exe_exists('pwsh.exe')
-- local has_powershell = exe_exists('powershell.exe')
-- local has_cmd        = exe_exists('cmd.exe')

-- -- 1. 优先设置 pwsh 为默认 shell
-- if has_pwsh then
--   config.default_prog = { 'pwsh.exe', '-NoLogo' }
--   config.default_domain = 'local'
-- elseif has_powershell then
--   config.default_prog = { 'powershell.exe', '-NoLogo' }
--   config.default_domain = 'local'
-- else
--   local wsl_domains = wezterm.default_wsl_domains()
--   for _, dom in ipairs(wsl_domains) do
--     dom.default_cwd = "~"
--   end
--   if #wsl_domains > 0 then
--     config.default_domain = wsl_domains[1].name
--   end
-- end

-- -- 2. 保留WSL域配置
-- local wsl_domains = wezterm.default_wsl_domains()
-- local first_wsl_name = #wsl_domains > 0 and wsl_domains[1].name or nil
-- for _, dom in ipairs(wsl_domains) do
--   dom.default_cwd = "~"
-- end

-- -- 3. 启动菜单配置
-- local launch_menu = {}
-- if has_pwsh then
--   table.insert(launch_menu, {
--     label = 'PowerShell 7+ (pwsh)',
--     domain = { DomainName = "local" },
--     args  = { 'pwsh.exe', '-NoLogo' },
--   })
-- end
-- if has_powershell then
--   table.insert(launch_menu, {
--     label = 'PowerShell 5 (Windows)',
--     domain = { DomainName = "local" },
--     args  = { 'powershell.exe', '-NoLogo' },
--   })
-- end
-- if has_cmd then
--   table.insert(launch_menu, {
--     label = 'Command Prompt (cmd)',
--     domain = { DomainName = "local" },
--     args  = { 'cmd.exe' },
--   })
-- end
-- for _, dom in ipairs(wsl_domains) do
--   table.insert(launch_menu, {
--     label  = 'WSL: ' .. dom.distribution,
--     domain = { DomainName = dom.name },
--   })
-- end
-- config.launch_menu = launch_menu

-- -- 4. 快捷键配置（无PowerToys冲突，兼容所有WezTerm版本）
-- local keys = {}

-- -- 主快捷键：Ctrl+Shift+Space（唤起启动菜单，无冲突）
-- table.insert(keys, {
--   key = 'Space',
--   mods = 'CTRL|SHIFT',
--   action = act.ShowLauncherArgs {
--     flags = 'FUZZY|LAUNCH_MENU_ITEMS',
--   },
-- })

-- -- 备用快捷键：Alt+`（反引号，Tab键上方，防止主快捷键仍冲突）
-- table.insert(keys, {
--   key = '`',
--   mods = 'ALT',
--   action = act.ShowLauncherArgs {
--     flags = 'FUZZY|LAUNCH_MENU_ITEMS',
--   },
-- })

-- -- 额外补充：WezTerm内置默认启动菜单快捷键（兜底）
-- -- 按 Alt+F1 也能唤起全局启动器，可手动选Launch Menu
-- table.insert(keys, {
--   key = 'F1',
--   mods = 'ALT',
--   action = act.ShowLauncher,
-- })

-- -- WSL new tab
-- if first_wsl_name then
--   table.insert(keys, {
--     key = 'w', mods = 'CTRL|ALT',
--     action = act.SpawnTab { DomainName = first_wsl_name },
--   })
-- else
--   table.insert(keys, {
--     key = 'w', mods = 'CTRL|ALT',
--     action = act.SpawnCommandInNewTab { args = { 'wsl.exe' } },
--   })
-- end

-- -- PowerShell new tab
-- if has_pwsh then
--   table.insert(keys, {
--     key = 'p', mods = 'CTRL|ALT',
--     action = act.SpawnCommandInNewTab {
--       domain = { DomainName = "local" },
--       args = { 'pwsh.exe', '-NoLogo' },
--     },
--   })
-- elseif has_powershell then
--   table.insert(keys, {
--     key = 'p', mods = 'CTRL|ALT',
--     action = act.SpawnCommandInNewTab {
--       domain = { DomainName = "local" },
--       args = { 'powershell.exe', '-NoLogo' },
--     },
--   })
-- end

-- -- cmd new tab
-- if has_cmd then
--   table.insert(keys, {
--     key = 'c', mods = 'CTRL|ALT',
--     action = act.SpawnCommandInNewTab {
--       domain = { DomainName = "local" },
--       args = { 'cmd.exe' },
--     },
--   })
-- end

-- -- Split panes
-- table.insert(keys, {
--   key = '\\', mods = 'CTRL|ALT',
--   action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
-- })
-- table.insert(keys, {
--   key = '-', mods = 'CTRL|ALT',
--   action = act.SplitVertical { domain = 'CurrentPaneDomain' },
-- })

-- -- Tab switching
-- for i = 1, 9 do
--   table.insert(keys, {
--     key = tostring(i), mods = 'ALT', action = act.ActivateTab(i - 1),
--   })
-- end
-- table.insert(keys, { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) })
-- table.insert(keys, { key = 'Tab', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(-1) })
-- table.insert(keys, { key = 'w', mods = 'CTRL|SHIFT', action = act.CloseCurrentTab { confirm = true } })
-- table.insert(keys, { key = 'r', mods = 'CTRL|SHIFT', action = act.ReloadConfiguration })

-- config.keys = keys

-- -- 5. 外观配置（兼容所有版本）
-- config.font = wezterm.font('Hack Nerd Font Mono')
-- config.font_size = 12
-- config.enable_tab_bar = true
-- config.hide_tab_bar_if_only_one_tab = false

-- return config