-- ============================================================================
-- nvim-plug configuration and installed Plugins
-- ============================================================================

-- Install vim-plug if not installed
vim.cmd([[
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')

""" Editing
Plug 'tpope/vim-commentary' " Comment stuff out
Plug 'tpope/vim-surround'   " Insert or delete brackets, parens, quotes in pairs

""" Git Integration
Plug 'rhysd/git-messenger.vim'  " reveals the commit messages under the cursor

""" Interface / Looks
Plug 'itchyny/lightline.vim'        " statusline/tabline
Plug 'lilydjwg/colorizer'           " highlight hexadecimal values in color
Plug 'mgee/lightline-bufferline'    " For tabs on top
Plug 'tpope/vim-obsession'          " store and restore vim sessions
Plug 'Yggdroot/indentLine'          " Display indention w. vertical lines
" Feature in nvim-tree? Plug 'Xuyuanp/nerdtree-git-plugin'  " git status flags in NERDTree

""" Navigation
Plug 'christoomey/vim-tmux-navigator'   " Navigate in tmux panes & vim split_lines
Plug 'edkolev/tmuxline.vim'             " tmux statusline generator

call plug#end()
]])

-- Variables
-- ---------

HOME = os.getenv("HOME")

-- Helper Functions
-------------------

function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end


-- ============
-- New init.lua
-- ============

-- Map leader to space
vim.g.mapleader = ' '

require('settings')
require('plugins')
require('keymappings')
require('setup')
-- OR invoke config files individually, e.g.
-- require('config.colorscheme')  -- color scheme

-- =============================================================================
-- nvim configuration
-- =============================================================================

-- Providers
-- ---------
-- Configure Python 2 & 3 provider (own virtualenv)
vim.g.python_host_prog = HOME .. "/.pyenv/versions/py2nvim/bin/python"
vim.g.python3_host_prog = HOME .. "/.pyenv/versions/py3nvim/bin/python"
-- Configure NodeJS provider
vim.g.node_host_prog = HOME .. "/.nvm/versions/node/v14.15.5/bin/neovim-node-host"
-- Disable Ruby support
vim.g.loaded_ruby_provider = 0
-- Disable Perl support
vim.g.loaded_perl_provider = 0

-- Backup
-- ------
-- Automatically keep a copy of past versions

-- create required directories if necessary
vim.cmd([[
if !isdirectory($HOME . "/.config/nvim/backup")
    call mkdir($HOME . "/.config/nvim/backup", "p", 0700)
endif
]])

vim.o.backup = true                 -- Turn on backup option
vim.o.backupdir = HOME .. "/.config/nvim/backup" -- Where to store backups
vim.o.writebackup = true            -- Make backup before overwriting the current buffer
vim.o.backupcopy = "yes"            -- Overwrite the original backup file
-- Meaningful backup name, ex: filename@2015-04-05.14:59
vim.cmd("au BufWritePre * let &bex = '@' . strftime(\"%F.%H:%M\")")

-- Display
----------
--
vim.o.cursorline = true     -- Have a line indicate the cursor location
vim.o.colorcolumn = "80,90" -- Show verticle bar after 80 and 90 chars
vim.o.lazyredraw = true     -- Don't redraw screen while executing macros
-- vim.o.number = true         -- Show line numbers
-- vim.o.scrolloff = 5	        -- Show a few lines around cursor
vim.o.wildignore = "~,.o,.bak,.exe,.obj,.py[co],.svn,.swp" -- Ignore extensions

-- Keybindings and Abbreviations
-- -----------------------------

-- leader key is \ by default
-- vim.g.mapleader = ","  -- vim: let mapleader = ","

-- Ctrl-j to move down a split
-- nmap("<C-J>", "<C-W><C-J>")
-- Ctrl-k to move up a split
-- nmap("<C-K>", "<C-W><C-K>")
-- Ctrl-l to move right a split
-- nmap("<C-L>", "<C-W><C-L>")
-- Ctrl-h to move left a split
-- nmap("<C-H>", "<C-W><C-H>")

-- TODO Run Black on save
-- nnoremap <leader>b :Black<CR> <bar> :w<CRr

