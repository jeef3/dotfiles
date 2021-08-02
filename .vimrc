" File type detection
filetype plugin indent on

" Colours and syntax highlighting options
syntax on

source ~/.vim/plugins.vim

set t_Co=256
set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum
set termguicolors
set background=dark

" colorscheme princess
" colorscheme molokai
" colorscheme monokai-pro
" colorscheme sonokai
colorscheme xcodedark

" I just like my comments in italics
highlight Comment cterm=italic

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
set completeopt-=preview
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
set shortmess=atIc " Don't show the intro message when starting vim.
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
set fillchars+=vert:\│

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

set fcs=fold:-
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

" Mode-aware Cursor Highlighting (GUI Only)
set gcr=a:block

set gcr+=o:hor50-Cursor
set gcr+=n:Cursor
set gcr+=i-ci-sm:InsertCursor-hor10
set gcr+=r-cr:ReplaceCursor-hor20
set gcr+=c:CommandCursor
set gcr+=v-ve:VisualCursor
set gcr+=a:blinkon0

hi InsertCursor  ctermfg=15 guifg=#fdf6e3 ctermbg=37  guibg=#2aa198
hi VisualCursor  ctermfg=15 guifg=#fdf6e3 ctermbg=125 guibg=#d33682
hi ReplaceCursor ctermfg=15 guifg=#fdf6e3 ctermbg=65  guibg=#dc322f
hi CommandCursor ctermfg=15 guifg=#fdf6e3 ctermbg=166 guibg=#cb4b16

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
com! FormatJSON %!python -m json.tool
com! FormatHTML %!tidy -iq -xml -wrap 0

" New file templates
autocmd BufNewFile *.sh 0r ~/.vim/skeletons/bash.sh


" ==============================================================================
" Plugin Configuration
" ==============================================================================

" Lightline
source ~/.vim/lightline-xcodedark.vim

let g:lightline = {
      \ "colorscheme": "xcodedark",
      \ "enable": { "tabline": 0 },
      \ "active": {
      \   "left": [ [ "mode", "paste" ],
      \             [ ] ,
      \             [ "readonly", "filename" ] ],
      \   "right": [ [ "coc_errors", "coc_warnings", "coc_ok" ],
      \              [ ],
      \              [ "fileformat", "lineinfo" ] ],
      \ },
      \ "inactive": {
      \   "left": [  [ "filename" ] ],
      \   "right": [ [ ],
      \              [ ],
      \              [ "fileformat", "lineinfo" ] ],
      \ },
      \ "component_function": {
      \   "fileformat": "LightlineFileFormat",
      \   "readonly": "LightlineReadonly",
      \ },
      \ "separator": { "left": "", "right": "" },
      \ "subseparator": { "left": "", "right": "" },
      \ }

let g:lightline#coc#indicator_warnings = " "
let g:lightline#coc#indicator_errors = " "
let g:lightline#coc#indicator_ok = ""

call lightline#coc#register()

function! LightlineFileFormat()
  return winwidth(0) > 70 ? (WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function LightlineReadonly()
  return &ft !~? 'help\|vimfiler' && &readonly ? '' : ''
endfunction

" FIXME: Why does it need to be here instead of up higher?
source ~/.vim/tabline.vim

" UltiSnips
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

" Ag
let g:ag_working_path_mode="r"

" BufExplorer
let g:bufExplorerShowDirectories=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerSplitRight=0

" Terminus
" let g:TerminusInsertCursorShape=2

" Incsearch (Fuzzy)
" map /  <Plug>(incsearch-forward)
" map ?  <Plug>(incsearch-backward)
" map g/ <Plug>(incsearch-stay)

" map z/  <Plug>(incsearch-fuzzy-/)
" map z?  <Plug>(incsearch-fuzzy-?)
" map z/ <Plug>(incsearch-fuzzy-stay)

" Incsearch - noh after motion
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
" map *  <Plug>(incsearch-nohl-*)
" map #  <Plug>(incsearch-nohl-#)
" map g* <Plug>(incsearch-nohl-g*)
" map g# <Plug>(incsearch-nohl-g#)

" fzf
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
noremap <C-t> :Files<cr>
noremap <C-p> :Ag<cr>
" noremap <leader>t :Buffers<cr>

let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" CSS completion
augroup css
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci
augroup END

" Markdown
augroup markdown
  autocmd!
  autocmd FileType markdown setlocal wrap lbr conceallevel=2 spell

  " This is almost always what I meant anyway.
  autocmd FileType markdown noremap j gj
  autocmd FileType markdown noremap k gk
  autocmd FileType markdown nnoremap $ g$
augroup END

" GitGutter
let g:gitgutter_sign_added = "\uf457"
let g:gitgutter_sign_modified = "\uf459"
let g:gitgutter_sign_removed = "\uf458"
let g:gitgutter_sign_removed_first_line = "\uf458"
let g:gitgutter_sign_modified_removed = "\uf459"

hi GitGutterAdd           guifg=#a6e22e
hi GitGutterChange        guifg=#fd971f
hi GitGutterDelete        guifg=#f92672
hi GitGutterChangeDelete  guifg=#fd971f

" Coverage
" let g:coverage_interval = 1000
" let g:coverage_json_report_path = 'coverage/coverage-final.json'
" let g:coverage_show_covered = 1

" vim-closetag
let g:closetag_filenames = '*.html'
let g:closetag_xhtml_filenames = '*.html'

" CSS3 Syntax
augroup VimCSS3Syntax
  autocmd!

  autocmd FileType css setlocal iskeyword+=-
augroup END

" COC
let g:coc_snippet_next = '<tab>'

inoremap <silent><expr> <TAB>
	  \ pumvisible() ? coc#_select_confirm() :
	  \ coc#expandableOrJumpable() ?
	  \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
	  \ <SID>check_back_space() ? "\<TAB>" :
	  \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <leader>rn <Plug>(coc-rename)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> <leader>qf :CocFix<CR>
nmap <silent><nowait> <space>s  :<C-u>CocList -A -I symbols<cr>

command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" COC lists using fzf
" nnoremap <silent> <space>s       :<C-u>CocFzfList symbols<CR>

autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" hi! link CocErrorHighlight ErrorMsg
" hi! link CocErrorSign ErrorMsg
hi! CocErrorHighlight guifg=#f92672 gui=undercurl cterm=underline
hi! CocErrorSign guifg=#f92672
nmap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Dart LSC
let g:lsc_auto_map = v:true

" OmniSharp
augroup omnisharp_commands
  autocmd!

  autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> <buffer> K <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> <space>s <Plug>(omnisharp_find_symbol)
augroup END

" vim-matchup
let g:matchup_matchparen_offscreen = {'method': "popup"}
