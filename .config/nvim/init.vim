" Initialize nvim with vim vimrc
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Configure Python 2 & 3 provider (own virtualenv)
let g:python_host_prog = '/home/norbert/.pyenv/versions/py2nvim/bin/python'
let g:python3_host_prog = '/home/norbert/.pyenv/versions/py3nvim/bin/python'

" Configure NodeJS provider
let g:node_host_prog = '/usr/local/bin/neovim-node-host'

" Always use the clipboard for all operations
set clipboard+=unnamedplus
