" ==============================================================================
" vim-plug configuration and installed Plugins
" ==============================================================================

set nocompatible                    " be iMproved, required for Vundle
filetype off                        " Disable file type detection, required
call plug#begin('~/.vim/plugged')

""" Styling
Plug 'chriskempson/base16-vim'          " base16 Colorscheme
Plug 'itchyny/lightline.vim'            " statusline/tablline
" Plug 'vim-airline/vim-airline'          " status/tabline
" Plug 'vim-airline/vim-airline-themes'   " themes for airline
" Plug 'godlygeek/tabular'                " required for Vim Markdown
" Plug 'plasticboy/vim-markdown'          " Syntax highlighting & matching rules
Plug 'Yggdroot/indentLine'              " Display indention w. vertical lines
" Plug 'psf/black', {'branch': 'stable'}  " use black in vim
Plug 'numirias/semshi'                  " semantic highlighting for Python in Neovim
Plug 'lilydjwg/colorizer'               " highlight hexadecimal values in color
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

""" Navigation
Plug 'christoomey/vim-tmux-navigator'   " Navigate in tmux panes & vim splits
Plug 'edkolev/tmuxline.vim'             " tmux statusline generator
Plug 'scrooloose/nerdtree'              " NERDTree tree explorer
Plug 'Xuyuanp/nerdtree-git-plugin'      " git status flags in NERDTree

""" Search
" Plug 'kien/ctrlp.vim'   " CtrlP fuzzy finder NOT USED YET
Plug 'mileszs/ack.vim'  " Ack.vim search

""" Editing
Plug 'sheerun/vim-polyglot'     " Collection of language packs
" Plug 'Valloric/YoucompleteMe'   " Code completion engine
Plug 'davidhalter/jedi-vim'     " Python autocompletion and 'go to definition'
" Plug 'Raimondi/delimitMate'     " auto-complete quotes, parens, brackets, etc.
" Plug 'tpope/vim-surround'       " easily editing brackets, quotes, tags, etc.
Plug 'tpope/vim-commentary'     " adds commenting action
" Plug 'tpope/vim-repeat'         " Repeating supported plugin maps NOT USED YET
" Plug 'scrooloose/nerdcommenter' " comment functions

""" Debugging
" Plug 'w0rp/ale'           " Asynchronous Lint Engine
" Plug 'fisadev/vim-isort'  " Sort python imports using isort

"""" Sessions
" Plug 'tpope/vim-obsession'  " continuously updated session files

""" Git Integration
Plug 'tpope/vim-fugitive'       " git wrapper, e.g. :GBlame
Plug 'airblade/vim-gitgutter'   " shows diffs on each line
Plug 'rhysd/git-messenger.vim'  " reveals the commit messages under the cursor
 
""" Outlining
" Plug 'vimoutliner/vimoutliner'  " outline processor

call plug#end()

" Brief help
" :PlugInstall      - Install plugins
" :PlugUpdate       - Install or update plugins
" :PlugClean[!]      - confirms removal of unused plugins; append `!` to
" :PlugUpgrade      - Upgrade vim-plug itself
" :PlugStatus       - Check the status of plugins
" :PlugDiff         - Examine changes from the previous update
" :PlugSnapshot[!]  - Generate script for restoring the snapshot of plugins
"
" see :h vundle for more details or wiki for FAQ


" ==============================================================================
" vim configuration
" ==============================================================================

""" Display
" syntax on              " Switch syntax highlighting on, NVIM DEFAULT
set cursorline         " Have a line indicate the cursor location
set colorcolumn=80,90  " Show verticle bar after 80 and 90 chars
set number             " Show line numbers
set showcmd            " Show pressed command in the button right corner
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn  " Ignore extensions

""" Spaces & Tabs
set expandtab     " Insert space characters whenever tab is pressed
set tabstop=4     " # of spaces to be inserted when tab is pressed
set shiftwidth=4  " # of spaces to use fore each step of (auto)indent
set list
set list listchars=tab:→·,trail:·,eol:¬,extends:⇉,precedes:⇇

