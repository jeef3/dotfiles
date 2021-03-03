filetype off

call plug#begin('~/.vim/plugged')

" Shell Integration
Plug 'wincent/terminus'                 " Better terminal integration, cursor shapes, colors
Plug 'tpope/vim-eunuch'                 " Better shell cmds, like :Rename
Plug 'tmux-plugins/vim-tmux-focus-events' " For all those lost focus events

" Customization
" Plug 'bling/vim-airline'                " Custom status and tab line
Plug 'itchyny/lightline.vim'
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
Plug 'tpope/vim-obsession'              " Keep my session

" Errors and linting
" Plug 'ruanyl/coverage.vim'              " Coverage report gutter

" Git
Plug 'tpope/vim-git'                    " Git syntax highlighting
Plug 'tpope/vim-fugitive'               " Git wrapper, :Gstatus etc
Plug 'airblade/vim-gitgutter'           " Git status in gutter
" Plug 'junegunn/gv.vim'                  " Git browser

" Language Syntax
Plug 'sheerun/vim-polyglot'             " Good base syntax package
" Plug 'othree/html5.vim'                 " HTML5
" Plug 'plasticboy/vim-markdown'          " Markdown
" Plug 'jeroenbourgois/vim-actionscript'  " ActionScript
" Plug 'pangloss/vim-javascript'          " JavaScript
" TypeScript
" I was using these --> Plug 'leafgarland/typescript-vim'       " TypeScript
"                   --> Plug 'ianks/vim-tsx'                    " TypeScript JSX bits
" Polyglot uses this  --> Plug 'HerringtonDarkholme/yats.vim'     " More TypeScript
" Plug 'kchmck/vim-coffee-script'         " CoffeeScript
" I was using this --> Plug 'mxw/vim-jsx'                      " JSX
" Polyglot uses this --> Plug 'MaxMEllon/vim-jsx-pretty'
" Plug 'elzr/vim-json'                    " JSON
" I was using this --> Plug 'OrangeT/vim-csharp'               " c#
" Not sure what Polyglot uses?
" Plug 'vim-ruby/vim-ruby'                " Ruby
" I was using this --> Plug 'hail2u/vim-css3-syntax'           " CSS3
" Polyglot uses this --> Plug 'vim-language-dept/css-syntax.vim'
" Plug 'wavded/vim-stylus'                " Stylus (CSS)
" I was using this --> Plug 'groenewege/vim-less'              " Less (CSS)
" Polyglot uses this --> Plug 'genoma/vim-less'
" I was using this --> Plug 'vim-scripts/applescript.vim'      " AppleScript
" Polyglot uses this --> Plug 'mityu/vim-applescript'
" Plug 'PProvost/vim-ps1'                 " PowerShell
" I was using this --> Plug 'ajford/vimkivy'                   " Kivy (python)
" Plug 'sudar/vim-arduino-syntax'         " Arduino
" Plug 'ekalinin/Dockerfile.vim'          " Docker
" Plug 'cespare/vim-toml'                 " TOML
" I was using this --> Plug 'mechatroner/rainbow_csv'          " CSV
" Polyglot uses this --> Plug 'chrisbra/csv.vim'
" Plug 'dart-lang/dart-vim-plugin'        " Dart
" Plug 'vim-scripts/groovy.vim'           " Groovy
" I was using this --> Plug 'nikvdp/ejs-syntax'                " EJS (JavaScript template langg)
" Polyglot uses this -- Plug 'briancollins/vim-jst'
" Plug 'jxnblk/vim-mdx-js'                " MDX
" Plug 'martinda/Jenkinsfile-vim-syntax'  " Jenkinsfile
" Only one I'm using not in Polyglot
" Plug 'freitass/todo.txt-vim'            " todo.txt
Plug 'dbeniamine/todo.txt-vim'

" Language completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" CoC Extensions
Plug 'neoclide/coc-tsserver'
Plug 'neoclide/coc-snippets'
Plug 'neoclide/coc-json'
Plug 'neoclide/coc-vetur'
Plug 'neoclide/coc-yaml'
Plug 'neoclide/coc-eslint'
Plug 'neoclide/coc-highlight'
Plug 'neoclide/coc-emmet'
Plug 'neoclide/coc-prettier'
Plug 'antoinemadec/coc-fzf'
Plug 'fannheyward/coc-styled-components'
Plug 'khanghoang/coc-jest'
Plug 'iamcco/coc-flutter'
Plug 'josa42/coc-sh'
Plug 'tjdevries/coc-zsh'

" Language support
Plug 'othree/csscomplete.vim'           " CSS
Plug 'natebosch/vim-lsc'      
Plug 'natebosch/vim-lsc-dart'           " Dart
Plug 'OmniSharp/omnisharp-vim'          " C#

" Language Tools and Helpers
Plug 'moll/vim-node'                     " Node
Plug 'mattn/emmet-vim'                   " HTML/CSS quick completion
Plug 'ap/vim-css-color'                  " Color preview in CSS
Plug 'jplaut/vim-arduino-ino'            " Arduino compile/build
Plug 'firegoby/html_entities_helper.vim' " HTML entity conversion
Plug 'dunckr/js_alternate.vim'           " JavaScript test alternate file switch
Plug 'suan/vim-instant-markdown'         " Markdown previews
Plug 'tmux-plugins/vim-tmux'             " Tmux config helper

" Misc utils
Plug 'Xvezda/vim-readonly'               " So I don't accidentally edit them files again

" Trial
Plug 'alvan/vim-closetag'                " Auto-close HTML tags

" Color Themes
Plug 'lifepillar/vim-colortemplate'
Plug 'co1ncidence/monokai-pro.vim'
Plug 'sainnhe/sonokai'
Plug 'arzg/vim-colors-xcode'

" Icons last
Plug 'ryanoasis/vim-devicons'           " Icon Fonts

call plug#end()
