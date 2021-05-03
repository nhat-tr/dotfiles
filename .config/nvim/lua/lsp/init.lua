local u = require("utils")
local functions = require("lsp.functions")
local nvim_lsp = require("lspconfig")
local sumneko = require("lsp.sumneko")
local diagnosticls = require("lsp.diagnosticls")

vim.lsp.handlers["textDocument/formatting"] = functions.format_async
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {underline = true, signs = true, virtual_text = true})

vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {border = "single"})

local on_attach = function(client, bufnr)
    u.buf_opt(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    local opts = { noremap=true, silent=true }
    u.buf_map(bufnr,'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    u.buf_map(bufnr,'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    u.buf_map(bufnr,'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    u.buf_map(bufnr,'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    u.buf_map(bufnr,'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    u.buf_map(bufnr,'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    u.buf_map(bufnr,'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    u.buf_map(bufnr,'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    u.buf_map(bufnr,'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    u.buf_map(bufnr,'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    u.buf_map(bufnr,'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    u.buf_map(bufnr,'n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    u.buf_map(bufnr,'n', '8d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    u.buf_map(bufnr,'n', '9d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    u.buf_map(bufnr,'n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
      u.buf_map(bufnr,"n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
      u.exec([[
        augroup LspFormatOnSave
            autocmd! * <buffer>
            autocmd BufWritePost <buffer> LspFormatting
        augroup END
      ]])
    end
    if client.resolved_capabilities.document_range_formatting then
      u.buf_map(bufnr,"v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    -- require("illuminate").on_attach(client)
end

local pid = vim.fn.getpid()
local omnisharp_bin = "/Users/nhattran/.cache/omnisharp-vim/omnisharp-roslyn/OmniSharp.exe"
nvim_lsp.omnisharp.setup{
    on_attach = function(client, bufnr)
        on_attach(client)
        u.buf_map(bufnr, "i", ".", ".<C-x><C-o>")
    end,
    cmd = {"mono", omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) } 
}

nvim_lsp.tsserver.setup {
    cmd = {
        "typescript-language-server", "--stdio", "--tsserver-path",
        "/usr/local/bin/tsserver-wrapper"
    },
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },    
    settings = {documentFormatting = false},
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        on_attach(client)

        u.buf_map(bufnr, "i", ".", ".<C-x><C-o>")

        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup {
            enable_import_on_completion = true,
            eslint_bin = "eslint_d"
        }
        vim.lsp.buf_request_sync = ts_utils.buf_request_sync
        vim.lsp.buf_request = ts_utils.buf_request

        u.buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>", {silent = true})
        u.buf_map(bufnr, "n", "gI", ":TSLspRenameFile<CR>", {silent = true})
        u.buf_map(bufnr, "n", "gt", ":TSLspImportAll<CR>", {silent = true})
        u.buf_map(bufnr, "n", "qq", ":TSLspFixCurrent<CR>", {silent = true})

    end
}

nvim_lsp.sumneko_lua.setup {
    on_attach = function(client, bufnr)
        on_attach(client)
        u.buf_map(bufnr, "i", ".", ".<C-x><C-o>")
    end,
    cmd = {sumneko.binary, "-E", sumneko.root .. "/main.lua"},
    settings = sumneko.settings
}

-- efm {{{
local eslint_d = {
    lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"},
    lintIgnoreExitCode = true,
    formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
    formatStdin = true
}
local luaFormat = {
    formatCommand = "luafmt --stdin",
    formatStdin = true
}
local yaml = {
    lintCommand = "yamllint -f parsable -",
    lintStdin = true
}
local languages = {
    typescript = {eslint_d},
    javascript = {eslint_d},
    typescriptreact = {eslint_d},
    javascriptreact = {eslint_d},
    lua = {luaFormat},
    yaml = {yaml}
}
nvim_lsp.efm.setup {
    init_options = {
        documentFormatting = true,
        codeAction = true
    },
    settings = {
        languages = languages
    },
    filetypes = {
        "javascript",
        "typescript",
        "typescriptreact",
        "javascriptreact",
        "lua",
        "yaml"
    }
}
-- efm }}}

require("lsp.settings")()
