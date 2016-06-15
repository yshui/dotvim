"{{{ Utility functions
function! UPDATE_TAGS() "{{{
	let _f_=expand("%:p")
	let _cmd_='ctags -a -f ./tags --fields=+lKiSz --c-kinds=cdefgmnpstuvx --c++-kinds=cdefgmnpstuvx --extra=+q  ' . '"' . _f_ . '"'
	let _resp=system(_cmd_)
	unlet _cmd_
	unlet _f_
	unlet _resp
endfunction "}}}

function! s:is_whitespace() "{{{
	let col = col('.') - 1
	return ! col || getline('.')[col - 1] =~? '\s'
endfunction "}}}

function! s:dein_clear_unused() "{{{
	return map(dein#check_clean(), "delete(v:val, 'rf')")
endfunction "}}}

command DeinClear call s:dein_clear_unused()
"}}}

"{{{ Dein.vim plugins
set runtimepath^=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim/

call dein#begin(expand('~/.config/nvim/dein/'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/neosnippet.vim')
call dein#add('othree/html5.vim')
call dein#add('tpope/vim-surround')
call dein#add('chrisbra/SudoEdit.vim')
call dein#add('pangloss/vim-javascript')
call dein#add('scrooloose/nerdcommenter')
call dein#add('scrooloose/nerdtree')
call dein#add('mattn/emmet-vim')
call dein#add('plasticboy/vim-markdown')
call dein#add('jiangmiao/auto-pairs')
call dein#add('Matt-Deacalion/vim-systemd-syntax')
call dein#add('neomake/neomake')
call dein#add('idanarye/vim-dutyl')
call dein#add('leafgarland/typescript-vim')
call dein#add('nhooyr/neoman.vim')
call dein#add('junegunn/fzf', {'merged':0})
call dein#add('junegunn/fzf.vim')
call dein#add('kien/ctrlp.vim')
call dein#add('yshui/deoplete-d', {'depends' : ['deoplete.nvim']})
call dein#add('vim-scripts/Lucius')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes', {'depends' : ['vim-airline']})
call dein#add('bling/vim-bufferline')
call dein#add('ternjs/tern_for_vim', { 'build': 'npm install' })
call dein#add('carlitux/deoplete-ternjs', {'depends': ['deoplete.nvim', 'tern_for_vim']})
call dein#add('zchee/deoplete-clang', {'depends' : ['deoplete.nvim']})
call dein#add('majutsushi/tagbar')

call dein#end()

if dein#check_install()
  call dein#install()
endif
"}}}


source $VIMRUNTIME/menu.vim

"{{{ Basic vim configurations
"Return to the last edit position
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
set mouse=a
syntax enable

set hlsearch
set backup
set backupdir=$HOME/.vimf/backup,.
set directory=$HOME/.vimf/swap,.
set fileencodings=ucs-bom,utf-8,gbk,gb2312,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set undodir=~/.vimf/undodir
set undofile
set undolevels=1000
set undoreload=10000
set updatetime=4000
set tags=tags;/
set backspace=2
set grepprg=grep\ -nH\ $*
set iskeyword+=:
set wildmenu
set cpo-=<
set wcm=<C-Z>
set laststatus=2
set clipboard=unnamedplus
map <F4> :emenu <C-Z>
au BufRead,BufNewFile * let b:start_time=localtime()
set completeopt=menu,menuone,preview
set shada=!,'150,<100,/50,:50,r/tmp,s256
"au FileType c,cpp,vim let w:mcc=matchadd('ColorColumn', '\%81v', 100)

set smartindent
set ofu=syntaxcomplete#Complete
"List Char
set list!
set listchars=tab:>-,trail:-,extends:>
set viewoptions-=options

"Color Scheme
let g:gardener_light_comments=1
let g:gardener_blank=1
let g:lucius_use_bold=1
set background=dark
if v:progname =~? "gvim"
	colors lucius
else
	if $TERM =~? "256color"
		colorscheme gardener
	else
		colorscheme default
	endif
endif

filetype plugin on
filetype plugin indent on
autocmd BufWritePost *.cpp,*.h,*.c,*.py,*.js,*.cl call UPDATE_TAGS()
autocmd! BufWritePost * Neomake
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent! loadview
"}}}

"{{{ Plugin configurations
"{{{ AutoPairs
let g:AutoPairsMapCR = 0
"}}}

"{{{ deoplete.vim
let g:deoplete#enable_at_startup = 1

let g:deoplete#enable_smart_case = 1

let g:deoplete#sources#clang#libclang_path = "/usr/lib/libclang.so"
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang/3.8.0/include'

let g:deoplete#omni#input_patterns = get(g:,'deoplete#omni#input_patterns',{})
let g:deoplete#omni#input_patterns.d = [
	\'\.\w*',
	\'\w*\('
\]

let g:deoplete#omni#functions = get(g:,'deoplete#omni#functions',{})
"}}}

"{{{ dutyl
let g:dutyl_neverAddClosingParen=1
let g:dutyl_stdImportPaths=['/usr/include/dlang/dmd']
"}}}

