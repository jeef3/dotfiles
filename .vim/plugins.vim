filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'benmills/vimux'
Plugin 'vim-scripts/syntax-highlighting-for-tintinttpp'

" IDE
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-obsession'
Plugin 'airblade/vim-gitgutter'
Plugin 'nosami/Omnisharp'
Plugin 'marijnh/tern_for_vim'
Plugin 'Raimondi/delimitMate'
Plugin 'Valloric/YouCompleteMe', {
\   'build' : {
\     'mac' : './install.sh',
\   },
\ }
Plugin 'jlanzarotta/bufexplorer'
Plugin 'SirVer/ultisnips'
Plugin 'rking/ag.vim'
Plugin 'freitass/todo.txt-vim'

" Util (other plugins need these)
Plugin 'tomtom/tlib_vim'
Plugin 'Quramy/tsuquyomi'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'Shougo/vimproc.vim', {
\   'build': {
\     'mac': 'make'
\   }
\ }

Plugin 'editorconfig/editorconfig-vim'

Plugin 'mattn/emmet-vim'

" Languages and syntax
Plugin 'othree/html5.vim'
Plugin 'jeroenbourgois/vim-actionscript'
Plugin 'kchmck/vim-coffee-script'
Plugin 'jtratner/vim-flavored-markdown'
Plugin 'gabrielelana/vim-markdown'
Plugin 'elzr/vim-json'
Plugin 'wavded/vim-stylus'
Plugin 'moll/vim-node'
Plugin 'OrangeT/vim-csharp'
Plugin 'pangloss/vim-javascript'
Plugin 'othree/javascript-libraries-syntax.vim'
" Plugin 'burnettk/vim-angular'
Plugin 'vim-ruby/vim-ruby'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'vim-scripts/applescript.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'clausreinke/typescript-tools.vim'
Plugin 'PProvost/vim-ps1'
Plugin 'mxw/vim-jsx'
Plugin 'HerringtonDarkholme/yats.vim'
Plugin 'tmux-plugins/vim-tmux'

call vundle#end()
