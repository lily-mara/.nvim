call plug#begin('~/.nvim/plugged')

Plug 'benekastah/neomake'
Plug 'airblade/vim-gitgutter'
Plug 'natemara/vim-monokai'
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'

call plug#end()

"Leader key
let mapleader=" "
nnoremap <SPACE> <Nop>

"Basic settings
set number
set linebreak
set textwidth=80
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
set listchars=eol:¬,tab:\ \ ,trail:·
syntax on
filetype plugin on
filetype indent on

"Mappings
"----Editing nvimrc
nnoremap <leader>e :e~/.nvim/nvimrc<CR>
nnoremap <leader>r :source ~/.nvim/nvimrc<CR>

"----General editing
nnoremap <leader><leader> V
vnoremap <leader><leader> V
nnoremap <leader>i :set list!<CR>
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
inoremap <C-c> <ESC>
vnoremap <C-c> <ESC>

"----File manipulation
nnoremap <leader>w :w<CR>
nnoremap <leader>b :bNext<CR>
nnoremap <leader>k :bdelete<CR>
nnoremap <leader>k :bdelete<CR>
nnoremap <leader>q <C-w>c

"Vim Fugitive mappings
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gg :Gwrite<CR>:Gcommit<CR>
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gb :Gblame<CR>

color monokai

"Neomake settings
let g:neomake_python_pep8alt_maker = {
	\ 'exe': 'pep8',
	\ 'args': ['--ignore=W191'],
	\ 'errorformat': '%f:%l:%c: %m',
	\ }

let g:neomake_python_enabled_makers = ['pep8alt', 'pylint']

augroup neomake
	autocmd!
	autocmd BufWritePost *.py Neomake
augroup END

"Filetype specific settings
augroup python_files
	autocmd!
	autocmd FileType python setlocal noexpandtab
	autocmd FileType python set tabstop=4
	autocmd FileType python set shiftwidth=4
augroup END