"{{{ airline
let g:airline_powerline_fonts = 1
let g:airline_theme = "wombat"
"}}}

"{{{ neomake
let g:neomake_error_sign = {
    \ 'text': 'E>',
    \ 'texthl': 'YcmErrorSection',
    \ }
let g:neomake_warning_sign = {
    \ 'text': 'W>',
    \ 'texthl': 'YcmWarningSection',
    \ }
"}}}

"{{{ SudoEdit
let g:sudoAuth = "sudo"
let g:sudo_no_gui = 1
"}}}

"{{{ syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_python_python_exec = '/usr/bin/python'
"let g:syntastic_python_checkers=['python', 'py3kwarn']
"}}}

"{{{ LaTeX
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_CompileRule_pdf='xelatex --shell-escape --interaction=nonstopmode $*'
let g:tex_flavor='latex'
"}}}
"{{{ Neomake
let g:neomake_c_gccw_maker = {
   \ 'exe': $HOME."/.config/nvim/cdb_wrapper",
   \ 'args': ['gcc', '-fsyntax-only', '-Wall', '-Wextra'],
   \ 'errorformat':
      \ '%-G%f:%s:,' .
      \ '%f:%l:%c: %trror: %m,' .
      \ '%f:%l:%c: %tarning: %m,' .
      \ '%f:%l:%c: %m,'.
      \ '%f:%l: %trror: %m,'.
      \ '%f:%l: %tarning: %m,'.
      \ '%f:%l: %m',
\ }
let g:neomake_c_clangw_maker = {
   \ 'exe': $HOME."/.config/nvim/cdb_wrapper",
   \ 'args': ['clang', '-fsyntax-only', '-Wall', '-Wextra'],
   \ 'errorformat':
      \ '%-G%f:%s:,' .
      \ '%f:%l:%c: %trror: %m,' .
      \ '%f:%l:%c: %tarning: %m,' .
      \ '%f:%l:%c: %m,'.
      \ '%f:%l: %trror: %m,'.
      \ '%f:%l: %tarning: %m,'.
      \ '%f:%l: %m',
\ }
let g:neomake_c_enabled_makers = ['clangw', 'clangtidy']
"}}}
"}}}

"{{{ FileType configurations
autocmd FileType python set shiftwidth=4
autocmd FileType python set nosmartindent
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1  " Rails support
autocmd FileType java setlocal noexpandtab " do not expand tabs to spaces for Java
autocmd FileType rust setlocal tabstop=8 shiftwidth=8 softtabstop=8 noexpandtab
autocmd FileType xml,html,phtml,php,xhtml,js let b:delimitMate_matchpairs = "(:),[:],{:}"
autocmd FileType markdown set spell spelllang=en_us
"}}}

"{{{ Misc mappings
map <silent> <C-N> :let @/=""<CR>
map <F2> :!/usr/bin/ctags -R --fields=+lKiSz --c-kinds=+cdefgmnpstuvx --c++-kinds=+cdefgmnpstuvx --extra=+q .<CR>
imap <C-n> <esc>nli

inoremap <silent> <F8> <C-\><C-O>:TagbarToggle<CR>
nnoremap <silent> <F8> :TagbarToggle<CR>
noremap  <buffer> <silent> <Up>   gk
noremap  <buffer> <silent> <Down> gj
noremap  <buffer> <silent> <Home> g<Home>
noremap  <buffer> <silent> <End>  g<End>
nnoremap <space> :

cnoreabbrev Man Snman
"}}}

"inoremap <expr><C-g>     neocomplcache#undo_completion()
"inoremap <expr><C-l>     neocomplcache#complete_common_string()

inoremap <F6> <c-g>u<esc>:call zencoding#expandAbbr(0)<cr>a


"{{{ deoplete.vim related mappings
imap <expr><CR>  pumvisible() ?
\ (neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" : deoplete#mappings#close_popup()."\<CR>") :
\ "\<CR>\<Plug>AutoPairsReturn"

inoremap <expr><C-h>
\ deoplete#mappings#smart_close_popup()."\<C-h>"

inoremap <expr><BS>
\ deoplete#mappings#smart_close_popup()."\<C-h>"

imap <expr><TAB> pumvisible() ? "\<C-n>" :
\ neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)" :
\ <SID>is_whitespace() ? "\<TAB>" : deoplete#mappings#manual_complete()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-Tab>"

smap <expr><TAB> neosnippet#jumpable() ?
\ "\<Plug>(neosnippet_jump)"
\: "\<TAB>"
"}}}

"List Char
set list!
set listchars=tab:>-,trail:-,extends:>

nnoremap y :YcmDiags
nnoremap pg :YcmCompleter GoToDefinitionElseDeclaration
nnoremap pd :YcmCompleter GoToDefinition
nnoremap pc :YcmCompleter GoToDeclaration


nnoremap ; :

cnoreabbrev Man Snman
" vim: foldmethod=marker
