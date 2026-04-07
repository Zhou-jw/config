local utils = require("config.utils")
local M = {}

function M.apply(config)
    if utils.is_windows() then
        config.default_prog = { "pwsh", "--NoLogo" }
    else
        -- Unix 系统：zsh → bash
        if utils.unix_command_exists("zsh") then
            config.default_prog = { "zsh", "-i" }
        else
            config.default_prog = { "bash", "-i" }
        end
    end
    config.launch_menu = {
        -- Shell
        { label = "Pwsh",        args = { "pwsh.exe", "-NoLogo" } },
        { label = "PowerShell",  args = { "powershell.exe", "-NoLogo" } },

        -- WSL 发行版
        { label = "WSL: ubuntu2404", args = { "ubuntu2404.exe" } },

        -- SSH 连接
    }
end

return M
