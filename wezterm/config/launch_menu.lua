local utils = require("config.utils")
local wezterm = require("wezterm")
local M = {}

local function get_wsl_distributions()
    if not utils.is_windows() then
        return {}
    end

    -- 不闪屏执行
    local ok, out= wezterm.run_child_process({
        "powershell.exe", "-NoProfile", "-Command",
        "wsl.exe --list --quiet | Out-String"
    })

    local distros = {}
    
    if not ok or not out then
        return distros
    end

    wezterm.log_info("=== 开始解析 WSL 输出 ===")
    -- 【核心修复】处理 UTF-16 空字符 + 清理所有空白
    wezterm.log_info("原始行长度: " .. out)
    
    local text = out:gsub("\x00", "")  -- 删掉所有 UTF-16 空字节

    -- 按行正确解析
    for line in text:gmatch("[^\r\n]+") do
        local name = line:gsub("^%s+", ""):gsub("%s+$", "")
        if name ~= "" then
            table.insert(distros, name)
        end
    end
    
    return distros
end

local function has_fish()
  -- io.open 不依赖 PATH，直接查文件
  local f = io.open("/opt/homebrew/bin/fish", "r")
  if f then f:close(); return true end
  -- Intel Mac 兜底
  f = io.open("/usr/local/bin/fish", "r")
  if f then f:close(); return true end
  return false
end

if wezterm.target_triple:match("darwin") or utils.is_windows == nil then
  -- 你在非 windows 分支
end



function M.apply(config)
    if utils.is_windows() then
        config.default_prog = { "pwsh", "-NoLogo" }
    else
        if has_fish() then
            config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
        else
            config.default_prog = { "/bin/bash", "-i" }
        end
    end

    local launch_menu = {
        { label = "Pwsh",        args = { "pwsh.exe", "-NoLogo" } },
        { label = "PowerShell",  args = { "powershell.exe", "-NoLogo" } },
    }

    if utils.is_windows() then
        local wsl_list = get_wsl_distributions()
        for _, distro in ipairs(wsl_list) do
            table.insert(launch_menu, {
                label = "WSL: " .. distro,
                -- 【关键修复】参数必须分开写！
                args = { "wsl.exe", "-d", distro},
            })
        end
    end

    config.launch_menu = launch_menu
end

return M