local utils = require("config.utils")
local wezterm = require("wezterm")
local M = {}

--- 获取 WSL 发行版列表（Windows only）
--- @return string[]
local function get_wsl_distributions()
    if not utils.is_windows() then
        return {}
    end

    local ok, out = wezterm.run_child_process({
        "powershell.exe",
        "-NoProfile",
        "-Command",
        "wsl --list --quiet",
    })

    if not ok or not out or out == "" then
        return {}
    end

    -- UTF-16LE → UTF-8（WSL 输出是 UTF-16）
    out = wezterm.utf16_to_utf8(out)

    local distros = {}

    for line in out:gmatch("[^\r\n]+") do
        local name = line:match("^%s*(.-)%s*$")
        if name ~= "" then
            table.insert(distros, name)
        end
    end

    return distros
end

--- 检测 fish shell（macOS / Linux only）
--- @return boolean
local function has_fish()
    for _, path in ipairs({
        "/opt/homebrew/bin/fish",
        "/usr/local/bin/fish",
        "/usr/bin/fish",
    }) do
        local f = io.open(path, "rb")
        if f then
            f:close()
            return true
        end
    end
    return false
end

function M.apply(config)
    local launch_menu = {}

    -- ===== Windows =====
    if utils.is_windows() then
        config.default_prog = { "nu"}

        launch_menu = {
            { label = "PowerShell", args = { "powershell.exe", "-NoLogo" } },
            { label = "Pwsh",       args = { "pwsh.exe", "-NoLogo" } },
            { label = "NuShell",       args = { "nu.exe"} },
        }

        -- 改用封装的 get_wsl_distributions 函数
        local wsl_list = get_wsl_distributions()
        for _, distro in ipairs(wsl_list) do
            table.insert(launch_menu, {
                label = "WSL: " .. distro,
                args = { "wsl.exe", "-d", distro },
            })
        end

    -- ===== macOS / Linux =====
    else
        if has_fish() then
            config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
        else
            config.default_prog = { "/bin/bash", "-i" }
        end
    end

    config.launch_menu = launch_menu
end

return M