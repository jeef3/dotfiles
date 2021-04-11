hi TabLineBorder               guifg=#414453 guibg=#393b44
hi TabLineSelBorder            guifg=#4484d1 guibg=#414453

hi TabLineNull                 guibg=#2f3037

" File type colors
hi FileTypeSel_                guifg=#dfdfe0 guibg=#414453
hi FileTypeSel_netrw           guifg=#dfdfe0 guibg=#414453
hi FileTypeSel_cs              guifg=#b281eb guibg=#414453
hi FileTypeSel_vim             guifg=#84b360 guibg=#414453
hi FileTypeSel_tmux            guifg=#84b360 guibg=#414453
hi FileTypeSel_sh              guifg=#4484d1 guibg=#414453
hi FileTypeSel_typescript      guifg=#4484d1 guibg=#414453
hi FileTypeSel_typescriptreact guifg=#4484d1 guibg=#414453
hi FileTypeSel_javascriptreact guifg=#4484d1 guibg=#414453
hi FileTypeSel_javascript      guifg=#ffa14f guibg=#414453
hi FileTypeSel_json            guifg=#ffa14f guibg=#414453
hi FileTypeSel_yaml            guifg=#ffa14f guibg=#414453
hi FileTypeSel_markdown        guifg=#ffa14f guibg=#414453
hi FileTypeSel_gitconfig       guifg=#ffa14f guibg=#414453
hi FileTypeSel_help            guifg=#ffa14f guibg=#414453

function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    let tabnr = i + 1 " range() starts at 0
    let winnr = tabpagewinnr(tabnr)
    let buflist = tabpagebuflist(tabnr)
    let bufnr = buflist[winnr - 1]
    let bufname = fnamemodify(bufname(bufnr), ':t')

    let s .= '%' . tabnr . 'T'

    let s .= (tabnr == tabpagenr() ? '%#TabLineSelBorder#' : '%#TabLineBorder#')
    let s .= "▎ "
 
    let s .= (tabnr == tabpagenr() ? '%#FileTypeSel_' . &filetype .'#' : '%#TabLine#') 
    let s .= WebDevIconsGetFileTypeSymbol(bufname(l:bufnr)) 

    let s .= (tabnr == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= empty(bufname) ? ' [No Name] ' : ' ' . bufname . ' '
 
    let bufmodified = getbufvar(bufnr, "&mod")
    let s .= (bufmodified ? '%999X●' : '%999X×') . '  '

  endfor

  let s .= '%#TabLineFill#%T'

  if tabpagenr('$') > 1
    let s .= '%#TabLineNull#'
  endif

  return s
endfunction

set tabline=%!MyTabLine()
