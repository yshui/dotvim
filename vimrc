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
autocmd BufWritePost *.cpp,*.h,*.c,*.py,*.js call UPDATE_TAGS()
source $VIMRUNTIME/menu.vim
set backupdir=/home/shui/.vimf/backup,.
set directory=/home/shui/.vimf/swap,.
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

set smartindent

let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_CompileRule_pdf='xelatex --interaction=nonstopmode $*'


let OmniCpp_DefaultNamespaces=["std"]
let OmniCpp_GlobalScopeSearch=1 " 0 or 1
let OmniCpp_NamespaceSearch=1 " 0 , 1 or 2
let OmniCpp_DisplayMode=1
let OmniCpp_ShowScopeInAbbr=0
let OmniCpp_ShowPrototypeInAbbr=1
let OmniCpp_ShowAccess=1
let OmniCpp_MayCompleteDot=1
let OmniCpp_MayCompleteArrow=1
let OmniCpp_MayCompleteScope=1
set ofu=syntaxcomplete#Complete

let g:SuperTabDefaultCompletionType='context'
"let g:SuperTabContextDefaultCompletionType="<c-x><c-o>"
let g:SuperTabLongestEnhanced=1
let g:SuperTabLongestHighlight=1

let g:miniBufExplMapCTabSwitchBufs=0

let g:tex_flavor='latex'

let g:gardener_light_comments=1
let g:gardener_blank=1
set background=dark
if v:progname =~? "gvim"
	colors lucius
endif

if $TERM =~? "rxvt"
	colorscheme gardener
else
	colorscheme default
endif


map <silent> <C-N> :let @/=""<CR>
map <F2> :!/usr/bin/ctags -R --fields=+lKiSz --c-kinds=+cdefgmnpstuvx --c++-kinds=+cdefgmnpstuvx --extra=+q .<CR>
nnoremap <F7> "+p
"set t_Co=256
"set t_AB=[48;5;%dm
"set t_AF=[38;5;%dm
"let &t_SI="\<Esc>]50;CursorShape=1\x7"
"let &t_EI="\<Esc>]50;CursorShape=0\x7"

let g:tabular_loaded=1
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
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1  " Rails support
autocmd FileType java setlocal noexpandtab " do not expand tabs to spaces for Java

runtime ftplugin/man.vim
nnoremap <silent> <F8> :TlistToggle<CR>
noremap  <buffer> <silent> <Up>   gk
noremap  <buffer> <silent> <Down> gj
noremap  <buffer> <silent> <Home> g<Home>
noremap  <buffer> <silent> <End>  g<End>
inoremap <buffer> <silent> <Home> <C-o>g<Home>
inoremap <buffer> <silent> <End>  <C-o>g<End>


