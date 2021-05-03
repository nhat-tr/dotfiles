local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local conf = require("telescope.config").values
local u = require("utils")

local vimgrep_arguments = u.concat(conf.vimgrep_arguments,
                                   {"-g", "!{node_modules,.git}"})

telescope.setup {
    defaults = {mappings = {i = {["<Esc>"] = actions.close, ["<C-u>"] = false}}}
}

_G.fuzzy_live_grep = function()
    builtin.grep_string {
        shorten_path = true,
        word_match = "-w",
        only_sort_text = true,
        search = "",
        vimgrep_arguments = vimgrep_arguments
    }
end

_G.grep_prompt = function()
    builtin.grep_string {
        vimgrep_arguments = vimgrep_arguments,
        shorten_path = true,
        search = vim.fn.input("grep > ")
    }
end

local find_files = function(opts)
    if opts and opts.search_dirs then
        builtin.find_files(opts)
        return
    end

    local is_git_project = pcall(builtin.git_files, opts)
    if not is_git_project then builtin.find_files(opts) end
end
_G.find_files = find_files

_G.open_telescope = function()
    local open = function(arg)
        vim.g.loaded_netrw = true
        local search_dirs = arg and {arg} or nil
        find_files({search_dirs = search_dirs})
    end

    local args = vim.v.argv
    table.remove(args, 1)
    if vim.tbl_isempty(args) then
        open()
        return
    end

    for _, arg in pairs(args) do
        if vim.fn.isdirectory(arg) == 1 then
            open(arg)
            return
        end
    end
end

-- fzf-like aliases
vim.cmd("command! Files lua find_files()")
vim.cmd("command! BLines Telescope current_buffer_fuzzy_find")
vim.cmd("command! History Telescope oldfiles")
vim.cmd("command! Buffers Telescope buffers")
vim.cmd("command! Rg lua fuzzy_live_grep()")
vim.cmd("command! RgPrompt lua grep_prompt()")
vim.cmd("command! LspRefs Telescope lsp_references")
vim.cmd("command! LspSym Telescope lsp_workspace_symbols")
-- unmapped
vim.cmd("command! BCommits Telescope git_bcommits")
vim.cmd("command! Commits Telescope git_commits")
vim.cmd("command! LspAct Telescope lsp_code_actions")

vim.api.nvim_exec([[
augroup TelescopeOnEnter
    autocmd!
    autocmd VimEnter * lua open_telescope()
augroup END
]], false)

