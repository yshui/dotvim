function! UPDATE_TAGS()
	let _f_=expand("%:p")
	let _cmd_='ctags -a -f ./tags --fields=+lKiSz --c-kinds=cdefgmnpstuvx --c++-kinds=cdefgmnpstuvx --extra=+q  ' . '"' . _f_ . '"'
	let _resp=system(_cmd_)
	unlet _cmd_
	unlet _f_
	unlet _resp
endfunction
call pathogen#infect()

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
set completeopt=longest,menu,menuone,preview,longest
set viminfo='10,\"100,:20,%,n~/.viminfo
"au FileType c,cpp,vim let w:mcc=matchadd('ColorColumn', '\%81v', 100)

set smartindent

let g:dutyl_neverAddClosingParen=1
let g:dutyl_stdImportPaths=['/usr/include/dlang/dmd']
let g:airline_powerline_fonts = 1
let g:neomake_error_sign = {
    \ 'text': 'E>',
    \ 'texthl': 'YcmErrorSection',
    \ }
let g:neomake_warning_sign = {
    \ 'text': 'W>',
    \ 'texthl': 'YcmWarningSection',
    \ }
let g:airline_theme = "wombat"
let delimitMate_expand_cr = 1

let g:sudoAuth = "sudo"
let g:sudo_no_gui = 1

let g:lucius_use_bold=1

let g:ycm_global_ycm_extra_conf = "~/.ycm.py"

let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:syntastic_always_populate_loc_list=1

let g:languagetool_jar = "$HOME/.vim/bundle/languagetool/languagetool/languagetool-commandline.jar"

let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_CompileRule_pdf='xelatex --shell-escape --interaction=nonstopmode $*'


set ofu=syntaxcomplete#Complete

"let g:neocomplcache_enable_auto_select = 0
"let g:neocomplcache_enable_smart_case = 1

let g:miniBufExplMapCTabSwitchBufs=0

let g:tex_flavor='latex'

let g:session_autosave = 'no'

let g:notmuch_folders = [
	\ [ 'new', 'tag:inbox and tag:unread' ],
	\ [ 'inbox', 'tag:inbox' ],
	\ [ 'important', 'tag:Important'],
\ ]

let g:notmuch_folders_count_threads = 1

let g:neomake_python_enabled_makers = ['pylint', 'python']
let g:syntastic_python_python_exec = '/usr/bin/python'
"let g:syntastic_python_checkers=['python', 'py3kwarn']

"let g:clang_use_library=1
"let g:clang_complete_auto=1
"let g:clang_hl_errors=1
"let g:clang_periodic_quickfix=1
nmap <leader>uq :call g:ClangUpdateQuickFix()<CR>

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

"set t_Co=256
"set t_AB=[48;5;%dm jump
"set t_AF=[38;5;%dm
"let &t_SI="\<Esc>]50;CursorShape=1\x7"
"let &t_EI="\<Esc>]50;CursorShape=0\x7"

"au CursorHoldI * call UpdateFile()
"au CursorHold * call UpdateFile()
"au BufWritePost * call delete(expand("%:p").'.bkup')
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


"List Char
set list!
set listchars=tab:>-,trail:-,extends:>

nnoremap y :YcmDiags
nnoremap pg :YcmCompleter GoToDefinitionElseDeclaration
nnoremap pd :YcmCompleter GoToDefinition
nnoremap pc :YcmCompleter GoToDeclaration


nnoremap ; :
