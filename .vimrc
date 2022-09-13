" File type detection
filetype plugin indent on

" Colours and syntax highlighting options
syntax on

if !has('nvim')
  source ~/.vim/plugins.vim

  colorscheme xcodedark
  " colorscheme molokai
  " colorscheme monokai-pro
  " colorscheme sonokai
else
  source ~/.vim/plugins-nvim.vim

  " colorscheme xcodedark
  colorscheme princess_theme
endif

set t_Co=256
set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum
set termguicolors
set background=dark

" Set leaders
let mapleader = ","

let maplocalleader = "\\"

" Local dirs
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undodir=~/.vim/undo
" Do I really need swap/backup/undo?
set noswapfile
set nobackup
set nowritebackup

" Indentation
set autoindent " Copy indent from last line when starting new line.
set softtabstop=2 " Tab key results in 2 spaces
set tabstop=2
set shiftwidth=2 " The # of spaces for indenting.
set shiftround " Round to that shiftwidth
set expandtab " Expand tabs to spaces
set smarttab " At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces.

" Folding
set nofoldenable " Start not folded
set foldcolumn=0 " Column to show folds
set foldlevel=20
set foldlevelstart=20 " Sets `foldlevel` when editing a new buffer
set foldmethod=syntax " Markers are used to specify folds.
set foldminlines=0 " Allow folding single lines
set foldnestmax=3 " Set max fold nesting level

" Quickfix Window Auto-open
augroup nested_window_auto_open
  autocmd!
  autocmd QuickFixCmdPost [^l]* nested cwindow 5
  autocmd QuickFixCmdPost    l* nested lwindow 5
augroup END
" Quickfix Window Close (,qq)
noremap <leader>qq :cclose<CR>

" Set some junk
set backspace=indent,eol,start
set cursorline " Highlight current line
set diffopt=filler " Add vertical spaces to keep right and left aligned
set diffopt+=iwhite " Ignore whitespace changes (focus on code changes)
set diffopt+=vertical " Vertical splits for diff
set encoding=utf-8 nobomb " BOM often causes trouble
set formatoptions=
set formatoptions+=c " Format comments
set formatoptions+=r " Continue comments by default
" set formatoptions+=o " Make comment when using o or O from comment line
set formatoptions+=q " Format comments with gq
set formatoptions+=n " Recognize numbered lists
set formatoptions+=2 " Use indent from 2nd line of a paragraph
set formatoptions+=l " Don't break lines that are already long
set formatoptions+=1 " Break before 1-letter words
set formatoptions+=t " Auto-wrapping
set completeopt=menu,menuone,noselect
set hidden " Allow unsaved changes on hidden buffers
set history=1000 " Increase history from 20 default to 1000
set hlsearch " Highlight searches
set ignorecase " Ignore case of searches.
set incsearch " Highlight dynamically as pattern is typed.
set cmdheight=1 " Just enough
set laststatus=2 " Always show status line
set lispwords+=defroutes " Compojure
set lispwords+=defpartial,defpage " Noir core
set lispwords+=defaction,deffilter,defview,defsection " Ciste core
set lispwords+=describe,it " Speclj TDD/BDD
set magic " Enable extended regexes.
set mouse=a " Enable mouse in all modes.
set noerrorbells " Disable error bells.
set nojoinspaces " Only insert single space after a '.', '?' and '!' with a join command.
set nostartofline " Don't reset cursor to start of line when moving around.
set nowrap " Do not wrap lines.
set nu " Enable line numbers.
set rnu " Make em relative
set ofu=syntaxcomplete#Complete " Set omni-completion method.
set report=0 " Show all changes.
set ruler " Show the cursor position
set scrolloff=10 " Start scrolling ten lines before horizontal border of window.
set shortmess=atIcO " Don't show the intro message when starting vim.
set noshowmode " Don't show the current mode, it's in our statusline.
set showcmd " A little useful
set showtabline=2 " Always show tab bar.
set sidescrolloff=10 " Start scrolling three columns before vertical border of window.
set sidescroll=1 " Scroll 1 col at a time
set smartcase " Ignore 'ignorecase' if search patter contains uppercase characters.
set splitbelow " New window goes below
set splitright " New windows goes right
set title " Show the filename in the window titlebar.
set ttyfast " Send more characters at a given time.
set undofile " Persistent Undo.
set updatetime=250 " For faster response to file cursor changes
set visualbell " Use visual bell instead of audible bell (annnnnoying)
set wildchar=<TAB> " Character for CLI expansion (TAB-completion).
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js,.DS_Store
set wildmenu " Hitting TAB in command mode will show possible completions above command line.
set wildmode=longest:full,full " Complete only until point of ambiguity.
set winminheight=0 "Allow splits to be reduced to a single line.
set wrapscan " Searches wrap around end of file
set signcolumn=yes

