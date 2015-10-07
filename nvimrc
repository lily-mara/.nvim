"Plugins {{{
call plug#begin('~/.nvim/plugged')

Plug 'benekastah/neomake'
Plug 'airblade/vim-gitgutter'
Plug 'natemara/vim-monokai'
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
Plug 'wting/rust.vim'
Plug 'osyo-manga/vim-over'
Plug 'scrooloose/nerdcommenter'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'

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
set autochdir
set undolevels=1000
set backspace=indent,eol,start
set listchars=eol:¬,tab:\ \ ,trail:·
syntax on
filetype plugin on
filetype indent on
color monokai
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
function! g:UltiSnips_Complete()
	call UltiSnips#ExpandSnippet()
	if g:ulti_expand_res == 0
		if pumvisible()
			return "\<C-n>"
		else
			call UltiSnips#JumpForwards()
			if g:ulti_jump_forwards_res == 0
				return "\<TAB>"
			endif
		endif
	endif
	return ""
endfunction

augroup ultisnips_complete_group
	autocmd!
	autocmd BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
augroup END

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
"}}}

"Mappings {{{
"---Editing nvimrc
nnoremap <leader>u :e $MYVIMRC<CR>
nnoremap <leader>r :source  $MYVIMRC<CR>

"---General editing
nnoremap <leader><leader> V
vnoremap <leader><leader> V
nnoremap <leader>i :set list!<CR>
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
inoremap <c-c> <ESC>
vnoremap <c-c> <ESC>
"}}}

"File manipulation {{{
nnoremap <leader>w :w<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>e :FZFR<CR>
nnoremap <leader>k :bdelete<CR>

nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

nnoremap <leader>q <C-w>c
"}}}

"Vim Fugitive mappings {{{
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gg :Gcommit<CR>
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gb :Gblame<CR>
"}}}

"Neomake settings {{{
let g:neomake_python_flake8alt_maker = {
	\ 'exe': 'flake8',
	\ 'args': ['--ignore=W191'],
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

augroup neomake_after_save
	autocmd!
	autocmd BufWritePost *.py,*cpp,*hpp,*.c,*.h,*.sh,*.zsh,*.tex,*.js Neomake
	autocmd BufWritePost *.rs Neomake! cargo
augroup END

augroup ctags_generation
	autocmd!
	autocmd BufWritePost *.py,*.cpp,*.c,*.h,*.asm silent! call jobstart(['ctags', '-R'])
augroup END
"}}}

"Filetype specific settings {{{
augroup python_files
	autocmd!
	autocmd FileType python setlocal noexpandtab
	autocmd FileType python setlocal tabstop=4
	autocmd FileType python setlocal shiftwidth=4
augroup END

augroup yaml_files
	autocmd!
	autocmd FileType yaml setlocal expandtab
	autocmd FileType yaml setlocal tabstop=2
	autocmd FileType yaml setlocal shiftwidth=2
augroup END

augroup html_files
	autocmd!
	"autocmd FileType html,htmldjango setlocal expandtab
	autocmd FileType python setlocal tabstop=4
	autocmd FileType python setlocal shiftwidth=4
augroup END

augroup markdown_filetype_plugin
	autocmd!
	autocmd BufNewFile,BufRead *.md set filetype=markdown
augroup END

augroup c_header_filetype_plugin
	autocmd!
	autocmd BufNewFile,BufRead *.h set filetype=c
augroup END

augroup vim_foldmethod
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END
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

"FZF Settings {{{
function! s:files_browse(dir)
	let dir = substitute(a:dir, '[^-/\\!@#$%^&*()_+=\[\]\{\}a-zA-Z0-9]', '', 'g')
	execute 'Files' dir
endfunction


function! s:find_root()
	let dir = system("git rev-parse --show-toplevel")
	if v:shell_error == 0
		call s:files_browse(dir)
		return
	endif

	let dir = system("svn info . |grep -F 'Working Copy Root Path:' | cut -d: -f2 | cut -d' ' -f2")
	if v:shell_error == 0
		call s:files_browse(dir)
		return
	endif

	for vcs in ['.hg']
		let dir = finddir(vcs.'/..', ';')
		if !empty(dir)
			call s:files_browse(dir)
			return
		endif
	endfor

	Files
endfunction

command! FZFR call s:find_root()
"}}}

"CtrlP Settings {{{
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

"Use Ag (the silver searcher) as the search command if it is present, else use
"the default
silent! call system("where ag")
if v:shell_error == 0
	let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
endif

if has("unix")
	set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/.git/*     " MacOSX/Linux
else
	set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*\\.git\\*  " Windows
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
