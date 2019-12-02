" Initialize nvim with vim vimrc
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Configure Python 3 provider (own virtualenv)
let g:python3_host_prog = '/home/norbert/.pyenv/versions/neovim/bin/python'

" Configure black (own virtualenv)
let g:black_virtualenv = '/home/norbert/.pyenv/versions/3.6.3/envs/black'

" Always use the clipboard for all operations
set clipboard+=unnamedplus
