filetype off

call plug#begin('~/.vim/plugged')

" Common
Plug 'wincent/terminus'                   " Better terminal integration, cursor shapes
Plug 'tpope/vim-eunuch'                   " Better shell cmds, like :Rename

Plug 'tpope/vim-vinegar'                  " Netrw enhancements
Plug 'tpope/vim-repeat'                   " Get more use out of .
Plug 'tpope/vim-sleuth'                   " Set shiftwidth and expandtab based on current file
Plug 'tpope/vim-commentary'               " gcc to comment line/paragraph
Plug 'tpope/vim-surround'                 " Change surrounds, quotes etc
Plug 'tpope/vim-obsession'                " Keep my session
"Plug 'jlanzarotta/bufexplorer'            " Enhanced buffer explorer <leader>be
Plug 'haya14busa/incsearch.vim'           " Enhanced / searching
Plug 'justinmk/vim-sneak'                 " Minimal EasyMotion se
Plug 'brooth/far.vim'                     " Find And Replace
Plug 'jeef3/splitsizer.vim'               " Split resizing <c-a>, <c-s>

Plug 'andymass/vim-matchup'
Plug 'jiangmiao/auto-pairs'               " Auto-complete quotes, parends etc
Plug 'machakann/vim-highlightedyank'      " Highlight yanked
Plug 'Xvezda/vim-readonly'                " Lock a bunch of files like node_modules
Plug 'kshenoy/vim-signature'              " Show marks

Plug 'tpope/vim-fugitive'                 " Git wrapper, :Gstatus etc
" Plug 'airblade/vim-gitgutter'             " Git status in gutter

Plug 'norcalli/nvim-colorizer.lua'        " Colored colors

" Neovim only
Plug 'nvim-lua/plenary.nvim'              " Lua functions util

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/playground'

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'ray-x/lsp_signature.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

" Plug 'glepnir/lspsaga.nvim'
" Maintained fork:
Plug 'tami5/lspsaga.nvim'

Plug 'nvim-lualine/lualine.nvim'

Plug 'ms-jpq/coq_nvim', {'branch': 'coq', 'do': ':COQdeps' }
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
" Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'seblj/nvim-tabline'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'

Plug 'rktjmp/lush.nvim'
Plug '~/projects/princess_theme'

Plug 'RRethy/vim-illuminate'
Plug 'petertriho/nvim-scrollbar'
Plug 'folke/zen-mode.nvim'
Plug 'vim-test/vim-test'
Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' }
" Plug 'rcarriga/nvim-notify'
Plug 'lewis6991/gitsigns.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim'

call plug#end()
