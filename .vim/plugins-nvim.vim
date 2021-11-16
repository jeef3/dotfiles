filetype off

call plug#begin('~/.vim/plugged')

" Common
Plug 'wincent/terminus'                   " Better terminal integration, cursor shapes
Plug 'tpope/vim-eunuch'                   " Better shell cmds, like :Rename

Plug 'itchyny/lightline.vim'              " Lighter statusline
Plug 'tpope/vim-vinegar'                  " Netrw enhancements
Plug 'tpope/vim-repeat'                   " Get more use out of .
Plug 'tpope/vim-sleuth'                   " Set shiftwidth and expandtab based on current file
Plug 'tpope/vim-commentary'               " gcc to comment line/paragraph
Plug 'tpope/vim-surround'                 " Change surrounds, quotes etc
Plug 'tpope/vim-obsession'                " Keep my session
Plug 'jlanzarotta/bufexplorer'            " Enhanced buffer explorer <leader>be
Plug 'haya14busa/incsearch.vim'           " Enhanced / searching
Plug 'justinmk/vim-sneak'                 " Minimal EasyMotion se
Plug 'brooth/far.vim'                     " Find And Replace
Plug 'jeef3/splitsizer.vim'               " Split resizing <c-a>, <c-s>

Plug 'jiangmiao/auto-pairs'               " Auto-complete quotes, parends etc
Plug 'machakann/vim-highlightedyank'      " Highlight yanked
Plug 'Xvezda/vim-readonly'                " Lock a bunch of files like node_modules
Plug 'kshenoy/vim-signature'              " Show marks

Plug 'tpope/vim-fugitive'                 " Git wrapper, :Gstatus etc
Plug 'airblade/vim-gitgutter'             " Git status in gutter

Plug 'arzg/vim-colors-xcode'

Plug 'ryanoasis/vim-devicons'             " Icon Fonts


" Neovim only
Plug 'nvim-lua/plenary.nvim'              " Lua functions util

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'kyazdani42/nvim-web-devicons'

call plug#end()
