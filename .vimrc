if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let mapleader = ","
set wildmenu
set wildmode=list:longest,full
set autowriteall
set exrc			" enable per-directory .vimrc files
set secure			" disable unsafe commands in local .vimrc files
set encoding=UTF-8

autocmd FileType html let g:html_indent_strict=1

filetype on  " Automatically detect file types.
set nocompatible
syntax enable
filetype plugin on
filetype plugin indent on

" Specify plugins
call plug#begin('~/.vim/plugged')

" UI {{{3
Plug 'trevordmiller/nova-vim'
Plug 'vim-airline/vim-airline'            " Handy info
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'retorillo/airline-tablemode.vim'
Plug 'junegunn/goyo.vim'
Plug 'ryanoasis/vim-devicons'

" File Navigation {{{3
Plug 'vim-scripts/matchit.zip'            " More powerful % matching
Plug 'Lokaltog/vim-easymotion'            " Move like the wind!
Plug 'jeffkreeftmeijer/vim-numbertoggle'  " Smarter line numbers
Plug 'kshenoy/vim-signature'              " Show marks in the gutter
Plug 'haya14busa/incsearch.vim'           " Better search highlighting
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'

Plug 'arcticicestudio/nord-vim', { 'on':  'NERDTreeToggle' }

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'w0rp/ale'
Plug 'skywind3000/asyncrun.vim'
Plug 'mattn/emmet-vim'

" Python
Plug 'vim-scripts/indentpython.vim'

" Code editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

Plug 'sjl/gundo.vim'
" Initialize plugin system
call plug#end()

" NERDTree ********************************************************************
:noremap <leader>n :NERDTreeToggle<CR>
autocmd vimenter * NERDTree

" Single click for everything
let NERDTreeMouseMode=1

" Scrollbars ******************************************************************
set sidescrolloff=2
set numberwidth=4
set guioptions-=r
set go-=L
" Windows *********************************************************************
set equalalways " Multiple windows, when created, are equal in size
set splitbelow splitright

"Vertical split then hop to new buffer
:noremap <leader>v :vsp^M^W^W<cr>
:noremap <leader>h :split^M^W^W<cr>

" Cursor highlights ***********************************************************
set cursorline
"set cursorcolumn

" Searching *******************************************************************
set hlsearch " highlight search
set incsearch " incremental search, search as you type
set ignorecase " Ignore case when searching
set smartcase " Ignore case when searching lowercase
nmap <silent> <leader>a :Ack <cword><CR>
nmap <silent> <Esc><Esc> :noh<cr>

" Colors **********************************************************************
"set t_Co=256 " 256 colors
syntax on " syntax highlighting

" Status Line *****************************************************************
set showcmd
set ruler " Show ruler
"set ch=2 " Make command line two lines high
set statusline=%<%F%h%m%r%h%w%y\ %{&ff}\ %{strftime(\"%d/%m/%Y-%H:%M\")}\ %{exists('g:loaded_rvm')?rvm#statusline():''}%=\ %l:%c%V\ %L\ %P
set laststatus=2

" Line Wrapping ***************************************************************
set nowrap
set linebreak " Wrap at word

" Sessions ********************************************************************
" Sets what is saved when you save a session
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize

" Misc ************************************************************************
set backspace=indent,eol,start
set number " Show line numbers
set matchpairs+=<:>
set vb t_vb= " Turn off the bell

" Files, backups and undo******************************************************
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile


" CtrlP ************************************************************************
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_match_window = 'top'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard'] " exclude files in .gitignore

set wildignore+=*~,tmp/**,*.svg,*.ttf,*.gif,*.jpg,*.jpeg,*.png,*.eot,*.woff,*.gz 

" Fonts & Color Scheme ************************************************************************

colorscheme nord
set guifont=DroidSansMono\ Nerd\ Font:h12
let g:airline_powerline_fonts = 1

"Gundo configuration

let g:gundo_width = 60
let g:gundo_preview_height = 40
let g:gundo_right = 1
let g:gundo_prefer_python3 = 1

nnoremap <F4> :GundoToggle<CR>

"Save on losing focus

au FocusLost * :wa

" Javascript Linting ************************************************************************
let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
autocmd BufWritePost *.js AsyncRun -post=checktime ./node_modules/.bin/eslint --fix %

let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}


" Soft Tabs ************************************************************************
au BufNewFile, BufRead *.js, *.html, *.css set tabstop=2 
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set expandtab

" Indenting *******************************************************************
set ai " Automatically set the indent of a new line (local to buffer)
set si " smartindent  (local to buffer)

" Python Linting ************************************************************************

au BufNewFile, BufRead *.py 
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
