vim.g.OmniSharp_server_stdio = 1

if vim.fn.has('win32') == 0 then
  vim.g.OmniSharp_server_use_mono = 1
end

vim.g.OmniSharp_diagnostic_showid = 1
vim.g.OmniSharp_typeLookupInPreview = 0
