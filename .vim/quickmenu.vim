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

" Tools:
call g:quickmenu#append('# Tools', '')

call g:quickmenu#append(
                  \ 'Find and Replace',
                  \ 'Farp',
                  \ 'Find and replace in files')

call g:quickmenu#append(
                  \ 'Format',
                  \ 'FormatJSON',
                  \ "Format the JSON",
                  \ 'json')

call g:quickmenu#append(
                  \ "Run %{expand('%:t')}",
                  \ '!./%',
                  \ "Run current file")

