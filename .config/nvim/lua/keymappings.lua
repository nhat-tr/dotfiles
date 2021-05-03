local u = require("utils")

vim.g.mapleader = ' '

-- no hl
u.map('n', '<Leader>h', ':set hlsearch!<CR>')

-- explorer
u.map('n', '<leader>b', ':NvimTreeToggle<CR>', {silent = true})

-- better window movement
u.map('n', '<C-h>', '<C-w>h', {silent = true})
u.map('n', '<C-j>', '<C-w>j', {silent = true})
u.map('n', '<C-k>', '<C-w>k', {silent = true})
u.map('n', '<C-l>', '<C-w>l', {silent = true})

-- resize with arrows
vim.cmd([[
  nnoremap <silent> <C-Up>    :resize -2<CR>
  nnoremap <silent> <C-Down>  :resize +2<CR>
  nnoremap <silent> <C-Left>  :vertical resize -2<CR>
  nnoremap <silent> <C-Right> :vertical resize +2<CR>
]])

-- better indenting
u.map('v', '<', '<gv')
u.map('v', '>', '>gv')

u.map('i', 'jk', '<ESC>')
u.map('i', 'kj', '<ESC>')
u.map('i', 'jj', '<ESC>')

-- Tab switch buffer
u.map('n', '<TAB>', ':bnext<CR>')
u.map('n', '<S-TAB>', ':bprevious<CR>')

-- Move selected line / block of text in visual mode
u.map('x', 'K', ':move \'<-2<CR>gv-gv')
u.map('x', 'J', ':move \'>+1<CR>gv-gv')

-- Better nav for omnicomplete
vim.cmd('inoremap <expr> <c-j> (\"\\<C-n>\")')
vim.cmd('inoremap <expr> <c-k> (\"\\<C-p>\")')

-- clear ^M
u.map('n', '<leader>cm', ':e ++ff=dos<cr>')
-- clear search
u.map('n', '<leader>cs', ":let @/=''<cr>")
-- Opens an edit cmd with the path of the currently edited file
u.map('n', '<Leader>ne', ':e <C-R>=expand("%:p:h") . "/" <CR>')

-- telescope {{{
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Files<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fg", "<cmd>Rg<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fG", "<cmd>RgPrompt<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fb", "<cmd>Buffers<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fh", "<cmd>History<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fl", "<cmd>BLines<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fr", "<cmd>LspRef<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fs", "<cmd>LspSym<CR>", {silent = true})

vim.api.nvim_set_keymap("n", "ga", "<cmd>LspAct<CR>", {silent = true})
-- }}} telescope

