let g:windows_os = has("win32") || has("win16") || has("win8")

" Load vim-plug
if !g:windows_os && empty(glob("~/.vim/autoload/plug.vim"))
  execute '!mkdir -p ~/.vim/autoload'
  execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')
" Visual
Plug 'bling/vim-bufferline'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'scrooloose/syntastic'

" Browsing
" Plug 'mileszs/ack.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'Yggdroot/indentLine'
Plug 'christoomey/vim-tmux-navigator'
Plug 'itspriddle/ZoomWin'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'jpalardy/vim-slime'
Plug 'kien/ctrlp.vim', {'on': 'CtrlP'}
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'sjl/gundo.vim', {'on': 'GundoToggle'}
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'

" Git
Plug 'mattn/gist-vim', {'on': 'Gist'}
Plug 'tpope/vim-fugitive'

" Edit
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Raimondi/delimitMate'
Plug 'bronson/vim-trailing-whitespace'
Plug 'edsono/vim-matchit'
Plug 'ervandew/supertab'
Plug 'garbas/vim-snipmate'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'michaeljsmith/vim-indent-object'
Plug 'mtth/scratch.vim', {'on': 'Scratch'}
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
if !g:windows_os
  Plug 'hsanson/vim-im'
endif

" Lib
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'honza/vim-snippets'
Plug 'mattn/webapi-vim'
Plug 'tomtom/tlib_vim'

" Lang
Plug 'cakebaker/scss-syntax.vim'
Plug 'chrisbra/csv.vim'
Plug 'ecomba/vim-ruby-refactoring', {'for': 'ruby'}
Plug 'sheerun/vim-polyglot'
Plug 'skalnik/vim-vroom'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rails'
if !g:windows_os
  Plug 'rorymckinley/vim-rubyhash', {'for': 'ruby'}
endif
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

" Colors
Plug 'chriskempson/base16-vim'
Plug 'reedes/vim-colors-pencil'
call plug#end()

let mapleader = " "
set nocompatible " Use vim, no vi defaults
set ruler " Show line and column number
syntax enable " Turn on syntax highlighting allowing local overrides
set encoding=utf-8 " Set default encoding to UTF-8
set nowrap " don't wrap lines
set tabstop=2 " a tab is two spaces
set shiftwidth=2 " an autoindent (with <<) is two spaces
set expandtab " use spaces, not tabs
set list " Show invisible characters
set backspace=indent,eol,start " backspace through everything in insert mode
set listchars="" " Reset the listchars
set listchars=tab:\ \ " a tab should display as " ", trailing whitespace as "."
set listchars+=trail:. " show trailing spaces as dots
set listchars+=extends:> " The character to show in the last column when wrap is off and the line continues beyond the right of the screen
set listchars+=precedes:< " The character to show in the last column when wrap is off and the line continues beyond the left of the screen
set hlsearch " highlight matches
set incsearch " incremental searching
set ignorecase " searches are case insensitive...
set smartcase " ... unless they contain at least one capital letter

set laststatus=2 " always show the status bar
" Need more context
set scrolloff=2
set nonumber
set relativenumber
" Enable mouse support
set mouse=a
set textwidth=80
" color column textwidth+1
set cc=+1
set wmh=0 " no current line on minimized windows
" Natural split
set splitbelow
set splitright

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

" http://stackoverflow.com/a/9528322
" Save your backups to a less annoying place than the current directory.
" If you have .vim-backup in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/_backup or . if all else fails.
if isdirectory($HOME . '/.vim/_backup') == 0
  :silent !mkdir -p ~/.vim/_backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/_backup/
set backupdir^=./.vim-backup/
set backup

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/_temp, ~/tmp or .
if isdirectory($HOME . '/.vim/_temp') == 0
  :silent !mkdir -p ~/.vim/_temp >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/_temp//
set directory+=~/tmp//
set directory+=.

" viminfo stores the the state of your previous editing session
set viminfo+=n~/.vim/viminfo

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/_undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/_undo') == 0
    :silent !mkdir -p ~/.vim/_undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/_undo//
  set undofile
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

" Plugin settings

" Vim-slime
let g:slime_target = "tmux"

" Markdown
let g:markdown_fenced_languages = ['coffee', 'css', 'erb=eruby', 'javascript',
      \ 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'sh']

" prevents delimitMate from loading for md
au FileType markdown let b:loaded_delimitMate = 1

" ctrlp setting {
let g:ctrlp_map = ''
let g:ctrlp_custom_ignore = {
      \ 'dir': '\v[\/]\.(git|hg|svn)$',
      \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\',
      \ }
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

" NEARDTree {
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\.rbc$', '\.rbo$', '\.class$', '\.o$', '\~$']

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

" Ibus - unikey

:command Unikey let g:unikey_auto = 1
:command NoUnikey let g:unikey_auto = 0

function! UnikeyDisable()
  if exists("g:unikey_auto") && g:unikey_auto == 1
    call ibus#python#setEngine("xkb:us::eng")
  endif
