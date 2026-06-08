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

function M.apply(config)
    if utils.is_windows() then
        config.default_prog = { "pwsh", "-NoLogo" }
    else
        config.default_prog = utils.unix_command_exists("zsh")
            and { "zsh", "-i" }
            or { "bash", "-i" }
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