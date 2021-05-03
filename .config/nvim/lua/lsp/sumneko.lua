local u = require("utils")
local M = {}

M.root = vim.fn.getenv("HOME") .. "/CloudDrive/dev/lua-language-server/"
M.binary =
    u.get_os() == "Linux" and M.root .. "bin/Linux/lua-language-server" or
        u.get_os() == "Darwin" and M.root .. "bin/macOS/lua-language-server"
M.settings = {
    Lua = {
        runtime = {version = "Lua 5.1"},
        diagnostics = {
            enable = true,
            globals = {
                "vim", "use", "describe", "it", "assert", "before_each",
                "after_each"
            }
        }
    }
}

return M
