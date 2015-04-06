let g:windows_os = has("win32") || has("win16") || has("win8")

" Load vim-plug
if !g:windows_os && empty(glob("~/.vim/autoload/plug.vim"))
    execute '!mkdir -p ~/.vim/autoload'
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'bling/vim-bufferline'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-abolish'
"Plug 'mileszs/ack.vim'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'kien/ctrlp.vim', {'on': 'CtrlP'}
Plug 'tpope/vim-dispatch'
Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'mattn/gist-vim', {'on': 'Gist'}
Plug 'sjl/gundo.vim', {'on': 'GundoToggle'}
Plug 'michaeljsmith/vim-indent-object'
Plug 'edsono/vim-matchit'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'scrooloose/syntastic'
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'tpope/vim-repeat'
Plug 'garbas/vim-snipmate'
Plug 'ervandew/supertab'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-unimpaired'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'honza/vim-snippets'
Plug 'bronson/vim-trailing-whitespace'
"Plug 'thinca/vim-visualstar'
Plug 'mattn/webapi-vim'
Plug 'itspriddle/ZoomWin'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Raimondi/delimitMate'

Plug 'sheerun/vim-polyglot'
Plug 'ecomba/vim-ruby-refactoring', {'for': 'ruby'}
if !g:windows_os
  Plug 'rorymckinley/vim-rubyhash', {'for': 'ruby'}
endif
Plug 'tpope/vim-rails'
Plug 'skalnik/vim-vroom'
Plug 'chrisbra/csv.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'tpope/vim-ragtag'
" Included in vim-polyglot
"Plug 'ap/vim-css-color'
"Plug 'tpope/vim-git'
"Plug 'tpope/vim-haml'
"Plug 'pangloss/vim-javascript'
"Plug 'elzr/vim-json'
"Plug 'kchmck/vim-coffee-script'
"Plug 'tpope/vim-liquid'
"Plug 'tpope/vim-markdown'
"Plug 'vim-ruby/vim-ruby'
"Plug 'skwp/vim-rspec'
"Plug 'depuracao/vim-rdoc'

Plug 'chriskempson/base16-vim'

call plug#end()

set nocompatible
let mapleader = " "

nore ; :
nore \ ;
inore jk <Esc>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Wrapped line treated as normal line
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$

" Need more context
set scrolloff=2
set nonumber
set relativenumber

" Enable mouse support
set mouse=a

set textwidth=80

set cc=+1

map <Leader>p :CtrlP<CR>

set wmh=0 " no current line on minimized windows
nore <silent> <C-K> :wincmd k<CR>
nore <silent> <C-J> :wincmd j<CR>
nore <silent> <C-H> :wincmd h<CR>
nore <silent> <C-L> :wincmd l<CR>

set splitbelow
set splitright

""
"" Basic Setup
""

set nocompatible " Use vim, no vi defaults
set ruler " Show line and column number
syntax enable " Turn on syntax highlighting allowing local overrides
set encoding=utf-8 " Set default encoding to UTF-8

""
"" Whitespace
""

set nowrap " don't wrap lines
set tabstop=2 " a tab is two spaces
set shiftwidth=2 " an autoindent (with <<) is two spaces
set expandtab " use spaces, not tabs
set list " Show invisible characters
set backspace=indent,eol,start " backspace through everything in insert mode

" List chars
set listchars="" " Reset the listchars
set listchars=tab:\ \ " a tab should display as " ", trailing whitespace as "."
set listchars+=trail:. " show trailing spaces as dots
set listchars+=extends:> " The character to show in the last column when wrap is
			 " off and the line continues beyond the right of the screen
set listchars+=precedes:< " The character to show in the last column when wrap is
			  " off and the line continues beyond the left of the screen


""
"" Searching
""
set hlsearch " highlight matches
set incsearch " incremental searching
set ignorecase " searches are case insensitive...
set smartcase " ... unless they contain at least one capital letter

