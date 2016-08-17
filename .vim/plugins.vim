filetype off

call plug#begin('~/.vim/plugged')

Plug 'gmarik/Vundle.vim'

" Integration
Plug 'benmills/vimux'                   " Run shell commands in Tmux pane
Plug 'wincent/terminus'                 " Better terminal integration, cursor shapes, colors

" Misc Vim stuff
Plug 'vim-scripts/BufOnly.vim'          " Close all but current buffer
Plug 'tpope/vim-sleuth'                 " Smarter shiftwidth and expandtab

" IDE
" Plug 'ctrlpvim/ctrlp.vim'             " Fast file searching (fzf replaces)
Plug 'scrooloose/syntastic'             " File error checking
Plug 'pmsorhaindo/syntastic-local-eslint.vim' " Use local ESLint
Plug 'bling/vim-airline'                " Custom status line
Plug 'tpope/vim-commentary'             " gcc to comment line/paragraph
Plug 'tpope/vim-fugitive'               " Git wrapper, :Gstatus etc
Plug 'airblade/vim-gitgutter'           " Git status in gutter
Plug 'jreybert/vimagit'                 " Another Git wrapper/editor
Plug 'tpope/vim-vinegar'                " Better netrw
Plug 'tpope/vim-dispatch'               " Async build dispatcher
Plug 'tpope/vim-surround'               " Change surrounds, quotes etc
Plug 'tpope/vim-obsession'              " Automatically save session state (used with Tmux)
Plug 'nosami/Omnisharp'                 " Code completion for c#
Plug 'jiangmiao/auto-pairs'             " Better(?) complete quotes, parends etc
Plug 'editorconfig/editorconfig-vim'    " Editorconfig
Plug 'jlanzarotta/bufexplorer'          " Enhanced buffer explorer
Plug 'SirVer/ultisnips'                 " Code snippets
" Plug 'rking/ag.vim'                     " Fast file text search (fzf replaces)
Plug 'easymotion/vim-easymotion'        " Advanced motions navigation
Plug 'haya14busa/incsearch.vim'         " Enhanved / searching
Plug 'jeef3/splitsizer.vim'             " Split resizing
Plug 'junegunn/vim-emoji'               " Emoji!

" Fast file searching with FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Code-completion engine
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }

" Languages and syntax
Plug 'othree/html5.vim'                 " HTML5
" Plug 'gabrielelana/vim-markdown'        " Markdown
Plug 'plasticboy/vim-markdown'          " Markdown
Plug 'jeroenbourgois/vim-actionscript'  " ActionScript
Plug 'pangloss/vim-javascript'          " JavaScript
Plug 'kchmck/vim-coffee-script'         " CoffeeScript
Plug 'leafgarland/typescript-vim'       " TypeScript
Plug 'mxw/vim-jsx'                      " JSX
Plug 'elzr/vim-json'                    " JSON
Plug 'OrangeT/vim-csharp'               " c#
Plug 'vim-ruby/vim-ruby'                " Ruby
Plug 'othree/csscomplete.vim'           " CSS completion
Plug 'hail2u/vim-css3-syntax'           " CSS3
Plug 'wavded/vim-stylus'                " Stylus (CSS)
Plug 'groenewege/vim-less'              " Less (CSS)
Plug 'vim-scripts/applescript.vim'      " AppleScript
Plug 'PProvost/vim-ps1'                 " PowerShell
Plug 'tmux-plugins/vim-tmux'            " Tmux config
Plug 'freitass/todo.txt-vim'            " todo.txt
Plug 'ap/vim-css-color'                 " Color preview in CSS

" Language helpers
Plug 'moll/vim-node'                    " Node
Plug 'Quramy/tsuquyomi'                 " TypeScript tools
Plug 'mattn/emmet-vim'                  " HTML/CSS quick completion
" Plug 'othree/javascript-libraries-syntax.vim'
Plug 'samuelsimoes/vim-jsx-utils'       " JSX helpers

" Code analysis for JavaScript
Plug 'marijnh/tern_for_vim', { 'do': 'npm install' }

" Dependencies
" Plug 'tomtom/tlib_vim'                " Not sure
" Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }

call plug#end()
