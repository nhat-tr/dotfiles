local u = require("utils")
local lsp = vim.lsp

local M = {}

M.format_async = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then return end
    if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        local view = vim.fn.winsaveview()
        lsp.util.apply_text_edits(result, bufnr)
        vim.fn.winrestview(view)
        if bufnr == vim.api.nvim_get_current_buf() then
            vim.api.nvim_command("noautocmd :update")
        end
    end
end

M.set_highlights = function()
    u.exec([[
    function! LspHighlights() abort
        hi def link LspDiagnosticsDefaultError ErrorMsg
        hi def link LspDiagnosticsDefaultWarning WarningMsg
        hi def link LspDiagnosticsDefaultInformation Title
        hi def linkLspDiagnosticsDefaultHint EndOfBuffer
        hi def link LspDiagnosticsUnderlineError ErrorMsg
        hi def link LspDiagnosticsUnderlineWarning WarningMsg
        hi def link LspDiagnosticsUnderlineInformation Title
        hi def link LspDiagnosticsUnderlineHint EndOfBuffer
    endfunction
    augroup LspHighlights
        autocmd!
        autocmd ColorScheme * call LspHighlights()
    augroup END
    ]])
end

return M 
