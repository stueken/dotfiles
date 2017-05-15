" ==============================================================================
" Vundle configuration and installed Plugins
" ==============================================================================

set nocompatible                    " be iMproved, required for Vundle
filetype off                        " Disable file type detection, required
set rtp+=~/.vim/bundle/Vundle.vim   " Set the runtime path to include Vundle  
call vundle#begin()                 " Initialize Vundle 
Plugin 'VundleVim/Vundle.vim'       " Let Vundle manage Vundle, required 

""" Styling
" Plugin 'altercation/vim-colors-solarized' " solarized Colorscheme
Plugin 'chriskempson/base16-vim'          " base16 Colorscheme
Plugin 'vim-airline/vim-airline'          " status/tabline  
Plugin 'vim-airline/vim-airline-themes'   " themes for airline
Plugin 'godlygeek/tabular'                " required for Vim Markdown 
Plugin 'plasticboy/vim-markdown'          " Syntax highlighting & matching rules 
Plugin 'Yggdroot/indentLine'              " Display indention w. vertical lines

""" Navigation
Plugin 'christoomey/vim-tmux-navigator'   " Navigate in tmux panes & vim splits 
Plugin 'edkolev/tmuxline.vim'             " tmux statusline generator  
Plugin 'scrooloose/nerdtree'              " NERDTree tree explorer
Plugin 'Xuyuanp/nerdtree-git-plugin'      " git status flags in NERDTree

""" Search
Plugin 'kien/ctrlp.vim'   " CtrlP fuzzy finder NOT USED YET
Plugin 'mileszs/ack.vim'  " Ack.vim search

""" Editing
Plugin 'sheerun/vim-polyglot'     " Collection of language packs 
Plugin 'Valloric/YoucompleteMe'   " Code completion engine
Plugin 'Raimondi/delimitMate'     " auto-complete quotes, parens, brackets, etc.
Plugin 'tpope/vim-surround'       " easily editing brackets, quotes, tags, etc.
Plugin 'tpope/vim-commentary'     " adds commenting action
Plugin 'tpope/vim-repeat'         " Repeating supported plugin maps NOT USED YET
Plugin 'scrooloose/nerdcommenter' " comment functions

""" Debugging
Plugin 'w0rp/ale'           " Asynchronous Lint Engine
Plugin 'fisadev/vim-isort'  " Sort python imports using isort 

"""" Sessions
Plugin 'tpope/vim-obsession'  " continuously updated session files 

""" Git Integration
Plugin 'tpope/vim-fugitive'       " git wrapper NOT USED YET
Plugin 'airblade/vim-gitgutter'   " shows diffs on each line
 
""" Outlining
Plugin 'vimoutliner/vimoutliner'  " outline processor

call vundle#end()            " End of plugins, required for Vundle
filetype plugin indent on    " Enable language-dependent indenting, required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
"
" see :h vundle for more details or wiki for FAQ


" ==============================================================================
" vim configuration
" ==============================================================================

""" Display
syntax on       " Switch syntax highlighting on
set cursorline  " have a line indicate the cursor location
set number      " Show line numbers
set showcmd     " show pressed command in the button right corner
 
""" Spaces & Tabs
set expandtab     " Insert space characters whenever tab is pressed
set tabstop=2     " # of spaces to be inserted when tab is pressed
set shiftwidth=2  " # of spaces to use fore each step of (auto)indent

""" Editing
set backspace=indent,eol,start  " Backspace won't delete over line breaks 

""" Commands
set history=100  " Remember more commands (default=8)

""" Keybindings and Abbreviations - leader key is \ by default 
map <leader>rr :source ~/.vimrc<CR>   " Reload vim configuruation file 
nnoremap <C-J> <C-W><C-J>             " Ctrl-j to move down a split
nnoremap <C-K> <C-W><C-K>             " Ctrl-k to move up a split
nnoremap <C-L> <C-W><C-L>             " Ctrl-l to move right a split
nnoremap <C-H> <C-W><C-H>             " Ctrl-h to move left a split
:ab pdb import pdb; pdb.set_trace()   " Set abbreviation for pdb


" ==============================================================================
" ack.vim
" ==============================================================================

" Don't jump to the first result automatically
cnoreabbrev Ack Ack!   


" ==============================================================================
" airline
" ==============================================================================

" activate powerline fonts
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" unicode symbols as fallback if actual font doesn't have airline symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

set laststatus=2    " Always display the statusline in all windows 
set showtabline=2   " Always display the tabline, even if there is only one tab  
set noshowmode      " Hide the default mode text (e.g. INSERT below statusline) 
let g:airline#extensions#tabline#enabled = 1  " Display buffers when 1 tab open
let g:tmuxline_powerline_separators = 0  " Set straigt tmux powerline separators 


" ==============================================================================
" Color Theme Solarized
" ============================================================================== 

" syntax enable
" set background=dark  " Alternative: light
" colorscheme solarized

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

let g:ctrlp_map = '<c-p>'  " Change default mapping to invoke CtrlP
let g:ctrlp_cmd = 'CtrlP'  " Change defualt command to invoke CtrlP


" ==============================================================================
" NERD Commenter
" ==============================================================================

let g:NERDSpaceDelims = 1             " Add spaces after comment delimiters 
let g:NERDTrimTrailingWhitespace = 1  " Trim trailing whitespace when uncomment 


" ==============================================================================
" NERDTree
" ==============================================================================

map <C-n> :NERDTreeToggle<CR>  " Change the default mapping
 
" Filter out files by extension
let NERDTreeIgnore = ['\.pyc$', 'htmlcov', '__pycache__']


" ==============================================================================
" NERDTree git-plugin
" ==============================================================================

" Config custom symbols
let g:NERDTreeIndicatorMapCustom = {
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
