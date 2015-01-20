call plug#begin('~/.nvim/plugged')

Plug 'natemara/neomake'
Plug 'airblade/vim-gitgutter'
Plug 'natemara/vim-monokai'
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
Plug 'wting/rust.vim'

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
let g:neomake_cargo_maker = neomake#makers#rust#cargo()

let g:neomake_python_pep8alt_maker = {
	\ 'exe': 'pep8',
	\ 'args': ['--ignore=W191'],
	\ 'errorformat': '%f:%l:%c: %m',
	\ }

let g:neomake_python_enabled_makers = ['pep8alt', 'pylint']

let g:neomake_error_sign = {
	\ 'text': '>>',
	\ 'texthl': 'ErrorMsg',
	\ }

hi NeomakeWarning ctermbg=3 ctermfg=0

let g:neomake_warning_sign = {
	\ 'text': '>>',
	\ 'texthl': 'NeomakeWarning',
	\ }

augroup neomake_after_save
	autocmd!
	autocmd BufWritePost *.py,*cpp,*hpp,*.c,*.h,*.sh,*.zsh,*.rs Neomake
augroup END

"Filetype specific settings
augroup python_files
	autocmd!
	autocmd FileType python setlocal noexpandtab
	autocmd FileType python setlocal tabstop=4
	autocmd FileType python setlocal shiftwidth=4
augroup END

augroup markdown_filetype_plugin
	autocmd!
	autocmd BufNewFile,BufRead *.md set filetype=markdown
augroup END

"Strip trailing whitespace
function! StripTrailingWhitespaces()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfunction

augroup trailing_whitespace
	autocmd!
	autocmd BufWritePre * :call StripTrailingWhitespaces()
augroup END
