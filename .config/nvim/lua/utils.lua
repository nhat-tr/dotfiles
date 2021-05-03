local nvim_config_dir = vim.fn.getenv("HOME") .. "/.config/nvim/lua/"

local get_map_options = function(opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend("force", options, opts) end
    return options
end

local M = {}
M.exec = function(command) vim.api.nvim_exec(command, false) end
M.t =
    function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

M.contains = function(list, candidate)
    for _, element in pairs(list) do
        if element == candidate then return true end
    end
    return false
end

M.config_file_exists = function(name)
    local f = vim.loop.fs_open(nvim_config_dir .. name .. ".lua", "r", 438)
    if f then return true end
    return false
end

M.map = function(mode, lhs, rhs, opts)
    vim.api.nvim_set_keymap(mode, lhs, rhs, get_map_options(opts))
end

M.buf_map = function(bufnr, mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, get_map_options(opts))
end
M.buf_opt = function(bufnr, opt, val)
    vim.api.nvim_buf_set_option(bufnr, opt, val)
end

M.get_os = function()
    return vim.api.nvim_eval([[substitute(system("uname"), "\n", "", "")]])
end

_G.inspect = function(...) print(vim.inspect(...)) end
M.inspect = _G.inspect

M.concat = function(target, new)
    for _, v in pairs(new) do table.insert(target, v) end
end

return M
