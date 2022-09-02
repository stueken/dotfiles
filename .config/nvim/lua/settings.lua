local utils = require('utils')

local cmd = vim.cmd
local indent = 4

cmd 'syntax enable'
cmd 'filetype plugin indent on'

-- Display
----------
-- Show line numbers
utils.opt('w', 'number', true)
-- Show a few lines around cursor
utils.opt('o', 'scrolloff', 4 )
-- TODO
utils.opt('o', 'shiftround', true)
-- TODO
utils.opt('o', 'splitbelow', true)
-- TODO
utils.opt('o', 'splitright', true)

-- Navigation
-- ----------
-- Show full list on command line completion
utils.opt('o', 'wildmode', 'list:longest')  -- TODO was "longest:full,list"
-- TODO
utils.opt('w', 'relativenumber', true)
-- Always use the clipboard for all operations
utils.opt('o', 'clipboard','unnamed,unnamedplus') -- TODO was vim.o.clipboard .. "unnamedplus"

-- Search
-- ------
-- Search is case insensitive
utils.opt('o', 'ignorecase', true)
-- Search case sensitive if caps on
utils.opt('o', 'smartcase', true)

-- Spaces & Tabs
-- -------------
-- Insert space characters whenever tab is pressed
utils.opt('b', 'expandtab', true)
-- # of spaces to use for each step of (auto)indent
utils.opt('b', 'shiftwidth', indent)
-- TODO
utils.opt('b', 'smartindent', true)
-- # of spaces moved when tab is pressed
utils.opt('b', 'softtabstop', indent)
-- # of spaces for a displayed tab
utils.opt('b', 'tabstop', indent)
-- TODO
utils.opt('o', 'hidden', true)


-- TODO Highlight on yank
vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'


-- TODO Give me space
vim.opt.signcolumn = 'yes'
