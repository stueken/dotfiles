local utils = require('utils')

-- Keybindings and Abbreviations
-- -----------------------------

-- Clear highlights
utils.map('n', '<leader>h', '<cmd>noh<CR>')
-- jk to escape
utils.map('i', 'jk', '<Esc>')

-- Ctrl-j to move down a split
utils.map('n', '<C-J>', '<C-W><C-J>')
-- Ctrl-k to move up a split
utils.map('n', '<C-K>', '<C-W><C-K>')
-- Ctrl-l to move right a split
utils.map('n', '<C-L>', '<C-W><C-L>')
-- Ctrl-h to move left a split
utils.map('n', '<C-H>', '<C-W><C-H>')

-- Black
-- -----
-- TODO Run Black on save
-- nnoremap <leader>b :Black<CR> <bar> :w<CRr

-- NERDTree
-- --------
-- TODO Still needed after NvimTreeToggle has been fully migrated?
utils.map('n', '<C-n>', ':NvimTreeToggle<CR>') -- Change the default mapping

-- Set abbreviation for rb
-- :ab pdb import pdb; pdb.set_trace()
vim.cmd([[
au filetype python :iabbrev ipdb import ipdb;ipdb.set_trace()
au filetype python :iabbrev pdb import pdb;pdb.set_trace()
]])
