hi TabLineBorder               guifg=#414453 guibg=#393b44
hi TabLineSelBorder            guifg=#4484d1 guibg=#414453

hi TabLineNull                 guibg=#2f3037

" Glyph type colors
hi GlyphPalette1               guifg=#dfdfe0 guibg=#414453
hi GlyphPalette2               guifg=#84b360 guibg=#414453
hi GlyphPalette3               guifg=#ffa14f guibg=#414453
hi GlyphPalette4               guifg=#ff8170 guibg=#414453
hi GlyphPalette5               guifg=#4484d1 guibg=#414453
hi GlyphPalette6               guifg=#b281eb guibg=#414453
hi GlyphPalette7               guifg=#4484d1 guibg=#414453
hi GlyphPalette8               guifg=#d9c97c guibg=#414453

let g:palette = {
      \ 'GlyphPalette1': ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''],
      \ 'GlyphPalette2': ['', '', '', '', '', '', '﵂', '', '', '', '', '', ''],
      \ 'GlyphPalette3': ['λ', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''],
      \ 'GlyphPalette4': ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''],
      \ 'GlyphPalette5': ['', '', '', '', '', '', '', '', '', '', '', '', '', ''],
      \ 'GlyphPalette6': ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''] ,
      \ 'GlyphPalette7': ['', '', '', '', '', '', '', '', '', '', '', '', '', ''],
      \ 'GlyphPalette8': ['', '', '', '', '', '', '', ''],
      \ }

function! GetColorForGlyph(glyph)
  let palettes = keys(g:palette)

  for pal in palettes
    let index = index(g:palette[pal], a:glyph)
    if index != -1
      break
    endif
    
  endfor
  return pal
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
 
    let s .= (tabnr == tabpagenr() ? '%#' . glyphColorIndex .'#' : '%#TabLine#') 
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
