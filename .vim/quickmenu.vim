call g:quickmenu#reset()

call g:quickmenu#header("Menu")

" Git:
call g:quickmenu#append('# Git', '')

call g:quickmenu#append(
                  \ 'Status',
                  \ 'Gstatus',
                  \ 'View status')
call g:quickmenu#append(
                  \ 'Diff',
                  \ 'Gvdiff',
                  \ 'View diff')

" Misc:
call g:quickmenu#append('# Misc', '')

call g:quickmenu#append(
                  \ "Run %{expand('%:t')}",
                  \ '!./%',
                  \ "Run current file")

call g:quickmenu#append(
                  \ 'Format',
                  \ 'FormatJSON',
                  \ "Format the JSON",
                  \ 'json')
