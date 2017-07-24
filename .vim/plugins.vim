filetype off

call plug#begin('~/.vim/plugged')

" Shell Integration
Plug 'benmills/vimux'                   " Run shell commands in Tmux pane
Plug 'wincent/terminus'                 " Better terminal integration, cursor shapes, colors
Plug 'tpope/vim-obsession'              " Automatically save session state (used with Tmux)

" Customization
Plug 'mhinz/vim-startify'               " Start-up screen
Plug 'bling/vim-airline'                " Custom status and tab line
Plug 'junegunn/goyo.vim'                " Zen coding
Plug 'junegunn/limelight.vim'           " Color focus with Goyo
Plug 'tpope/vim-vinegar'                " Better netrw
Plug 'jlanzarotta/bufexplorer'          " Enhanced buffer explorer <leader>be
Plug 'haya14busa/incsearch.vim'         " Enhanced / searching
Plug 'haya14busa/incsearch-fuzzy.vim'   " Fuzzy search for incsearch
Plug 'justinmk/vim-sneak'               " Minimal EasyMotion
Plug 'jeef3/splitsizer.vim'             " Split resizing <c-a>, <c-s>
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'                 " Fast file searching <c-t>
Plug 'brooth/far.vim'                   " Find And Replace
Plug 'tpope/vim-repeat'                 " Get more use out of .
Plug 'ryanoasis/vim-devicons'           " Icon Fonts

" ===== My IDE =====

" Editing
Plug 'editorconfig/editorconfig-vim'    " Editorconfig
Plug 'tpope/vim-sleuth'                 " Set shiftwidth and expandtab based on current file
Plug 'tpope/vim-commentary'             " gcc to comment line/paragraph
Plug 'tpope/vim-surround'               " Change surrounds, quotes etc
Plug 'jiangmiao/auto-pairs'             " complete quotes, parends etc
Plug 'SirVer/ultisnips'                 " Code snippets
Plug 'rstacruz/vim-xtract'              " Extract selected into a new file
Plug 'vim-scripts/matchit.zip'          " More % matching

Plug 'metakirby5/codi.vim'              " REPL

" Errors and linting
Plug 'w0rp/ale'                         " File error checking
" Plug 'ruanyl/coverage.vim'              " Coverage report gutter

" Git
Plug 'tpope/vim-git'                    " Git syntax highlightinh
Plug 'tpope/vim-fugitive'               " Git wrapper, :Gstatus etc
Plug 'airblade/vim-gitgutter'           " Git status in gutter
Plug 'junegunn/gv.vim'                  " Git browser

" Language Syntax
Plug 'othree/html5.vim'                 " HTML5
" Plug 'gabrielelana/vim-markdown'        " Markdown
Plug 'plasticboy/vim-markdown'          " Markdown
Plug 'jeroenbourgois/vim-actionscript'  " ActionScript
Plug 'pangloss/vim-javascript'          " JavaScript
Plug 'leafgarland/typescript-vim'       " TypeScript
Plug 'kchmck/vim-coffee-script'         " CoffeeScript
Plug 'mxw/vim-jsx'                      " JSX
Plug 'elzr/vim-json'                    " JSON
Plug 'OrangeT/vim-csharp'               " c#
Plug 'vim-ruby/vim-ruby'                " Ruby
Plug 'hail2u/vim-css3-syntax'           " CSS3
Plug 'wavded/vim-stylus'                " Stylus (CSS)
Plug 'groenewege/vim-less'              " Less (CSS)
Plug 'vim-scripts/applescript.vim'      " AppleScript
Plug 'PProvost/vim-ps1'                 " PowerShell
Plug 'tmux-plugins/vim-tmux'            " Tmux config
Plug 'freitass/todo.txt-vim'            " todo.txt
Plug 'ajford/vimkivy'                   " Kivy (python)
Plug 'sudar/vim-arduino-syntax'         " Arduino

" Language Completion
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --tern-completer' }
Plug 'nosami/Omnisharp'                 " c#
Plug 'othree/csscomplete.vim'           " CSS
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' } " JavaScript

" Language Tools and Helpers
Plug 'moll/vim-node'                     " Node
Plug 'Quramy/tsuquyomi'                  " TypeScript tools
Plug 'mattn/emmet-vim'                   " HTML/CSS quick completion
Plug 'samuelsimoes/vim-jsx-utils'        " JSX helpers
Plug 'ap/vim-css-color'                  " Color preview in CSS
Plug 'jplaut/vim-arduino-ino'            " Arduino compile/build
Plug 'firegoby/html_entities_helper.vim' " HTML entity conversion
Plug 'Galooshi/vim-import-js'            " JavaScript Import helper
Plug 'dunckr/js_alternate.vim'           " JavaScript test alternate file switch
Plug 'suan/vim-instant-markdown'         " Markdown previews

" Dependencies
" Plug 'Shougo/vimproc.vim', { 'do': 'make' } " TypeScript
Plug 'tpope/vim-dispatch'               " Omnisharp

call plug#end()
