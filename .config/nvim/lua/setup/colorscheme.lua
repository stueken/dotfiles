-- ============================================================================?
-- Color Theme base16
-- =============================================================================

-- Update vim colorscheme in sync with base16-shell
vim.cmd([[
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
]])
