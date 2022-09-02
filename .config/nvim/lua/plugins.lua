-- Auto install packer.nvim if it does not exist
-- from https://github.com/wbthomason/packer.nvim#bootstrapping
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    })
end

-- Load packer.nvim (only required if you have packer configured as `opt`)
vim.cmd [[packadd packer.nvim]]

-- Auto compile when there are changes in plugins.lua
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])
--
-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
function get_setup(name)
  return string.format('require("setup/%s")', name)
end

return require('packer').startup({
    function(use)

  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true}

  -- Color scheme
  -- base16 colorscheme
  use { 'chriskempson/base16-vim' }
  -- TODO checkout this theme
  -- use 'joshdick/onedark.vim'

  -- TODO read through readme and check commands/configurations
  -- Fuzzy finder
  use {
      'nvim-telescope/telescope.nvim',
      requires = {
        {'nvim-lua/popup.nvim'},  -- Popup API
        {'nvim-lua/plenary.nvim'},  -- library for lua functions
    }
  }


  -- Diagnostics
  -- -----------
  use {
    "folke/trouble.nvim",  -- lists of diagnostics, references, quickfixes, etc.
    requires = "kyazdani42/nvim-web-devicons",  -- Adds filetype glyphs (icons)
    config = get_setup('trouble'),
  }
  use 'folke/lsp-colors.nvim'  -- Creates missing LSP diagn. highlights for color schemes


  -- Git Integration
  -- ---------------
  use {
    'lewis6991/gitsigns.nvim',  -- git decorations, e.g. show changed lines
    -- TODO throws error in PackerSync
    -- requires = 'nvim-lua/plenary-nvim',  -- library for lua functions
    config = get_setup("gitsigns")
  }
  use { 'tpope/vim-fugitive' }  -- git wrapper, e.g. :GBlame


  -- LSP with Autocompletion
  -- -----------------------
  use {
    'VonHeikemen/lsp-zero.nvim',  -- Opinionated defaults for LSP with autocompletion
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},            -- Common configurations for built-in LSP client
      {'williamboman/nvim-lsp-installer'},  -- lspconfig plugin to install LSP servers

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},          -- Autocompletion plugin
      -- nvim-cmp "sources" provide the actual data displayed in neovim
      {'hrsh7th/cmp-buffer'},        -- provides suggestions based on the current file
      {'hrsh7th/cmp-path'},          -- gives completions based on the filesystem
      {'saadparwaiz1/cmp_luasnip'},  -- shows snippets in the suggestions
      {'hrsh7th/cmp-nvim-lsp'},      -- show data send by the language server
      {'hrsh7th/cmp-nvim-lua'},      -- provides completions based on neovim's lua API

      -- Snippets
      {'L3MON4D3/LuaSnip'},              -- Snippets plugin
      {'rafamadriz/friendly-snippets'},  -- Snippets for different programming languages
    }
  }
  -- Hook non-LSP sources (services) for additional features like formatting using Lua
  -- and the language server protocol standard API. For detailed explanation, see
  -- https://www.reddit.com/r/neovim/comments/t0af8y/what_is_the_purpose_of_nulllsnvim_ive_read_the/hy8nxsp/
  use ({
    "jose-elias-alvarez/null-ls.nvim",
    config = get_setup("null-ls"),
  })

  -- Navigation
  use {
    'kyazdani42/nvim-tree.lua',  -- file explorer
    requires = 'kyazdani42/nvim-web-devicons', -- Adds filetype glyphs (icons)
    config = get_setup("nvim-tree")
  }
  --
  -- Syntax Highlighting
  use {
      'nvim-treesitter/nvim-treesitter',  -- parser generator tool, e.g. for highlighting
      config = get_setup("treesitter"),
      run = ':TSUpdate',
  }
  use("p00f/nvim-ts-rainbow")             -- Rainbow parenthesis using tree-sitter
  use("romgrk/nvim-treesitter-context")   -- Show context of visible buffer contents


  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end

end})