""
"" Wild settings
""

" TODO: Investigate the precise meaning of these settings
" set wildmode=list:longest,list:full

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" Ignore librarian-chef, vagrant, test-kitchen and Berkshelf cache
set wildignore+=*/tmp/librarian/*,*/.vagrant/*,*/.kitchen/*,*/vendor/cookbooks/*

" Ignore rails temporary asset caches
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*

" Disable temp and backup files
set wildignore+=*.swp,*~,._*

""
"" Backup and swap files
""

set backupdir^=~/.vim/_backup// " where to put backup files.
set directory^=~/.vim/_temp// " where to put swap files.

if has("statusline") && !&cp
	set laststatus=2 " always show the status bar
	" Start the status line
	set statusline=%f\ %m\ %r
	set statusline+=Line:%l/%L[%p%%]
	set statusline+=Col:%v
	set statusline+=Buf:#%n
	set statusline+=[%b][0x%B]
endif



if has("autocmd")
	if exists("g:autosave_on_blur")
		au FocusLost * silent! wall
	endif
endif

if has("autocmd")
	" In Makefiles, use real tabs, not tabs expanded to spaces
	au FileType make setlocal noexpandtab

	" Make sure all mardown files have the correct filetype set and setup wrapping
	au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown
	if !exists("g:disable_markdown_autostyle")
		au FileType markdown setlocal wrap linebreak textwidth=72 nolist
	endif

	" make Python follow PEP8 for whitespace ( http://www.python.org/dev/peps/pep-0008/ )
	au FileType python setlocal tabstop=4 shiftwidth=4

	" Remember last location in file, but not for commit messages.
	" see :help last-position-jump
	au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
				\| exe "normal! g`\"" | endif
endif

""
"" General Mappings (Normal, Visual, Operator-pending)
""

" Toggle paste mode
nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>

" format the entire file
nnoremap <leader>fef :normal! gg=G``<CR>

" upper/lower word
nmap <leader>u mQviwU`Q
nmap <leader>l mQviwu`Q

" upper/lower first char of word
nmap <leader>U mQgewvU`Q
nmap <leader>L mQgewvu`Q

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>

" Create the directory containing the file in the buffer
nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

" Some helpers to edit mode
" http://vimcasts.org/e/14
nmap <leader>ew :e <C-R>=expand('%:h').'/'<cr>
nmap <leader>es :sp <C-R>=expand('%:h').'/'<cr>
nmap <leader>ev :vsp <C-R>=expand('%:h').'/'<cr>
nmap <leader>et :tabe <C-R>=expand('%:h').'/'<cr>

" Swap two words
nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'

" Underline the current line with '='
nmap <silent> <leader>ul :t.<CR>Vr=

" set text wrapping toggles
nmap <silent> <leader>tw :set invwrap<CR>:set wrap?<CR>

" find merge conflict markers
nmap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" Map the arrow keys to be based on display lines, not physical lines
map <Down> gj
map <Up> gk

" Toggle hlsearch with <leader>hs
nmap <leader>hs :set hlsearch! hlsearch?<CR>

" Adjust viewports to the same size
map <Leader>= <C-w>=


""
"" Command-Line Mappings
""

" After whitespace, insert the current directory into a command-line path
cnoremap <expr> <C-P> getcmdline()[getcmdpos()-2] ==# ' ' ? expand('%:p:h') : "\<C-P>"


""
"" Plugin settings
""

" prevents delimitMate from loading for md
au FileType markdown let b:loaded_delimitMate = 1

" ack setting {
" Define <C-F> to a dummy value to see if it would set <C-f> as well.
map <C-F> :dummy
if maparg("<C-f>") == ":dummy"
" <leader>f on systems where <C-f> == <C-F>
map <leader>f :Ack<space>
else
" <C-F> if we can still map <C-f> to <S-Down>
map <C-F> :Ack<space>
endif
map <C-f> <S-Down>
" }

" ctrlp setting {
let g:ctrlp_map = ''
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\',
    \ }
" }

" git fugitive {
nmap <leader>gb :Gblame<CR>
nmap <leader>gs :Gstatus<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gl :Glog<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gp :Git push<CR>
" }

" gist {
if executable("pbcopy")
" The copy command
let g:gist_clip_command = 'pbcopy'
elseif executable("xclip")
" The copy command
let g:gist_clip_command = 'xclip -selection clipboard'
elseif executable("putclip")
" The copy command
let g:gist_clip_command = 'putclip'
end

" detect filetype if vim failed auto-detection.
let g:gist_detect_filetype = 1
" }

" gundo {
nmap <F5> :GundoToggle<CR>
imap <F5> <ESC>:GundoToggle<CR>
" }

" NEARDcommenter {
 map <leader>/ <plug>NERDCommenterToggle<CR>
" }

" NEARDTree {
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\.rbc$', '\.rbo$', '\.class$', '\.o$', '\~$']

" Default mapping, <leader>n
map <leader>n :NERDTreeToggle<CR> :NERDTreeMirror<CR>

augroup AuNERDTreeCmd
autocmd AuNERDTreeCmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))
autocmd AuNERDTreeCmd FocusGained * call s:UpdateNERDTree()

" If the parameter is a directory, cd into it
function s:CdIfDirectory(directory)
let explicitDirectory = isdirectory(a:directory)
let directory = explicitDirectory || empty(a:directory)

if explicitDirectory
  exe "cd " . fnameescape(a:directory)
endif

" Allows reading from stdin
" ex: git diff | mvim -R -
if strlen(a:directory) == 0
  return
endif

if directory
  NERDTree
  wincmd p
  bd
endif

if explicitDirectory
  wincmd p
endif
endfunction

" NERDTree utility function
function s:UpdateNERDTree(...)
let stay = 0

if(exists("a:1"))
  let stay = a:1
end

if exists("t:NERDTreeBufName")
  let nr = bufwinnr(t:NERDTreeBufName)
  if nr != -1
    exe nr . "wincmd w"
    exe substitute(mapcheck("R"), "<CR>", "", "")
    if !stay
      wincmd p
    end
  endif
endif
endfunction
" }

" syntastic {
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
" }

" Tagbar mappings.
map <Leader>rc :TagbarToggle<CR>

" unimpaired {
" Normal Mode: Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e

" Visual Mode: Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv
" }

" Map <Leader><Leader> to ZoomWin
map <leader>zw :ZoomWin<CR>

" Lightline setting {
let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'readonly' ], ['ctrlpmark', 'bufferline'] ],
    \   'right': [ ['lineinfo'], ['percent'], [ 'fileformat', 'fileencoding', 'filetype', 'syntastic' ] ]
    \ },
    \ 'component_function': {
    \   'fugitive': 'MyFugitive',
    \   'readonly': 'MyReadonly',
    \   'bufferline': 'MyBufferline',
    \   'fileformat': 'MyFileformat',
    \   'filetype': 'MyFiletype',
    \   'fileencoding': 'MyFileencoding',
    \   'mode': 'MyMode',
    \   'ctrlpmark': 'CtrlPMark',
    \ },
    \ 'component_expand': {
    \   'syntastic': 'SyntasticStatuslineFlag',
    \ },
    \ 'component_type': {
    \   'syntastic': 'middle',
    \ },
    \ 'subseparator': { 'left': '|', 'right': '|' }
    \ }

let g:lightline.mode_map = {
    \ 'n' : ' N ',
    \ 'i' : ' I ',
    \ 'R' : ' R ',
    \ 'v' : ' V ',
    \ 'V' : 'V-L',
    \ 'c' : ' C ',
    \ "\<C-v>" : 'V-B',
    \ 's' : ' S ',
    \ 'S' : 'S-L',
    \ "\<C-s>" : 'S-B',
    \ '?' : ' ' }

function! MyModified()
return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! MyFilename()
let fname = expand('%:t')
return fname == 'ControlP' ? g:lightline.ctrlp_item :
      \ fname == '__Tagbar__' ? g:lightline.fname :
      \ fname =~ '__Gundo\|NERD_tree' ? '' :
      \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
      \ &ft == 'unite' ? unite#get_status_string() :
      \ &ft == 'vimshell' ? vimshell#get_status_string() :
      \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
      \ ('' != fname ? fname : '[No Name]') .
      \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
try
  if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
    let mark = ''  " edit here for cool mark
    let _ = fugitive#head()
    return strlen(_) ? mark._ : ''
  endif
catch
endtry
return ''
endfunction

function! MyFileformat()
return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
let fname = expand('%:t')
return fname == '__Tagbar__' ? 'Tagbar' :
      \ fname == 'ControlP' ? 'CtrlP' :
      \ fname == '__Gundo__' ? 'Gundo' :
      \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
      \ fname =~ 'NERD_tree' ? 'NERDTree' :
      \ &ft == 'unite' ? 'Unite' :
      \ &ft == 'vimfiler' ? 'VimFiler' :
      \ &ft == 'vimshell' ? 'VimShell' :
      \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
if expand('%:t') =~ 'ControlP'
  call lightline#link('iR'[g:lightline.ctrlp_regex])
  return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
        \ , g:lightline.ctrlp_next], 0)
else
  return ''
endif
endfunction

function! MyBufferline()
call bufferline#refresh_status()
let b = g:bufferline_status_info.before
let c = g:bufferline_status_info.current
let a = g:bufferline_status_info.after
let alen = strlen(a)
let blen = strlen(b)
let clen = strlen(c)
let w = winwidth(0) * 4 / 11
if w < alen+blen+clen
  let whalf = (w - strlen(c)) / 2
  let aa = alen > whalf && blen > whalf ? a[:whalf] : alen + blen < w - clen || alen < whalf ? a : a[:(w - clen - blen)]
  let bb = alen > whalf && blen > whalf ? b[-(whalf):] : alen + blen < w - clen || blen < whalf ? b : b[-(w - clen - alen):]
  return (strlen(bb) < strlen(b) ? '...' : '') . bb . c . aa . (strlen(aa) < strlen(a) ? '...' : '')
else
  return b . c . a
endif
endfunction

let g:ctrlp_status_func = {
    \ 'main': 'CtrlPStatusFunc_1',
    \ 'prog': 'CtrlPStatusFunc_2',
    \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
let g:lightline.ctrlp_regex = a:regex
let g:lightline.ctrlp_prev = a:prev
let g:lightline.ctrlp_item = a:item
let g:lightline.ctrlp_next = a:next
return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
let g:lightline.fname = a:fname
return lightline#statusline(0)
endfunction

augroup AutoSyntastic
autocmd!
autocmd BufWritePost *.c,*.cpp,*.rb,*.py call s:syntastic()
augroup END
function! s:syntastic()
SyntasticCheck
call lightline#update()
endfunction

"Changing background color on the fly
augroup LightLineColorScheme
  autocmd!
  autocmd ColorScheme * call s:lightline_update()
augroup END
function! s:lightline_update()
  if !exists('g:loaded_lightline')
    return
  endif
  try
    if g:colors_name =~# 'wombat\|solarized\|landscape\|jellybeans\|Tomorrow'
      let g:lightline.colorscheme =
            \ substitute(substitute(g:colors_name, '-', '_', 'g'), '256.*', '', '') .
            \ (g:colors_name ==# 'solarized' ? '_' . &background : '')
      call lightline#init()
      call lightline#colorscheme()
      call lightline#update()
    endif
  catch
  endtry
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0
"}

let base16colorspace=256
color base16-brewer
set background=dark
