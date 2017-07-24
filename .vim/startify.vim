let g:startify_custom_header = [
      \ '           __',
      \ '   .--.--.|__|.--------.',
      \ '   |  |  ||  ||        |',
      \ '    \___/ |__||__|__|__|',
      \ '   '
      \]

let g:startify_list_order = [
      \ ["   \uf401 " . getcwd() ],
      \ 'dir',
      \ ["   \uf461 Bookmarks"],
      \ 'bookmarks',
      \ ['   Sessions'],
      \ 'sessions'
      \ ]

let g:startify_bookmarks = [
      \ { 'v': '~/.vimrc' },
      \ { 'p': '~/.vim/plugins.vim' }
      \ ]
