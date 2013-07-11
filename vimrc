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
autocmd BufWritePost *.cpp,*.h,*.c,*.py,*.js,*.cl call UPDATE_TAGS()

source $VIMRUNTIME/menu.vim

set backupdir=$HOME/.vimf/backup,.
set directory=$HOME/.vimf/swap,.
set fileencodings=ucs-bom,utf-8,gbk,gb2312,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set undodir=~/.vimf/undodir
set undofile
set undolevels=1000
set undoreload=10000 
set updatetime=4000
set tags=tags;/
set grepprg=grep\ -nH\ $*
set iskeyword+=:
set wildmenu
set cpo-=<
set wcm=<C-Z>
map <F4> :emenu <C-Z>
au BufRead,BufNewFile * let b:start_time=localtime()
set completeopt=longest,menu,menuone,preview,longest
set viminfo='10,\"100,:20,%,n~/.viminfo

set smartindent

let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_CompileRule_pdf='xelatex --shell-escape --interaction=nonstopmode $*'

set ofu=syntaxcomplete#Complete
let g:neocomplcache_enable_auto_select = 0

let g:miniBufExplMapCTabSwitchBufs=0

let g:tex_flavor='latex'

let g:session_autosave = 'no'

let g:clang_use_library=1
let g:clang_complete_auto=1
let g:clang_hl_errors=1
let g:clang_periodic_quickfix=1
nmap <leader>uq :call g:ClangUpdateQuickFix()<CR>

let g:gardener_light_comments=1
let g:gardener_blank=1
set background=dark
if v:progname =~? "gvim"
	colors lucius
endif

if $TERM =~? "256color"
	colorscheme gardener
else
	colorscheme default
endif

nmap F :call Mydict()<CR>


map <silent> <C-N> :let @/=""<CR>
map <F2> :!/usr/bin/ctags -R --fields=+lKiSz --c-kinds=+cdefgmnpstuvx --c++-kinds=+cdefgmnpstuvx --extra=+q .<CR>
nnoremap <F7> "+p
nmap <C-\> :!sdcv "<cword>" <C-R>=expand("<cword>")<CR><CR>
imap <C-\> <C-o>:!sdcv "<cword>" <C-R>=expand("<cword>")<CR><CR>

"set t_Co=256
"set t_AB=[48;5;%dm jump
"set t_AF=[38;5;%dm
"let &t_SI="\<Esc>]50;CursorShape=1\x7"
"let &t_EI="\<Esc>]50;CursorShape=0\x7"

"au CursorHoldI * call UpdateFile()
"au CursorHold * call UpdateFile()
"au BufWritePost * call delete(expand("%:p").'.bkup')
" Turn on omni-completion for the appropriate file types.
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
"autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1  " Rails support
autocmd FileType java setlocal noexpandtab " do not expand tabs to spaces for Java


runtime ftplugin/man.vim
nnoremap <silent> <F8> :TlistToggle<CR>
noremap  <buffer> <silent> <Up>   gk
noremap  <buffer> <silent> <Down> gj
noremap  <buffer> <silent> <Home> g<Home>
noremap  <buffer> <silent> <End>  g<End>


" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()
inoremap <expr><space>  pumvisible() ? neocomplcache#close_popup() . "\<SPACE>" : "\<SPACE>"
inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"


" Recommended key-mappings.
" <CR>: close popup and save indent.
"inoremap <expr><CR>  neocomplcache#smart_close_popup()
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

inoremap <F6> <c-g>u<esc>:call zencoding#expandAbbr(0)<cr>a


"List Char
set list!
set listchars=tab:>-,trail:-,extends:>


