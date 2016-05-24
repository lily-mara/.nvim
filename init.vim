"Plugins {{{
call plug#begin('~/.nvim/plugged')

Plug 'benekastah/neomake'
Plug 'airblade/vim-gitgutter'
Plug 'natemara/vim-monokai'
Plug 'wting/rust.vim'
Plug 'osyo-manga/vim-over'
Plug 'scrooloose/nerdcommenter'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'editorconfig/editorconfig-vim'
Plug 'kien/ctrlp.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'Rip-Rip/clang_complete', { 'do': 'make && nvim clang_complete.vmb -c ''so %'' -c ''q''' }
Plug 'davidhalter/jedi-vim'
Plug 'lambdatoast/elm.vim'
Plug 'treycordova/rustpeg.vim'
Plug 'fatih/vim-go'
Plug 'zchee/deoplete-go'
Plug 'majutsushi/tagbar'
Plug 'natemara/schwift.vim'
Plug 'racer-rust/vim-racer'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'

call plug#end()
"}}}

"Leader key {{{
let mapleader=" "
nnoremap <SPACE> <Nop>
"}}}

"Basic settings {{{
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
set undolevels=1000
set backspace=indent,eol,start
set listchars=eol:¬,tab:\ \ ,trail:·
syntax on
filetype plugin on
filetype indent on
color monokai
set backupcopy=yes
"}}}

"unmap bad keys {{{
nnoremap <UP> <NOP>
nnoremap <DOWN> <NOP>
nnoremap <LEFT> <NOP>
nnoremap <RIGHT> <NOP>

vnoremap <UP> <NOP>
vnoremap <DOWN> <NOP>
vnoremap <LEFT> <NOP>
vnoremap <RIGHT> <NOP>

nnoremap <ESC> <NOP>
vnoremap <ESC> <NOP>
"}}}

"Ultisnips settings {{{
let g:UltiSnipsExpandTrigger = "<tab>"
"}}}

"Deoplete {{{
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#show_call_signatures = 0
let g:deoplete#enable_at_startup = 1
let g:clang_library_path = '/usr/lib/llvm-3.6/lib/libclang.so.1'
let g:racer_cmd = "racer"
"}}}

"Mappings {{{
"---Editing nvimrc
nnoremap <leader>u :e $MYVIMRC<CR>
nnoremap <leader>r :source  $MYVIMRC<CR>

"---General editing
nnoremap <leader><leader> V
vnoremap <leader><leader> V
nnoremap <leader>i :set list!<CR>
nnoremap <leader>k :bd<CR>
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
inoremap <c-c> <ESC>
vnoremap <c-c> <ESC>
nnoremap ' :OverCommandLine<CR>
"}}}

"File manipulation {{{
nnoremap <leader>w :w<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>e :CtrlP<CR>
nnoremap <leader>k :bdelete<CR>
nnoremap <leader>t :CtrlPTag<CR>
nnoremap <leader>k :bdelete<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <leader>q <C-w>c
set clipboard=unnamed,unnamedplus
"}}}

"Vim Fugitive mappings {{{
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gg :Gcommit<CR>
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gb :Gblame<CR>
"}}}

"Use Ag (the silver searcher) as the search command if it is present, else use
"the default
silent! call system("where ag")
if v:shell_error == 0
	let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
endif

"Neomake settings {{{
let g:neomake_python_flake8alt_maker = {
	\ 'exe': 'flake8',
	\ 'args': ['--ignore=W191,E501'],
	\ 'errorformat': '%f:%l:%c: %m',
	\ }

let g:neomake_python_enabled_makers = ['flake8alt']

let g:neomake_error_sign = {
	\ 'text': '>>',
	\ 'texthl': 'ErrorMsg',
	\ }

hi NeomakeWarning ctermbg=3 ctermfg=0

let g:neomake_warning_sign = {
	\ 'text': '>>',
	\ 'texthl': 'NeomakeWarning',
	\ }

augroup neomake_and_tags_after_save
	autocmd!
	autocmd BufWritePost *.py,*cpp,*hpp,*.c,*.h,*.sh,*.zsh,*.tex,*.js Neomake
	autocmd BufWritePost *.rs Neomake! cargo
	autocmd BufWritePost *.py,*.cpp,*.c,*.h,*.asm silent! call jobstart(['ctags', '-R', '--exclude=build'])
	autocmd BufWritePost *.rs silent! call jobstart(['rusty-tags', 'vi'])
augroup END
"}}}

"Filetype specific settings {{{
augroup nate_filetypes
	autocmd!
	autocmd FileType python setlocal noexpandtab
	autocmd FileType python setlocal tabstop=4
	autocmd FileType python setlocal shiftwidth=4
	autocmd FileType python setlocal omnifunc=jedi#completions

	autocmd FileType rst setlocal expandtab
	autocmd FileType rst setlocal tabstop=2
	autocmd FileType rst setlocal shiftwidth=2

	autocmd FileType yaml setlocal expandtab
	autocmd FileType yaml setlocal tabstop=2
	autocmd FileType yaml setlocal shiftwidth=2

	"autocmd FileType html,htmldjango setlocal expandtab
	autocmd FileType python setlocal tabstop=4
	autocmd FileType python setlocal shiftwidth=4

	autocmd FileType rust setlocal tags=rusty-tags.vi
	autocmd FileType rust setlocal hidden

	autocmd BufNewFile,BufRead *.md set filetype=markdown
	au BufNewFile,BufRead *.y set filetype=schwift

	autocmd FileType go nmap <Leader>gr <Plug>(go-rename)
	autocmd FileType go nmap <Leader>gi <Plug>(go-info)
	autocmd FileType go nmap <Leader>gs <Plug>(go-implements)
	autocmd FileType go nmap <Leader>gd <Plug>(go-doc)

	autocmd BufNewFile,BufRead *.md set filetype=markdown
	autocmd BufNewFile,BufRead *.pl set filetype=prolog
	autocmd BufNewFile,BufRead *.h set filetype=c

	autocmd FileType vim setlocal foldmethod=marker
augroup END

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
"}}}

"Strip trailing whitespace {{{
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
"}}}

"CtrlP Settings {{{
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

if has("unix")
	set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/.git/*,*/build/*
else
	set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*\\.git\\*,*\\build\\*
endif

let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/]\.(git|hg|svn)$',
	\ 'file': '\v\.(exe|so|dll|out)$',
	\ }
"}}}

"Persistent undo! Pure money. {{{
if exists("&undodir")
	set undofile
	let &undodir=&directory
	set undolevels=500
	set undoreload=500
endif
"}}}
