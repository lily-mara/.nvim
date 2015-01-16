call plug#begin('~/.nvim/plugged')

Plug 'benekastah/neomake'

let mapleader=" "
nnoremap <SPACE> <Nop>

set number
set linebreak
set textwidth=100
set showmatch
set visualbell
set smartcase
set ignorecase
set incsearch
set shiftwidth=4
set tabstop=4
set ruler
set autochdir
set undolevels=1000
set backspace=indent,eol,start
set listchars=eol:¬,tab:\|\|,trail:·
syntax on
filetype plugin on
filetype indent on

nnoremap <leader>e :e~/_vimrc<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>r :source ~/.nvim/nvimrc<CR>
nnoremap <leader>b :bNext<CR>
nnoremap <leader>k :bdelete<CR>
nnoremap <leader>k :bdelete<CR>
nnoremap <leader>i :set list!<CR>
nnoremap <leader><leader> V
vnoremap <leader><leader> V
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

color peachpuff
