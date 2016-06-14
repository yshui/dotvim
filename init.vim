function! UPDATE_TAGS()
	let _f_=expand("%:p")
	let _cmd_='ctags -a -f ./tags --fields=+lKiSz --c-kinds=cdefgmnpstuvx --c++-kinds=cdefgmnpstuvx --extra=+q  ' . '"' . _f_ . '"'
	let _resp=system(_cmd_)
	unlet _cmd_
	unlet _f_
	unlet _resp
endfunction

set runtimepath^=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim/

call dein#begin(expand('~/.config/nvim/dein/'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/neosnippet.vim')
call dein#add('othree/html5.vim')
call dein#add('alvan/vim-closetag')
call dein#add('tpope/vim-surround')
call dein#add('chrisbra/SudoEdit.vim')
call dein#add('pangloss/vim-javascript')
call dein#add('scrooloose/nerdcommenter')
call dein#add('scrooloose/syntastic')
call dein#add('scrooloose/nerdtree')
call dein#add('mattn/emmet-vim')
call dein#add('plasticboy/vim-markdown')
call dein#add('jiangmiao/auto-pairs')
call dein#add('Matt-Deacalion/vim-systemd-syntax')
call dein#add('neomake/neomake')
call dein#add('idanarye/vim-dutyl')
call dein#add('leafgarland/typescript-vim')
call dein#add('nhooyr/neoman.vim')
call dein#add('vim-scripts/Lucius')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes', {'depends' : ['vim-airline']})
call dein#add('bling/vim-bufferline')
call dein#add('ternjs/tern_for_vim', { 'build': 'npm install' })
call dein#add('carlitux/deoplete-ternjs', {'depends': ['deoplete.nvim', 'tern_for_vim']})
call dein#add('zchee/deoplete-clang', {'depends' : ['deoplete.nvim']})

call dein#end()

if dein#check_install()
  call dein#install()
endif

filetype plugin on
filetype plugin indent on
autocmd BufWritePost *.cpp,*.h,*.c,*.py,*.js,*.cl call UPDATE_TAGS()
autocmd BufWritePost *.py Neomake
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

"autocmd BufRead,BufNewFile *.md set spell spelllang=en_us

source $VIMRUNTIME/menu.vim

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

let g:deoplete#enable_at_startup = 1

let g:dutyl_neverAddClosingParen=1
let g:dutyl_stdImportPaths=['/usr/include/dlang/dmd']

let g:airline_powerline_fonts = 1
let g:airline_theme = "wombat"

let g:neomake_error_sign = {
    \ 'text': 'E>',
    \ 'texthl': 'YcmErrorSection',
    \ }
let g:neomake_warning_sign = {
    \ 'text': 'W>',
    \ 'texthl': 'YcmWarningSection',
    \ }
let delimitMate_expand_cr = 1

let g:sudoAuth = "sudo"
let g:sudo_no_gui = 1

let g:lucius_use_bold=1

let g:ycm_global_ycm_extra_conf = "~/.ycm.py"

let g:syntastic_always_populate_loc_list=1

let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_CompileRule_pdf='xelatex --shell-escape --interaction=nonstopmode $*'


set ofu=syntaxcomplete#Complete

let g:miniBufExplMapCTabSwitchBufs=0

let g:tex_flavor='latex'

let g:session_autosave = 'no'

let g:syntastic_python_python_exec = '/usr/bin/python'
"let g:syntastic_python_checkers=['python', 'py3kwarn']

let g:gardener_light_comments=1
let g:gardener_blank=1
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

nmap F :call Mydict()<CR>


map <silent> <C-N> :let @/=""<CR>
map <F2> :!/usr/bin/ctags -R --fields=+lKiSz --c-kinds=+cdefgmnpstuvx --c++-kinds=+cdefgmnpstuvx --extra=+q .<CR>
nnoremap <F7> "+p
nmap <C-\> :!dict "<cword>" <C-R>=expand("<cword>")<CR><CR>
imap <C-\> <C-o>:!dict "<cword>" <C-R>=expand("<cword>")<CR><CR>

" Turn on omni-completion for the appropriate file types.
"autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python set shiftwidth=4
autocmd FileType python set nosmartindent
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
"autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1  " Rails support
autocmd FileType java setlocal noexpandtab " do not expand tabs to spaces for Java
autocmd FileType rust setlocal tabstop=8 shiftwidth=8 softtabstop=8 noexpandtab
au FileType xml,html,phtml,php,xhtml,js let b:delimitMate_matchpairs = "(:),[:],{:}"
imap <C-n> <esc>nli

runtime ftplugin/man.vim
nnoremap <silent> <F8> :TlistToggle<CR>
noremap  <buffer> <silent> <Up>   gk
noremap  <buffer> <silent> <Down> gj
noremap  <buffer> <silent> <Home> g<Home>
noremap  <buffer> <silent> <End>  g<End>

"inoremap <expr><C-g>     neocomplcache#undo_completion()
"inoremap <expr><C-l>     neocomplcache#complete_common_string()

"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function()
  "return neocomplcache#smart_close_popup() . "\<CR>"
  "" For no inserting <CR> key.
  ""return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
"endfunction

"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplcache#close_popup()
"inoremap <expr><C-e>  neocomplcache#cancel_popup()

"if !exists('g:neocomplcache_omni_patterns')
  "let g:neocomplcache_omni_patterns = {}
"endif
"let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

"if !exists('g:neocomplcache_keyword_patterns')
    "let g:neocomplcache_keyword_patterns = {}
"endif
"let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Recommended key-mappings.
" <CR>: close popup and save indent.
"inoremap <expr><CR>  neocomplcache#smart_close_popup()
" <TAB>: completion.
" <C-h>, <BS>: close popup and delete backword char.

inoremap <F6> <c-g>u<esc>:call zencoding#expandAbbr(0)<cr>a

" Expand snippets on tab if snippets exists, otherwise do autocompletion
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\ : pumvisible() ? "\<C-n>" : "\<TAB>"
" If popup window is visible do autocompletion from back
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Fix for jumping over placeholders for neosnippet
smap <expr><TAB> neosnippet#jumpable() ?
\ "\<Plug>(neosnippet_jump)"
\: "\<TAB>"

"List Char
set list!
set listchars=tab:>-,trail:-,extends:>

nnoremap y :YcmDiags
nnoremap pg :YcmCompleter GoToDefinitionElseDeclaration
nnoremap pd :YcmCompleter GoToDefinition
nnoremap pc :YcmCompleter GoToDeclaration


nnoremap ; :

cnoreabbrev Man Snman
