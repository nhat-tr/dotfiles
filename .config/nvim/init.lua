local u = require("utils")

vim.o.clipboard = "unnamedplus"
vim.o.completeopt = "menuone,noinsert"
vim.o.expandtab = true
vim.o.foldlevelstart = 99
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.mouse = "a"
vim.o.pumheight = 10
vim.o.shiftwidth = 4
vim.o.shortmess = "filnxtToOFcA"
vim.o.showcmd = false
vim.o.showtabline = 2
vim.o.smartcase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.statusline = [[%f %y %m %= %p%% %l:%c]]
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.updatetime = 300

vim.wo.cursorline = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = "yes"

-- (auto)commands
vim.cmd("command! Bd %bd")
vim.cmd("command! Bo %bd|e#|bd#")
vim.cmd("command! R w | :e")
vim.cmd("command! Remove call delete(expand('%')) | bdelete!")

local auto_formatters = {            }

local python_autoformat = {'BufWritePre', '*.py', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'}
table.insert(auto_formatters, python_autoformat)

local javascript_autoformat = {'BufWritePre', '*.js', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'}
local javascriptreact_autoformat = {'BufWritePre', '*.jsx', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'}
table.insert(auto_formatters, javascript_autoformat)
table.insert(auto_formatters, javascriptreact_autoformat)

local lua_format = {'BufWritePre', '*.lua', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'}
table.insert(auto_formatters, lua_format)

local json_format = {'BufWritePre', '*.json', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'}
table.insert(auto_formatters, json_format)

require("plugins")
require("plugins.gitsigns")
require("plugins.hop")
require("plugins.omnisharp")
require("plugins.telescope")
require("plugins.treesitter")

vim.cmd('colorscheme gruvbox')

require("lsp")

require("keymappings")
