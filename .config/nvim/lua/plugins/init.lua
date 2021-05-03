local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    execute 'packadd packer.nvim'
end

local my = function(file) require(file) end

vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

require('packer').init({display = {auto_clean = false}})

return require('packer').startup(function()
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use "nvim-telescope/telescope.nvim"
      
  use 'nvim-telescope/telescope-media-files.nvim'
  use 'airblade/vim-rooter'

  -- Git
  use 'airblade/vim-gitgutter'
  use 'tpope/vim-fugitive'
  use "lewis6991/gitsigns.nvim"

  use 'ekalinin/Dockerfile.vim'
  use 'kyazdani42/nvim-tree.lua'
  use "phaazon/hop.nvim"

  -- Make code editor fancier
  use 'luochen1990/rainbow'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'morhetz/gruvbox'

  -- Treesitter
  use {
          "nvim-treesitter/nvim-treesitter",
          run = ":TSUpdate",
      }
  use {"windwp/nvim-ts-autotag", requires = "nvim-treesitter/nvim-treesitter"} 
  --use 'JoosepAlviste/nvim-ts-context-commentstring'

  -- Icons
  use 'kyazdani42/nvim-web-devicons'
  use 'ryanoasis/vim-devicons'

  use 'tpope/vim-commentary'

  -- Print function signatures in echo area
  use 'Shougo/echodoc.vim'
  -- Development
  use 'puremourning/vimspector'
  use 'neovim/nvim-lspconfig'
  --use 'nvim-lua/completion-nvim'
  use {
    'haorenW1025/completion-nvim',
    opt = true,
    requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}
  }
  use 'w0rp/ale'
  use 'prabirshrestha/asyncomplete.vim'
 
  -- C# development
  use 'OmniSharp/omnisharp-vim'

 end)
