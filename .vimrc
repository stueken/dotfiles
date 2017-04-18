" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible              " be iMproved, required for Vundle

filetype off                  " required for Vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required for Vundle
Plugin 'VundleVim/Vundle.vim'
" vim-tmux-navigator
Plugin 'christoomey/vim-tmux-navigator'
" vim-airline: status/tabline
Plugin 'vim-airline/vim-airline'
" vim-airline-themes
Plugin 'vim-airline/vim-airline-themes'
" tmuxline.vim: tmux statusline generator with airline integration
Plugin 'edkolev/tmuxline.vim'
" VimOutliner
Plugin 'vimoutliner/vimoutliner'
" CtrlP fuzzy finder
Plugin 'kien/ctrlp.vim'
" Ack.vim search
Plugin 'mileszs/ack.vim'
" Nerdtree tree explorer
Plugin 'scrooloose/nerdtree'
" Nerdtree git-plugin for git status flags
Plugin 'Xuyuanp/nerdtree-git-plugin'
" surround.vim for easily editing brackets, quotes, tags, etc.
Plugin 'tpope/vim-surround'
" commentary.vim adds commenting action
Plugin 'tpope/vim-commentary'
" Repeating supported plugin maps like vim-surround and vim-commentary
Plugin 'tpope/vim-repeat'
" Vim Markdown Syntax highlighting, matching rules, ...
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
" Colorscheme solarized
Plugin 'altercation/vim-colors-solarized'
" Colorscheme base16
Plugin 'chriskempson/base16-vim'
" Language pack for vim
Plugin 'sheerun/vim-polyglot'
" Code completion engine
Plugin 'Valloric/YoucompleteMe'
" Fugitive git wrapper
Plugin 'tpope/vim-fugitive'
" Git-gutter shows diffs on each line
Plugin 'airblade/vim-gitgutter'
" delimitMate auto-completion for quotes, parens, brackets, etc.
Plugin 'Raimondi/delimitMate'
" obsession.vim: continuously updated session files
Plugin 'tpope/vim-obsession'
" ale: Asynchronous Lint Engine
Plugin 'w0rp/ale'
" vim-isort: sort python imports using isort
Plugin 'fisadev/vim-isort'
" indentLine: display the indention levels with thin vertical lines
Plugin 'Yggdroot/indentLine'
" Nerd commenter: comment function
Plugin 'scrooloose/nerdcommenter'


" All of your Plugins must be added before the following line
call vundle#end()            " required for Vundle
" Enable file type detection and do language-dependent indenting.
filetype plugin indent on    " required for Vundle
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" A minimal vimrc for new vim users to start with.
"
" Referenced here: http://vimuniversity.com/samples/your-first-vimrc-should-be-nearly-empty
"
" Original Author:	     Bram Moolenaar <Bram@vim.org>
" Made more minimal by:  Ben Orenstein
" Modified by :          Ben McCormick
" Last change:	         2014 June 8
"
" To use it, copy it to
"  for Unix based systems (including OSX and Linux):  ~/.vimrc
"  for Windows :  $VIM\_vimrc
"
"  If you don't understand a setting in here, just type ':h setting'.

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Switch syntax highlighting on
syntax on

" Show line numbers
set number

" Allow hidden buffers, don't limit to 1 file per window/split
set hidden

" By default Vim saves your last 8 commands.
set history=100

" Insert space characters whenever tab is pressed and  # of spaces to be inserted
" when tab is pressed or when indended
set expandtab tabstop=2 shiftwidth=2

nnoremap <C-J> <C-W><C-J> "Ctrl-j to move down a split
nnoremap <C-K> <C-W><C-K> "Ctrl-k to move up a split
nnoremap <C-L> <C-W><C-L> "Ctrl-l to move right a split
nnoremap <C-H> <C-W><C-H> "Ctrl-h to move left a split

set cursorline              " have a line indicate the cursor location"

set showcmd                 " show pressed command in the button right corner

" airline
" activate powerline fonts
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" unicode symbols
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
"
" " airline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ''

" Always display the statusline in all windows
set laststatus=2
" Always display the tabline, even if there is only one tab
set showtabline=2
" Hide the default mode text (e.g. -- INSERT -- below the statusline
set noshowmode
" Automatically display all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1

" Optionally set straigt tmux powerline separators
let g:tmuxline_powerline_separators = 0

" Keybindings
" leader key is \ by default
"
" reload vim configuruation file
map <leader>rr :source ~/.vimrc<CR>
" airline end

"CtrlP
"Change the default mapping and the default command to invoke CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
"CtrlP end

"NERDtree
"Chagge the default mapping
map <C-n> :NERDTreeToggle<CR>
"NERDtree end

"NERDtree git-plugin
"TOFIX: Config custom symbols
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
 "NERDtree git-plugin end

"Color Theme Solarized
syntax enable
set background=dark  "Alternative: light
colorscheme solarized
call togglebg#map("<F5>")  "Change background
"Theme Solarized end

"Color Theme base16
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
colorscheme base16-default-dark
"End Color Theme base16

" NERD Commenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" end NERD Commenter
