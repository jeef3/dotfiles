source ~/.vim/plugins.vim

set macligatures

" File type detection
filetype plugin indent on

" Colours and syntax highlighting options
syntax on
set t_Co=256
set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum
set termguicolors
set background=dark
colorscheme princess
let g:molokai_original=1
let g:rehash256 = 1

highlight Comment cterm=italic
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%101v.\+/

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
set expandtab " Expand tabs to spaces
set smarttab " At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces.

" Folding
set nofoldenable
set foldcolumn=1 " Column to show folds
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
set esckeys " Allow cursor keys in insert mode.
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
set gdefault " By default add g flag to search/replace. Add g to toggle.
set hidden " When a buffer is brought to foreground, remember undo history and marks.
set history=1000 " Increase history from 20 default to 1000
set hlsearch " Highlight searches
set ignorecase " Ignore case of searches.
set incsearch " Highlight dynamically as pattern is typed.
set laststatus=2 " Always show status line
set lispwords+=defroutes " Compojure
set lispwords+=defpartial,defpage " Noir core
set lispwords+=defaction,deffilter,defview,defsection " Ciste core
set lispwords+=describe,it " Speclj TDD/BDD
set magic " Enable extended regexes.
set mouse=a " Enable mouse in all modes.
set ttymouse=xterm2 " So mouse can work properly in vmux
set noerrorbells " Disable error bells.
set nojoinspaces " Only insert single space after a '.', '?' and '!' with a join command.
set nostartofline " Don't reset cursor to start of line when moving around.
set nowrap " Do not wrap lines.
set nu " Enable line numbers.
set ofu=syntaxcomplete#Complete " Set omni-completion method.
set report=0 " Show all changes.
set ruler " Show the cursor position
set scrolloff=10 " Start scrolling ten lines before horizontal border of window.
set shortmess=atI " Don't show the intro message when starting vim.
set showmode " Show the current mode.
set showtabline=2 " Always show tab bar.
set sidescrolloff=10 " Start scrolling three columns before vertical border of window.
set sidescroll=1 " Scroll 1 col at a time
set smartcase " Ignore 'ignorecase' if search patter contains uppercase characters.
set splitbelow " New window goes below
set splitright " New windows goes right
set suffixes=.bak,~,.swp,.swo,.o,.d,.info,.aux,.log,.dvi,.pdf,.bin,.bbl,.blg,.brf,.cb,.dmg,.exe,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyd,.dll
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
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l

" Quick alternate buffer switching (,,)
noremap <leader>, <C-^>

" Toggle show tabs and trailing spaces (,c)
set list
set lcs=tab:›\ ,trail:·,nbsp:_,extends:…,precedes:…

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

" Set relative line numbers
set relativenumber " Use relative line numbers. Current line is still in status bar.
augroup relative_line_numbers
  autocmd!
  autocmd BufReadPost,BufNewFile * set relativenumber
augroup END
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

" Applescript
augroup applescript_au
  autocmd!
  autocmd BufNewFile,BufRead *.applescript setf applescript
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

" New file under string
" nnoremap <leader>v :call NewFileAt()<cr>
" function! NewFileAt ()
"   " lcd %:p:h
"   let newFile = expand('<cfile>:p')
"   let currentExtension = expand('%:e')

"   let newFileName = newFile . "." . currentExtension
"   execute "enew"
"   execute "w " . newFileName
" endfunction

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

" Custom Status Line
function! WindowNumber()
  return tabpagewinnr(tabpagenr())
endfunction

function! TrailingSpaceWarning()
  if !exists("b:statline_trailing_space_warning")
    let lineno = search('\s$', 'nw')
    if lineno != 0
      let b:statline_trailing_space_warning = '[trailing:'.lineno.']'
    else
      let b:statline_trailing_space_warning = ''
    endif
  endif
  return b:statline_trailing_space_warning
endfunction

function! ReadOnlyIcon()
  if &readonly
    return " "
  else
    return ""
  endif
endfunction

function! LightLineBufSettings()
    let et = &et ==# 1 ? "•" : "➜"
    return ('│ts│'. &tabstop . '│sw│'. &shiftwidth . '│et│' . et . '│')
endfunction

" recalculate when idle, and after saving
augroup statline_trail
  autocmd!
  autocmd cursorhold,bufwritepost * unlet! b:statline_trailing_space_warning
augroup END

" set statusline=
" set statusline+=%< " Where to truncate line
" set statusline+=\ %f " Path to the file in the buffer, as typed or relative to current directory
" set statusline+=%{&modified?'+':''}
" set statusline+=%{ReadOnlyIcon()}
" set statusline+=\ %1*%= " Separation point between left and right aligned items.
" set statusline+=\ \ %{''!=#&filetype?&filetype:'none'}
" set statusline+=%(\ %{(&bomb\|\|'^$\|utf-8'!~#&fileencoding?'\ '.&fileencoding.(&bomb?'-bom':''):'')
"   \.('unix'!=#&fileformat?'\ '.&fileformat:'')}%)
" " set statusline+=%(\ \ %{&modifiable?(&expandtab?'et\ ':'noet\ ').&shiftwidth:''}%)
" " set statusline+=%(\ \ %{&modifiable?SleuthIndicator():''}%)
" set statusline+=%{LightLineBufSettings()}
" set statusline+=\ %*\ %2v " Virtual column number.
" set statusline+=\ %3p%% " Percentage through file in lines as in |CTRL-G|

" Move selected block up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Ranger
noremap <leader>r :!ranger %:p<cr>

" When changing, don't put in clipboard
nnoremap c "_c
vnoremap c "_c


" ==============================================================================
" Plugin Configuration
" ==============================================================================

" Syntastic
" let g:syntastic_error_symbol = 'x'
" let g:syntastic_warning_symbol = '!'

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_typescript_checkers = []
" let g:syntastic_json_checkers = ['jsonlint']
" let g:syntastic_arduino_checkers = ['avrgcc']
" let g:syntastic_c_checkers = ['gcc']
" let g:syntastic_cpp_checkers = ['gcc']

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_loc_list_height = 3
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" if &diff
"   let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
" endif

" ALE
let g:ale_sign_error = "\uf00d"
let g:ale_sign_warning = "\uf071"
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']

let g:ale_error_format = '•%d'
let g:ale_warning_format = '•%d'

" let g:airline#extensions#ale#enabled = 1
" set statusline+=%#ale_warning#
" set statusline+=%{ALEGetStatusLine()}
" set statusline+=%*

hi ALEErrorSign   guifg=#f92672 guibg=#3b3a32
hi ALEWarningSign guifg=#fd971f guibg=#3b3a32

let g:ale_linters = {
      \   'javascript': ['eslint', 'flow'],
      \}

let g:ale_fix_on_save = 0
let g:ale_fixers = {
      \   'javascript': ['eslint']
      \}
nnoremap ]a :ALENextWrap<cr>
nnoremap [a :ALEPreviousWrap<cr>
nnoremap <leader>af :ALEFix<cr>

" OmniSharp
augroup omnisharp_commands
  autocmd!
  autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
  autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
  autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
  autocmd FileType cs nnoremap <leader>tp :OmniSharpAddToProject<cr>
augroup END

" JSON Formatting
com! FormatJSON %!python -m json.tool

" HTML Formatting
com! FormatHTML %!tidy -iq -xml -wrap 0

" Airline
let g:airline_powerline_fonts = 1
let g:airline_left_sep = "\ue0b8"
let g:airline_left_alt_sep = "\ue0b9"
let g:airline_right_sep = "\ue0be"
let g:airline_right_alt_sep = "\ue0bf"

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#close_symbol = "\uf00d" " A nice fat X
let g:airline#extensions#tabline#show_tab_type = 0

" YouCompleteMe
set completeopt-=preview
let g:ycm_key_list_select_completion=['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion=['<C-k>', '<Up>']
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

if !exists("g:ycm_semantic_triggers")
   let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']
let g:ycm_semantic_triggers['css'] = ['  ', ': ']

augroup ycm_commands
  autocmd!
  autocmd FileType javascript noremap gd :YcmCompleter GoToDefinition<cr>
  autocmd FileType cpp noremap gd :YcmCompleter GoToDefinition<cr>
augroup END

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

" Vimux
noremap <Leader>vp :VimuxPromptCommand<CR>
noremap <Leader>vl :VimuxRunLastCommand<CR>

" Terminus
let g:TerminusInsertCursorShape=2

" TypeScript
let g:tsuquyomi_disable_default_mappings=1
augroup typescript_commands
  autocmd!
  autocmd FileType typescript call s:typescript_filetype_settings()
  autocmd FileType typescript noremap gd :TsuDefinition<cr>
augroup END
function! s:typescript_filetype_settings()
  " set makeprg=tsc
endfunction

" EasyMotion
" FIXME: EasyMotion steals my leader-leader quick switch
" map <Leader> <Plug>(easymotion-prefix)
" map  <Leader>f <Plug>(easymotion-bd-f)
" nmap <Leader>f <Plug>(easymotion-overwin-f)

" Incsearch (Fuzzy)
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

map z/  <Plug>(incsearch-fuzzy-/)
map z?  <Plug>(incsearch-fuzzy-?)
map z/ <Plug>(incsearch-fuzzy-stay)

" Incsearch - noh after motion
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" fzf
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
noremap <C-t> :Files<cr>
noremap <C-p> :Ag<cr>
noremap <leader>t :Buffers<cr>

" JSX
let g:jsx_ext_required = 0

augroup jsx_helpers
  autocmd!
  autocmd FileType javascript nnoremap <leader>ja :call JSXEncloseReturn()<CR>
  autocmd FileType javascript nnoremap <leader>ji :call JSXEachAttributeInLine()<CR>
  autocmd FileType javascript nnoremap <leader>ve :call JSXExtractPartialPrompt()<CR>
  autocmd FileType javascript nnoremap <leader>jc :call JSXChangeTagPrompt()<CR>
  autocmd FileType javascript nnoremap vat :call JSXSelectTag()<CR>
augroup END

" CSS completion
augroup css
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci
augroup END

" Goyo
augroup goyo_commands
  autocmd!
  nnoremap <leader>go :Goyo<CR>

  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()
augroup END

function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  " set noshowcmd
  set wrap
  set linebreak
  set scrolloff=999
  Limelight
  " ...
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  " set showcmd
  set nowrap
  set nolinebreak
  set scrolloff=10
  Limelight!
  " ...
endfunction

" Arduino
let g:vim_arduino_ino_cmd = 'ano'
let g:vim_arduino_auto_open_serial = 1

" Markdown
augroup markdown
  autocmd!
  autocmd FileType markdown setlocal conceallevel=2
augroup END

" Xtract
vnoremap <leader>x :Xtract

" JS Imports
augroup import_js
  autocmd!
  autocmd FileType javascript nnoremap <leader>jo :ImportJSWord<CR>
augroup END

" GitGutter
let g:gitgutter_sign_added = "\uf457"
let g:gitgutter_sign_modified = "\uf459"
let g:gitgutter_sign_removed = "\uf458"
let g:gitgutter_sign_removed_first_line = "\uf458"
let g:gitgutter_sign_modified_removed = "\uf459"

hi GitGutterAdd           guifg=#a6e22e guibg=#3b3a32
hi GitGutterChange        guifg=#fd971f guibg=#3b3a32
hi GitGutterDelete        guifg=#f92672 guibg=#3b3a32
hi GitGutterChangeDelete  guifg=#fd971f guibg=#3b3a32

" Startify
let g:startify_files_number = 6
let g:startify_change_to_vcs_root = 1
source ~/.vim/startify.vim

" Quick Menu
noremap <leader>m :call quickmenu#toggle(0)<cr>
let g:quickmenu_options = "LH"
source ~/.vim/quickmenu.vim

" Coverage
let g:coverage_interval = 1000

" Flow
let g:flow#showquickfix = 0
let g:flow#enable = 1
" augroup flow
"   autocmd!
"   autocmd FileType javascript setlocal omnifunc=flowcomplete#Complete
" augroup END

" Javascript Syntax
let g:javascript_plugin_flow = 1
