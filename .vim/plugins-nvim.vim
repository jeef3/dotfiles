filetype off

call plug#begin('~/.vim/plugged')

" Common

Plug 'brooth/far.vim'                     " Find And Replace

Plug 'andymass/vim-matchup'
Plug 'kshenoy/vim-signature'              " Show marks

" Languages
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}


" Plug 'jose-elias-alvarez/typescript.nvim'

" Plug '~/projects/princess.nvim'
" Plug 'git@github.com:jeef3/princess.nvim.git'
" Plug 'RRethy/vim-illuminate'
" Plug 'petertriho/nvim-scrollbar' " Scroll bar, including diagnostic indicators
"Plug 'Xuyuanp/scrollbar.nvim'
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

call plug#end()