endfunction

function! UnikeyEnable()
  if exists("g:unikey_auto") && g:unikey_auto == 1
    call ibus#python#setEngine("Unikey")
  endif
endfunction

autocmd InsertLeave * call UnikeyDisable()
autocmd InsertEnter * call UnikeyEnable()

" sets the arglist to contain each of the files referenced by the quickfix list
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

" DelimitMate
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

" Mapings
" Sane regex
nnoremap / /\v
vnoremap / /\v

" Type <tab> is easier than type %
nnoremap <tab> %
vnoremap <tab> %

" No arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

nore <leader>zw :ZoomWin<CR>

" unimpaired {
" Normal Mode: Bubble single lines
nnore <C-Up> [e
nnore <C-Down> ]e

" Visual Mode: Bubble multiple lines
vnore <C-Up> [egv
vnore <C-Down> ]egv
" }

" Tagbar mappings.
nore <Leader>rc :TagbarToggle<CR>

" NEARDTree
nore <leader>n :NERDTreeToggle<CR> :NERDTreeMirror<CR>

" NEARDcommenter {
nore <leader>/ <plug>NERDCommenterToggle<CR>
" }

" gundo {
nnore <F5> :GundoToggle<CR>
inore <F5> <ESC>:GundoToggle<CR>
" }

" git fugitive {
nnore <leader>gb :Gblame<CR>
nnore <leader>gs :Gstatus<CR>
nnore <leader>gd :Gdiff<CR>
nnore <leader>gl :Glog<CR>
nnore <leader>gc :Gcommit<CR>
nnore <leader>gp :Git push<CR>
" }

nore <Leader>p :CtrlP<CR>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vnore <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nnore ga <Plug>(EasyAlign)

" split join
let g:splitjoin_split_mapping = 'ss'
let g:splitjoin_join_mapping  = 'sj'

" Toggle paste mode
nnore <silent> <F4> :set invpaste<CR>:set paste?<CR>
inore <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>

" format the entire file
nnoremap <leader>fef :normal! gg=G``<CR>

" upper/lower word
nnore <leader>u mQviwU`Q
nnore <leader>l mQviwu`Q

" upper/lower first char of word
nnore <leader>U mQgewvU`Q
nnore <leader>L mQgewvu`Q

" cd to the directory containing the file in the buffer
nnore <silent> <leader>cd :lcd %:h<CR>

" Create the directory containing the file in the buffer
nnore <silent> <leader>md :!mkdir -p %:p:h<CR>

" Some helpers to edit mode
" http://vimcasts.org/e/14
nnore <leader>ew :e <C-R>=expand('%:h').'/'<cr>
nnore <leader>es :sp <C-R>=expand('%:h').'/'<cr>
nnore <leader>ev :vsp <C-R>=expand('%:h').'/'<cr>
nnore <leader>et :tabe <C-R>=expand('%:h').'/'<cr>

" Swap two words
nnore <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'

" Underline the current line with '='
nnore <silent> <leader>ul :t.<CR>Vr=

" set text wrapping toggles
nnore <silent> <leader>tw :set invwrap<CR>:set wrap?<CR>

" find merge conflict markers
nnore <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" Map the arrow keys to be based on display lines, not physical lines
nore <Down> gj
nore <Up> gk

" Toggle hlsearch with <leader>hs
nnore <leader>hs :set hlsearch! hlsearch?<CR>

" Adjust viewports to the same size
nore <Leader>= <C-w>=

" After whitespace, insert the current directory into a command-line path
cnoremap <expr> <C-P> getcmdline()[getcmdpos()-2] ==# ' ' ? expand('%:p:h') : "\<C-P>"

" clear highlight
nnore <leader>hl :noh<CR>
" easy move between windows
nore <silent> <C-K> :wincmd k<CR>
nore <silent> <C-J> :wincmd j<CR>
nore <silent> <C-H> :wincmd h<CR>
nore <silent> <C-L> :wincmd l<CR>
nore ; :
nore \ ;
inore jk <Esc>
inore kj <Esc>
" Wrapped line treated as normal line
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> 0 g0
noremap <silent> $ g$

function! s:goyo_enter()
  if has('gui_running')
    set fullscreen
    colorscheme pencil
    set background=light
    set linespace=7
  elseif exists('$TMUX')
    silent !tmux set status off
  endif
  Limelight
endfunction

function! s:goyo_leave()
  if has('gui_running')
    set nofullscreen
    colorscheme base16-tomorrow
    set background=dark
    set linespace=0
  elseif exists('$TMUX')
    silent !tmux set status on
  endif
  Limelight!
endfunction

autocmd User GoyoEnter nested call <SID>goyo_enter()
autocmd User GoyoLeave nested call <SID>goyo_leave()

let base16colorspace=256
let g:lightline.colorscheme = "Tomorrow_Night"
color base16-tomorrow
set background=dark