-- Set abbreviation for rb
-- :ab pdb import pdb; pdb.set_trace()
-- vim.cmd([[
-- au filetype python :iabbrev ipdb import ipdb;ipdb.set_trace()
-- au filetype python :iabbrev pdb import pdb;pdb.set_trace()
-- ]])

-- Navigation
-- ----------

-- vim.o.clipboard = vim.o.clipboard .. "unnamedplus" -- Always use the clipboard for all operations
vim.o.mouse = "a"                           -- enable mouse in all modes
-- vim.o.wildmode = "longest:full,list"   -- Show full list on command line completion

-- Search
-- ------
-- vim.o.ignorecase = true -- Search is case insensitive
vim.o.hlsearch = true   -- Highlight matches to the search
-- vim.o.smartcase = true  -- Search case sensitive if caps on
vim.o.wrapscan = true   -- Begin search from top of file when nothing is found anymore

-- Spaces & Tabs
-- -------------
-- vim.o.expandtab = true  -- Insert space characters whenever tab is pressed
vim.o.list = true
vim.cmd("set list listchars=tab:→·,trail:·,eol:¬,extends:⇉,precedes:⇇")
-- vim.o.shiftwidth = 4  -- # of spaces to use fore each step of (auto)indent
-- vim.o.tabstop = 4     -- # of spaces to be inserted when tab is pressed

-- Misc
-- ----
vim.cmd("set directory^=$HOME/.vim/tmp//")  -- Organize swap files
vim.cmd("set nomodeline")                   -- security vulnerabiliy to enable
vim.o.spelllang = "en_us"                   -- set spellcheck


-- =============================================================================
-- TODO black
-- =============================================================================
--
-- let g:black_linelength = 90
-- use ' and "
-- let g:black_skip_string_normalization = 1
-- let g:black_virtualenv = '~/.pyenv/versions/3.6.3/envs/black'
-- run Black on save
-- autocmd BufWritePre *.py execute ':Black'


-- =============================================================================
-- Color Theme base16
-- =============================================================================

-- Update vim colorscheme in sync with base16-shell
-- vim.cmd([[
-- if filereadable(expand("~/.vimrc_background"))
--   let base16colorspace=256
--   source ~/.vimrc_background
-- endif
-- ]])

-- =============================================================================
-- fzf Replaced by telescope
-- =============================================================================

-- nnoremap <C-p> :Files<ENTER>

-- vim.cmd([[
-- if has("nvim")
--   au! TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
--   au! FileType fzf tunmap <buffer> <Esc>
-- endif
-- ]])

-- =============================================================================
-- lightline
-- =============================================================================

-- choose colorscheme
vim.g.lightline = {colorscheme = 'wombat'}

-- activate when devicons are working
vim.g['lightline#bufferline#enable_devicons'] = 1

-- show abbreviated path of filename
vim.g.lightline = {
  component_function = {
    filename = 'LightlineFilename',
  },
}
vim.cmd([[
function! LightlineFilename()
  return expand('%:t') ==# '' ? '[No Name]' : pathshorten(fnamemodify(expand('%'), ":."))
endfunction
]])

-- =============================================================================
-- NERDTree
-- =============================================================================

-- nmap('<C-n>', ':NERDTreeToggle<CR>')	-- Change the default mapping

-- TODO may reconfigure in nvim-tree
-- -- Filter out files by extension
-- vim.cmd([[
-- let g:NERDTreeIgnore = ['\.pyc$', 'htmlcov', '__pycache__', '\.orig$']
-- ]])

-- =============================================================================
-- NERDTree git-plugin
-- =============================================================================

-- TODO maybe reconfigure in nvim-tree
-- -- Config custom symbols
-- vim.g.NERDTreeGitStatusIndicatorMapCustom = {
--     Modified  = "✹",
--     Staged    = "✚",
--     Untracked = "✭",
--     Renamed   = "➜",
--     Unmerged  = "═",
--     Deleted   = "✖",
--     Dirty     = "✗",
--     Clean     = "✔︎",
--     Unknown   = "?"
-- }
