filetype off

call plug#begin('~/.vim/plugged')

" Common
" Plug 'wincent/terminus'                   " Better terminal integration, cursor shapes
" Plug 'tpope/vim-eunuch'                   " Better shell cmds, like :Rename

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
Plug 'windwp/nvim-autopairs'              " Newer auto-pairs
Plug 'windwp/nvim-ts-autotag'             " Auto-close HTML tags 
Plug 'machakann/vim-highlightedyank'      " Highlight yanked
Plug 'Xvezda/vim-readonly'                " Lock a bunch of files like node_modules
Plug 'kshenoy/vim-signature'              " Show marks

Plug 'tpope/vim-fugitive'                 " Git wrapper, :Gstatus etc
" Plug 'airblade/vim-gitgutter'             " Git status in gutter

Plug 'norcalli/nvim-colorizer.lua'        " Colored colors

" Languages
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}

" Neovim only
Plug 'nvim-lua/plenary.nvim'              " Lua functions util


Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
" Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'jose-elias-alvarez/typescript.nvim'

Plug 'sindrets/diffview.nvim'

" Plug '~/projects/princess.nvim'
" Plug 'git@github.com:jeef3/princess.nvim.git'
Plug 'fladson/vim-kitty' " Kitty config syntax
" Plug 'RRethy/vim-illuminate'
Plug 'petertriho/nvim-scrollbar' " Scroll bar, including diagnostic indicators
"Plug 'Xuyuanp/scrollbar.nvim'
Plug 'declancm/cinnamon.nvim' " Smooth scrolling
Plug 'folke/zen-mode.nvim'
"Plug 'rcarriga/nvim-notify'

" Tests
" Plug 'antoinemadec/FixCursorHold.nvim' " Required for testing
" Plug 'vim-test/vim-test'
" Plug 'nvim-neotest/neotest'
" Plug 'nvim-neotest/neotest-vim-test'
" Plug 'haydenmeade/neotest-jest'
" Plug 'KaiSpencer/neotest-vitest'
" Plug 'nvim-neotest/neotest-plenary'
" Plug 'andythigpen/nvim-coverage'

" Debug
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

call plug#end()
