require"nvim-treesitter.configs".setup {
    ensure_installed = {
        "javascript", "typescript", "tsx", "lua", "json", "jsonc", "yaml",
        "query"
    },
    highlight = {enable = true},
    autotag = {enable = true},
    playground = {enable = true}
}

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