""" Editing
" set backspace=indent,eol,start  " No delete over line breaks, NVIM DEFAULT

""" Commands
" set history=100  " Remember more commands (default=8), NVIM DEFAULT = 10000

""" Swap files
set directory^=$HOME/.vim/tmp//  " Organize swap files

""" Keybindings and Abbreviations - leader key is \ by default
" Reload vim configuruation file
map <leader>rrr:source ~/.vimrc<CR>
" Ctrl-j to move down a splij
nnoremap <C-J> <C-W><C-Jj
" Ctrl-k to move up a split
nnoremap <C-K> <C-W><C-K>
" Ctrl-l to move right a split
nnoremap <C-L> <C-W><C-L>
" Ctrl-h to move left a split
nnoremap <C-H> <C-W><C-H>
" Run Black on save
nnoremap <leader>b :Black<CR> <bar> :w<CRr
" Set abbreviation for rb
:ab pdb import pdb; pdb.set_trace()


" ==============================================================================
" ack.vim
" ==============================================================================

" Don't jump to the first result automatically
cnoreabbrev Ack Ack!


" ==============================================================================
" black
" ==============================================================================
"
let g:black_linelength = 90
" use ' and "
let g:black_skip_string_normalization = 1
let g:black_virtualenv = '~/.pyenv/versions/3.6.3/envs/black'
" run Black on save
autocmd BufWritePre *.py execute ':Black'
"
" ==============================================================================
" fzf
" ==============================================================================
"
set rtp+=~/.fzf     " runtime path of fzf
"
" ==============================================================================
" lightline
" ==============================================================================

" choose colorscheme
let g:lightline = {'colorscheme': 'wombat'}

" show abbreviated path of filename
let g:lightline = {
  \ 'component_function': {
    \ 'filename': 'LightlineFilename',
  \ },
\ }
function! LightlineFilename()
  return expand('%:t') ==# '' ? '[No Name]' : pathshorten(fnamemodify(expand('%'), ":."))
endfunction

" ==============================================================================
" airline
" ==============================================================================

" activate powerline fonts
" let g:airline_powerline_fonts = 1
" if !exists('g:airline_symbols')
" "	let g:airline_symbols = {}
" endif

" unicode symbols as fallback if actual font doesn't have airline symbols
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ''

" set laststatus=2    " Always display the statusline in all windows
" set showtabline=2   " Always display the tabline, even if there is only one tab
" set noshowmode      " Hide the default mode text (e.g. INSERT below statusline)
" let g:airline#extensions#tabline#enabled = 1  " Display buffers when 1 tab open
" let g:tmuxline_powerline_separators = 0  " Set straigt tmux powerline separators

" disable all airline extensions (-> better Performance)
" let g:airline_extensions = []

" enable cahing of various syntax highlighting groups (-> better Performance)
" let g:airline_highlighting_cache = 1

" ==============================================================================
" Color Theme base16
" ==============================================================================

" Remove the base16colorspace line if not needed
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
colorscheme base16-default-dark


" ==============================================================================
" CtrlP
" ==============================================================================

" let g:ctrlp_map = '<c-p>'  " Change default mapping to invoke CtrlP
" let g:ctrlp_cmd = 'CtrlP'  " Change defualt command to invoke CtrlP


" ==============================================================================
" NERD Commenter
" ==============================================================================

" let g:NERDSpaceDelims = 1             " Add spaces after comment delimiters
" let g:NERDTrimTrailingWhitespace = 1  " Trim trailing whitespace when uncomment


" ==============================================================================
" NERDTree
" ==============================================================================

map <C-n> :NERDTreeToggle<CR>  " Change the default mapping
 
" Filter out files by extension
let NERDTreeIgnore = ['\.pyc$', 'htmlcov', '__pycache__', '\.orig$']


" ==============================================================================
" NERDTree git-plugin
" ==============================================================================

" Config custom symbols
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }
