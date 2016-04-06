filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Integration
Plugin 'benmills/vimux'                   " Run shell commands in Tmux pane
Plugin 'wincent/terminus'                 " Better terminal integration, cursor shapes, colors

" IDE
" Plugin 'ctrlpvim/ctrlp.vim'               " Fast file searching
Plugin 'scrooloose/syntastic'             " File error checking
Plugin 'bling/vim-airline'                " Custom status line
Plugin 'tpope/vim-commentary'             " gcc to comment line/paragraph
Plugin 'tpope/vim-fugitive'               " Git wrapper, :Gstatus etc
Plugin 'airblade/vim-gitgutter'           " Git status in gutter
Plugin 'jreybert/vimagit'                 " Another Git wrapper/editor
Plugin 'tpope/vim-vinegar'                " Better netrw
Plugin 'tpope/vim-dispatch'               " Async build dispatcher
Plugin 'tpope/vim-surround'               " Change surrounds, quotes etc
Plugin 'tpope/vim-obsession'              " Automatically save session state (used with Tmux)
Plugin 'nosami/Omnisharp'                 " Code completion for c#
Plugin 'Raimondi/delimitMate'             " Auto-complete quotes, parens etc
Plugin 'editorconfig/editorconfig-vim'    " Editorconfig
Plugin 'jlanzarotta/bufexplorer'          " Enhanced buffer explorer
Plugin 'SirVer/ultisnips'                 " Code snippets
Plugin 'rking/ag.vim'                     " Fast file text search
Plugin 'easymotion/vim-easymotion'        " Advanced motions navigation
Plugin 'haya14busa/incsearch.vim'         " Enhanved / searching
Plugin 'vim-scripts/autoresize.vim'       " Auto-resizing splits

" Fast file searching with FZF
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'

" Code-completion engine
Plugin 'Valloric/YouCompleteMe', {
\   'build' : {
\     'mac' : './install.py',
\   },
\ }

" Languages and syntax
Plugin 'othree/html5.vim'                 " HTML5
Plugin 'gabrielelana/vim-markdown'        " Markdown
Plugin 'jeroenbourgois/vim-actionscript'  " ActionScript
Plugin 'pangloss/vim-javascript'          " JavaScript
Plugin 'kchmck/vim-coffee-script'         " CoffeeScript
Plugin 'leafgarland/typescript-vim'       " TypeScript
Plugin 'mxw/vim-jsx'                      " JSX
Plugin 'elzr/vim-json'                    " JSON
Plugin 'OrangeT/vim-csharp'               " c#
Plugin 'vim-ruby/vim-ruby'                " Ruby
Plugin 'hail2u/vim-css3-syntax'           " CSS3
Plugin 'wavded/vim-stylus'                " Stylus (CSS)
Plugin 'vim-scripts/applescript.vim'      " AppleScript
Plugin 'PProvost/vim-ps1'                 " PowerShell
Plugin 'tmux-plugins/vim-tmux'            " Tmux config
Plugin 'freitass/todo.txt-vim'            " todo.txt

" Language helpers
Plugin 'moll/vim-node'                    " Node
Plugin 'Quramy/tsuquyomi'                 " TypeScript tools
Plugin 'mattn/emmet-vim'                  " HTML/CSS quick completion
" Plugin 'othree/javascript-libraries-syntax.vim'

" Code analysis for JavaScript
Plugin 'marijnh/tern_for_vim', {
\   'build' : {
\     'mac' : 'npm install'
\   }
\}

" Dependencies
" Plugin 'tomtom/tlib_vim'                " Not sure
" Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'Shougo/vimproc.vim', {
\   'build': {
\     'mac': 'make'
\   }
\ }

call vundle#end()
