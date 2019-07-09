" Initialize nvim with vim vimrc
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Configure Python 3 provider (own virtualenv)
let g:python3_host_prog = '/home/norbert/.pyenv/versions/py3nvim/bin/python'

" Always use the clipboard for all operations
set clipboard+=unnamedplus
