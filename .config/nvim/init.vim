" ==============================================================================
" nvim-plug configuration and installed Plugins
" ==============================================================================

" Install vim-plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')

""" Completion
Plug 'ncm2/ncm2'            " NCM2 (Neovim completion Manager)
Plug 'roxma/nvim-yarp'      " Plugin Framework for Neovim, required for NCM2
" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
Plug 'ncm2/ncm2-bufword'    " Words from current buffer for completion
Plug 'ncm2/ncm2-path'       " Path Completion for Ncm2
Plug 'ncm2/ncm2-jedi'       " Python completion for ncm2
Plug 'ncm2/ncm2-tern',  {'do': 'npm install'}   " Javascript completion for ncm2.

""" Editing
Plug 'sheerun/vim-polyglot' " Collection of language packs
Plug 'tpope/vim-commentary' " Comment stuff out
Plug 'tpope/vim-surround'   " Insert or delete brackets, parens, quotes in pairs

""" Formatting and Linting
Plug 'dense-analysis/ale'                   " ALE (asynchronous lint engine)
Plug 'fisadev/vim-isort'                    " Sort python imports using isort
" Plug 'psf/black', {'branch': 'stable'}    " use black in vim
Plug 'sbdchd/neoformat'                     " auto-formatting

""" Git Integration
Plug 'airblade/vim-gitgutter'   " shows diffs on each line
Plug 'rhysd/git-messenger.vim'  " reveals the commit messages under the cursor
Plug 'tpope/vim-fugitive'       " git wrapper, e.g. :GBlame

""" Interface / Looks
Plug 'chriskempson/base16-vim'      " base16 colorscheme
Plug 'itchyny/lightline.vim'        " statusline/tabline
Plug 'lilydjwg/colorizer'           " highlight hexadecimal values in color
Plug 'mgee/lightline-bufferline'    " For tabs on top
" semantic highlighting for Python in Neovim
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
" Plug 'ryanoasis/vim-devicons'       " Adds icons to plugins (install later)
Plug 'Yggdroot/indentLine'          " Display indention w. vertical lines
Plug 'Xuyuanp/nerdtree-git-plugin'  " git status flags in NERDTree

""" Navigation
Plug 'christoomey/vim-tmux-navigator'   " Navigate in tmux panes & vim splits
Plug 'davidhalter/jedi-vim'             " Code jump (go-to) plugin
Plug 'edkolev/tmuxline.vim'             " tmux statusline generator
Plug 'preservim/nerdtree'               " NERDTree tree explorer
Plug 'tmhedberg/SimpylFold'             " Code folding

""" Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'  " Ack.vim search

call plug#end()


" ==============================================================================
" nvim configuration
" ==============================================================================

""" Providers
" Configure Python 2 & 3 provider (own virtualenv)
let g:python_host_prog = '~/.pyenv/versions/py2nvim/bin/python'
let g:python3_host_prog = '~/.pyenv/versions/py3nvim/bin/python'
" Configure NodeJS provider
let g:node_host_prog = '~/.nvm/versions/node/v15.4.0/bin/neovim-node-host'

""" Backup
" Automatically keep a copy of past versions

" create required directories if necessary
if !isdirectory($HOME . "/.config/nvim/backup")
    call mkdir($HOME . "/.config/nvim/backup", "p", 0700)
endif

set backup                          "Turn on backup option
set backupdir=~/.config/nvim/backup " Where to store backups
set writebackup                     "Make backup before overwriting the current buffer
set backupcopy=yes                  "Overwrite the original backup file
"Meaningful backup name, ex: filename@2015-04-05.14:59
au BufWritePre * let &bex = '@' . strftime("%F.%H:%M")

""" Display
set cursorline          " Have a line indicate the cursor location
set colorcolumn=80,90   " Show verticle bar after 80 and 90 chars
set lazyredraw          " Don't redraw screen while executing macros
set number              " Show line numbers
set scrolloff=5	        " Show a few lines around cursor
set wildignore=~,.o,.bak,.exe,.obj,.py[co],.svn,.swp    " Ignore extensions


