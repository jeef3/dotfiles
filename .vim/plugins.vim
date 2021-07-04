filetype off

call plug#begin('~/.vim/plugged')

" Shell and Tmux integration
Plug 'wincent/terminus'                   " Better terminal integration, cursor shapes
Plug 'tpope/vim-eunuch'                   " Better shell cmds, like :Rename
Plug 'tmux-plugins/vim-tmux-focus-events' " For all those lost focus events

" Main customization
Plug 'itchyny/lightline.vim'              " Lighter statusline
Plug 'josa42/vim-lightline-coc'           " CoC -> Lightline components
Plug 'tpope/vim-vinegar'                  " Netrw enhancements
Plug 'tpope/vim-repeat'                   " Get more use out of .
Plug 'tpope/vim-sleuth'                   " Set shiftwidth and expandtab based on current file
Plug 'tpope/vim-commentary'               " gcc to comment line/paragraph
Plug 'tpope/vim-surround'                 " Change surrounds, quotes etc
Plug 'tpope/vim-obsession'                " Keep my session
Plug 'jlanzarotta/bufexplorer'            " Enhanced buffer explorer <leader>be
Plug 'haya14busa/incsearch.vim'           " Enhanced / searching
" Plug 'haya14busa/incsearch-fuzzy.vim'     " Fuzzy search for incsearch
Plug 'justinmk/vim-sneak'                 " Minimal EasyMotion se
Plug 'brooth/far.vim'                     " Find And Replace
Plug 'jeef3/splitsizer.vim'               " Split resizing <c-a>, <c-s>
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'                   " Fast file searching <c-t>
Plug 'junegunn/vim-peekaboo'              " Registers insight
Plug 'jiangmiao/auto-pairs'               " Auto-complete quotes, parends etc
Plug 'machakann/vim-highlightedyank'      " Highlight yanked
Plug 'Xvezda/vim-readonly'                " Lock a bunch of files like node_modules
" Plug 'SirVer/ultisnips'                 " Code snippets
Plug 'kshenoy/vim-signature'              " Show marks
Plug 'wesQ3/vim-windowswap'               " Window pane swapping


" Git
" Plug 'tpope/vim-git'                    " Git syntax highlighting
Plug 'tpope/vim-fugitive'                 " Git wrapper, :Gstatus etc
Plug 'airblade/vim-gitgutter'             " Git status in gutter

" Languages syntax and formatting
Plug 'sheerun/vim-polyglot'               " Good base syntax package
Plug 'editorconfig/editorconfig-vim'      " Editorconfig
Plug 'OmniSharp/omnisharp-vim'            " C#
Plug 'dbeniamine/todo.txt-vim'            " todo.txt syntax

" Language Tools and Helpers
Plug 'tmux-plugins/vim-tmux'              " Tmux config helper, including :make
Plug 'suan/vim-instant-markdown'          " Markdown previews
Plug 'ap/vim-css-color'                   " Color preview, not just CSS
Plug 'mattn/emmet-vim'                    " HTML/CSS quick completion
Plug 'alvan/vim-closetag'                 " Auto-close HTML tags
Plug 'andymass/vim-matchup'
" Plug 'ruanyl/coverage.vim'                " Coverage report gutter

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver'
Plug 'neoclide/coc-snippets'
Plug 'neoclide/coc-json'
Plug 'neoclide/coc-yaml'
" Plug 'neoclide/coc-eslint'
Plug 'neoclide/coc-highlight'
Plug 'neoclide/coc-emmet'
Plug 'neoclide/coc-prettier'
Plug 'antoinemadec/coc-fzf'
Plug 'fannheyward/coc-styled-components'
Plug 'khanghoang/coc-jest'
Plug 'iamcco/coc-flutter'
Plug 'josa42/coc-sh'
Plug 'tjdevries/coc-zsh'


" Color Themes
Plug 'lifepillar/vim-colortemplate'
" Plug 'co1ncidence/monokai-pro.vim'
" Plug 'sainnhe/sonokai'
Plug 'arzg/vim-colors-xcode'

" Icons need to be run last
Plug 'ryanoasis/vim-devicons'             " Icon Fonts

call plug#end()
