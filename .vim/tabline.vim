hi TabLineBorder               guifg=#414453 guibg=#393b44
hi TabLineSelBorder            guifg=#4484d1 guibg=#414453

hi TabLineNull                 guibg=#2f3037

" Glyph type colors
hi GlyphPalette1               guifg=#dfdfe0 guibg=#414453
hi GlyphPalette2               guifg=#84b360 guibg=#414453
hi GlyphPalette3               guifg=#00ff00 guibg=#414453
hi GlyphPalette4               guifg=#ff0000 guibg=#414453
hi GlyphPalette5               guifg=#ffa14f guibg=#414453
hi GlyphPalette6               guifg=#b281eb guibg=#414453
hi GlyphPalette7               guifg=#4484d1 guibg=#414453
hi GlyphPalette8               guifg=#0000ff guibg=#414453

let g:palette = {
      \ 'Palette1': ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''],
      \ 'Palette2': ['', '', '', '', '', '', '﵂', '', '', '', '', '', ''],
      \ 'Palette3': ['λ', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''],
      \ 'Palette4': ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''],
      \ 'Palette5': ['', '', '', '', '', '', '', '', '', '', '', '', '', ''],
      \ 'Palette6': ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''] ,
      \ 'Palette7': ['', '', '', '', '', '', '', '', '', '', '', ''],
      \ 'Palette8': ['', '', '', '', '', ''],
      \ }

function! GetColorForGlyph(glyph)
  let palettes = keys(g:palette)

  for pal in palettes
    let index = index(g:palette[pal], a:glyph)
    if index != -1
      break
    endif
    
  endfor
  return index
endfunction

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

    let glyph = WebDevIconsGetFileTypeSymbol(bufname(l:bufnr))
    let glyphColorIndex = GetColorForGlyph(glyph)
 
    let s .= (tabnr == tabpagenr() ? '%#GlyphPalette' . glyphColorIndex .'#' : '%#TabLine#') 
    let s .= glyph

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