""" Keybindings and Abbreviations

" leader key is \ by default
let mapleader = ","

" Ctrl-j to move down a split
nnoremap <C-J> <C-W><C-J>
" Ctrl-k to move up a split
nnoremap <C-K> <C-W><C-K>
" Ctrl-l to move right a split
nnoremap <C-L> <C-W><C-L>
" jtrl-h to move left a split
nnoremap <C-H> <C-W><C-H>

" Run Black on save
nnoremap <leader>b :Black<CR> <bar> :w<CRr

" Set abbreviation for rb
" :ab pdb import pdb; pdb.set_trace()
au filetype python :iabbrev ipdb import ipdb;ipdb.set_trace()
au filetype python :iabbrev pdb import pdb;pdb.set_trace()


""" Navigation
set clipboard+=unnamedplus      " Always use the clipboard for all operations
set mouse=a                     " enable mouse in all modes
set wildmode=longest:full,list  " Show full list on command line completion

""" Search
set ignorecase  " Search is case insensitive
set hlsearch    " Highlight matches to the search
set smartcase   " Search case sensitive if caps on
set wrapscan    " Begin search from top of file when nothing is found anymore

""" Spaces & Tabs
set expandtab     " Insert space characters whenever tab is pressed
set list
set list listchars=tab:→·,trail:·,eol:¬,extends:⇉,precedes:⇇
set shiftwidth=4  " # of spaces to use fore each step of (auto)indent
set tabstop=4     " # of spaces to be inserted when tab is pressed

""" Misc
set directory^=$HOME/.vim/tmp// " Organize swap files
set nomodeline                  " security vulnerabiliy to enable
set spelllang=en_us             " set spellcheck


" ==============================================================================
" ack.vim
" ==============================================================================

" Don't jump to the first result automatically
cnoreabbrev Ack Ack!


" ==============================================================================
" black
" ==============================================================================
"
" let g:black_linelength = 90
" use ' and "
" let g:black_skip_string_normalization = 1
" let g:black_virtualenv = '~/.pyenv/versions/3.6.3/envs/black'
" run Black on save
" autocmd BufWritePre *.py execute ':Black'
"
"
"" ==============================================================================
" Color Theme base16
" ==============================================================================

" Update vim colorscheme in sync with base16-shell
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif


" ==============================================================================
" fzf
" ==============================================================================

nnoremap <C-p> :Files<ENTER>
if has('nvim')
  aug fzf_setup
    au!
    au TermOpen term://*FZF tnoremap <silent> <buffer><nowait> <esc> <c-c>
  aug END
end

" ==============================================================================
" jedi-vim
" ==============================================================================
" disable autocompletion, because we use deoplete for completion
let g:jedi#completions_enabled = 0

" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"


" ==============================================================================
" lightline
" ==============================================================================

" choose colorscheme
let g:lightline = {'colorscheme': 'wombat'}

" activate when devicons are working
" let g:lightline#bufferline#enable_devicons = 1

" show abbreviated path of filename
" let g:lightline = {
"   \ 'component_function': {
"     \ 'filename': 'LightlineFilename',
"   \ },
" \ }
" function! LightlineFilename()
"   return expand('%:t') ==# '' ? '[No Name]' : pathshorten(fnamemodify(expand('%'), ":."))
" endfunction


" ==============================================================================
" NCM2
" ==============================================================================

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" wrap existing omnifunc
" Note that omnifunc does not run in background and may probably block the
" editor. If you don't want to be blocked by omnifunc too often, you could
" add 180ms delay before the omni wrapper:
"  'on_complete': ['ncm2#on_complete#delay', 180,
"               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
au User Ncm2Plugin call ncm2#register_source({
\ 'name' : 'css',
\ 'priority': 9,
\ 'subscope_enable': 1,
\ 'scope': ['css','scss'],
\ 'mark': 'css',
\ 'word_pattern': '[\w\-]+',
\ 'complete_pattern': ':\s*',
\ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
\ })


"==============================================================================
" Neoformat
" ==============================================================================
"
" Enable alignment
let g:neoformat_basic_format_align = 1

" Enable tab to space conversion
let g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1


" ==============================================================================
" NERDTree
" ==============================================================================

map <C-n> :NERDTreeToggle<CR>  " Change the default mapping

" Filter out files by extension
let NERDTreeIgnore = ['\.pyc$', 'htmlcov', '__pycache__', '\.orig$']

"
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


