filetype off

call plug#begin('~/.vim/plugged')

" Shell Integration
Plug 'wincent/terminus'                 " Better terminal integration, cursor shapes, colors
Plug 'tpope/vim-eunuch'                 " Better shell cmds, like :Rename

" Customization
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
Plug 'metakirby5/codi.vim'              " REPL
Plug 'skywind3000/quickmenu.vim'        " Quick Menu
Plug 'machakann/vim-highlightedyank'    " Highlight yanked
Plug 'rhysd/vim-grammarous'             " Grammar checking

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
Plug 'ianks/vim-tsx'                    " More TypeScript
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
Plug 'freitass/todo.txt-vim'            " todo.txt
Plug 'ajford/vimkivy'                   " Kivy (python)
Plug 'sudar/vim-arduino-syntax'         " Arduino
Plug 'ekalinin/Dockerfile.vim'          " Docker
Plug 'cespare/vim-toml'                 " TOML
Plug 'mechatroner/rainbow_csv'          " CSV
Plug 'dart-lang/dart-vim-plugin'        " Dart


" Language Completion
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --ts-completer' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'othree/csscomplete.vim'           " CSS
" Plug 'ternjs/tern_for_vim', { 'do': 'npm install' } " JavaScript
" Plug 'autozimu/LanguageClient-neovim', {
"                   \ 'branch': 'next',
"                   \ 'do': 'bash install.sh',
"                   \ }
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'

" Language Tools and Helpers
Plug 'moll/vim-node'                     " Node
" Plug 'Quramy/tsuquyomi'                  " TypeScript tools
Plug 'mattn/emmet-vim'                   " HTML/CSS quick completion
" Plug 'samuelsimoes/vim-jsx-utils'        " JSX helpers
Plug 'ap/vim-css-color'                  " Color preview in CSS
Plug 'jplaut/vim-arduino-ino'            " Arduino compile/build
Plug 'firegoby/html_entities_helper.vim' " HTML entity conversion
Plug 'Galooshi/vim-import-js'            " JavaScript Import helper
Plug 'dunckr/js_alternate.vim'           " JavaScript test alternate file switch
Plug 'suan/vim-instant-markdown'         " Markdown previews

" Trial
Plug 'alvan/vim-closetag'                " Auto-close HTML tags

" Color Themes
Plug 'lifepillar/vim-colortemplate'
Plug 'arzg/vim-colors-xcode'
Plug 'sainnhe/sonokai'
Plug 'https://github.com/co1ncidence/monokai-pro.vim.git'

call plug#end()