set clipboard=unnamed " Share clipboard

" ==============================================================================
" Custom scripts and shit
" ==============================================================================

" Auto read, and auto-actually-update file changes
set autoread
augroup auto_read
  autocmd!
  autocmd FocusGained,BufEnter * :silent! !
augroup END

" Easier split switching (Ctrl-j, Ctrl-k, Ctrl-h, Ctrl-l)
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" Quick alternate buffer switching (,,)
noremap <leader>, <C-^>

" Toggle show tabs and trailing spaces (,c)
set nolist
set lcs=tab:›\ ,trail:-,nbsp:·,space:·,extends:…,precedes:…,eol:↵

nnoremap <silent> <leader>c :set nolist!<CR>

" Strip trailing whitespace (,ss)
function! StripWhitespace ()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
noremap <silent> <leader>ss :call StripWhitespace ()<CR>

" Restore cursor position
augroup cursor_restore
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
augroup END

" Auto-open Quickfix window
augroup open_quickfix_window
  autocmd!
  autocmd QuickFixCmdPost * nested cwindow 5
augroup END

" Set relative line numbers in netrw
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro rnu'

" dot.env
augroup dotenv
  autocmd!
  autocmd BufNewFile,BufReadPost .env.* setfiletype sh
augroup END

" Files specifically with tabs
augroup files_with_tabs
  autocmd!
  autocmd BufNewFile,BufRead *.snippets setl noexpandtab
  autocmd BufNewFile,BufRead *.gitconfig setl noexpandtab
augroup END

" The number of times this has got me!
com! W w
com! Q q

" Tidy up them buffesr
com! Bd :up | %bd | e#

" Quickly edit me
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Map Y to act like D and C, Yank til EOL
noremap Y y$

" Home motion toggle
" http://ddrscott.github.io/blog/2016/vim-toggle-movement/
function! ToggleMovement(firstOp, thenOp)
  let pos = getpos('.')
  execute "normal! " . a:firstOp
  if pos == getpos('.')
    execute "normal! " . a:thenOp
  endif
endfunction
nnoremap <silent> 0 :call ToggleMovement('^', '0')<CR>

" Center the view if n/N moves out of view
function! s:nice_next(cmd)
  let view = winsaveview()
  execute "normal! " . a:cmd
  if view.topline != winsaveview().topline
    normal! zz
  endif
endfunction

nnoremap <silent> n :call <SID>nice_next('n')<cr>
nnoremap <silent> N :call <SID>nice_next('N')<cr>

" recalculate when idle, and after saving
augroup statline_trail
  autocmd!
  autocmd cursorhold,bufwritepost * unlet! b:statline_trailing_space_warning
augroup END

" Move selected block up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" When changing, don't put in clipboard
nnoremap c "_c
vnoremap c "_c

" HTML/JSON Formatting
com! FormatJSON %!python3 -m json.tool
com! FormatHTML %!tidy -iq -xml -wrap 0

" New file templates
autocmd BufNewFile *.sh 0r ~/.vim/skeletons/bash.sh

" Fill chars colors
set fillchars+=vert:┃,fold:-,diff:╱,foldclose:,foldopen:

source ~/.vim/plugins-config.vim

if has('nvim')
  source ~/.vim/init.vim
endif

" Custom theme adjustments

" Cursor styles
set gcr=a:block
set gcr+=o:hor50-Cursor
set gcr+=n:Cursor
set gcr+=i-ci-sm:InsertCursor-hor10
set gcr+=r-cr:ReplaceCursor-hor20
set gcr+=c:CommandCursor-hor10
set gcr+=v-ve:VisualCursor
set gcr+=a:blinkon0
