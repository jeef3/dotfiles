" Vim color file
"
" Author: Jeff Knaggs
"
" Note: Based on the monokai theme by
" Tomas Restrepo <tomas@winterdom.com>
" https://github.com/tomasr/molokai
"

hi clear

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="princess"

hi Boolean         guifg=#AE81FF
hi Character       guifg=#FD64D5
hi Number          guifg=#AE81FF
hi String          guifg=#FD64D5
hi Conditional     guifg=#F92672               cterm=bold
hi Constant        guifg=#AE81FF               cterm=bold
hi Cursor          guifg=#000000 guibg=#F8F8F0
hi iCursor         guifg=#000000 guibg=#F8F8F0
hi Debug           guifg=#BCA3A3               cterm=bold
hi Define          guifg=#91A6FF
hi Delimiter       guifg=#8F8F8F
hi DiffAdd                       guibg=#13354A
hi DiffChange      guifg=#89807D guibg=#4C4745
hi DiffDelete      guifg=#960050 guibg=#1E0010
hi DiffText                      guibg=#4C4745 cterm=italic,bold

hi Directory       guifg=#A6E22E               cterm=bold
hi Error           guifg=#960050 guibg=#1E0010
hi ErrorMsg        guifg=#F92672 guibg=#232526 cterm=bold
hi Exception       guifg=#A6E22E               cterm=bold
hi Float           guifg=#AE81FF
hi FoldColumn      guifg=#465457 guibg=#000000
hi Folded          guifg=#465457 guibg=#000000
hi Function        guifg=#A6E22E
hi Identifier      guifg=#FD971F
hi Ignore          guifg=#808080 guibg=bg
hi IncSearch       guifg=#C4BE89 guibg=#000000

hi Keyword         guifg=#F92672               cterm=bold
hi Label           guifg=#E6DB74               cterm=none
hi Macro           guifg=#C4BE89               cterm=italic
hi SpecialKey      guifg=#91a6ff               cterm=italic

hi MatchParen      guifg=#FD971F guibg=bg      cterm=bold
hi ModeMsg         guifg=#E6DB74
hi MoreMsg         guifg=#E6DB74
hi Operator        guifg=#F92672

" complete menu
hi Pmenu           guifg=#ffffff guibg=#465457
hi PmenuSel        guifg=#272822 guibg=#e6db74 cterm=bold
hi PmenuSbar                     guibg=#3B3A32
hi PmenuThumb                    guibg=#ffffff

hi PreCondit       guifg=#A6E22E               cterm=bold
hi PreProc         guifg=#A6E22E
hi Question        guifg=#91A6FF
hi Repeat          guifg=#F92672               cterm=bold
hi Search          guifg=#000000 guibg=#ffe792
" marks column
hi SignColumn      guifg=#A6E22E guibg=#3B3a32
hi SpecialChar     guifg=#F92672               cterm=bold
hi SpecialComment  guifg=#465457               cterm=italic
hi Special         guifg=#91a6ff guibg=bg      cterm=bold,italic
hi SpecialKey      guifg=#888A85               cterm=italic
if has("spell")
    hi SpellBad    guibg=#300817 cterm=undercurl
    hi SpellCap    guibg=#7070F0 cterm=undercurl
    hi SpellLocal  guibg=#70F0F0 cterm=undercurl
    hi SpellRare   guibg=#FFFFFF cterm=undercurl
endif
hi Statement       guifg=#F92672               cterm=bold
hi StatusLine      guifg=#AE81FF guibg=#080808
hi StatusLineNC    guifg=#808080 guibg=#080808
hi User1           guifg=#AE81FF guibg=#3B3A32
hi StorageClass    guifg=#FD971F               cterm=italic
hi Structure       guifg=#91A6FF
hi Tag             guifg=#F92672               cterm=italic
hi Title           guifg=#ef5939
hi Todo            guifg=#FFFFFF guibg=bg      cterm=bold

hi Typedef         guifg=#91A6FF
hi Type            guifg=#91A6FF               cterm=none
hi Underlined      guifg=#808080               cterm=underline

hi VertSplit       guifg=#fd971f guibg=#232526 cterm=bold
hi VisualNOS                     guibg=#403D3D
hi Visual                        guibg=#403D3D
hi WarningMsg      guifg=#FFFFFF guibg=#333333 cterm=bold
hi WildMenu        guifg=#91A6FF guibg=#000000

hi Normal          guifg=#F8F8F2 guibg=#272822
hi Comment         guifg=#785E6D               cterm=italic
hi CursorLine                    guibg=#3b3a32 cterm=none
hi CursorLineNr    guifg=#FD971F               gui=none
hi CursorColumn                  guibg=#3E3D32
hi ColorColumn                   guibg=#3B3A32
hi LineNr          guifg=#BCBCBC guibg=#3B3A32
hi NonText         guifg=#BCBCBC guibg=#232526

"
" Support for 256-color terminal
"
" if &t_Co > 255
"    hi Boolean         ctermfg=135
"    hi Character       ctermfg=144
"    hi Number          ctermfg=135
"    hi String          ctermfg=206
"    hi Conditional     ctermfg=161               cterm=bold
"    hi Constant        ctermfg=135               cterm=bold
"    " hi Cursor          ctermfg=16  ctermbg=253
"    hi Debug           ctermfg=225               cterm=bold
"    hi Define          ctermfg=81
"    hi Delimiter       ctermfg=241

"    hi DiffAdd                     ctermbg=24
"    hi DiffChange      ctermfg=181 ctermbg=239
"    hi DiffDelete      ctermfg=162 ctermbg=53
"    hi DiffText                    ctermbg=102 cterm=bold

"    hi Directory       ctermfg=118               cterm=bold
"    hi Error           ctermfg=219 ctermbg=89
"    hi ErrorMsg        ctermfg=199 ctermbg=16    cterm=bold
"    hi Exception       ctermfg=118               cterm=bold
"    hi Float           ctermfg=135
"    hi FoldColumn      ctermfg=67  ctermbg=16
"    hi Folded          ctermfg=67  ctermbg=16
"    hi Function        ctermfg=118
"    hi Identifier      ctermfg=208
"    hi Ignore          ctermfg=244 ctermbg=232
"    hi IncSearch       ctermfg=193 ctermbg=16

"    hi Keyword         ctermfg=161               cterm=bold
"    hi Label           ctermfg=229               cterm=none
"    hi Macro           ctermfg=193
"    hi SpecialKey      ctermfg=81

   " hi MatchParen      ctermfg=16  ctermbg=208 cterm=bold
   " hi ModeMsg         ctermfg=229
   " hi MoreMsg         ctermfg=229
   " hi Operator        ctermfg=161

"    " complete menu
"    hi Pmenu           ctermfg=81  ctermbg=16
"    hi PmenuSel                    ctermbg=244
"    hi PmenuSbar                   ctermbg=232
"    hi PmenuThumb      ctermfg=81

"    hi PreCondit       ctermfg=118               cterm=bold
"    hi PreProc         ctermfg=118
"    hi Question        ctermfg=81
"    hi Repeat          ctermfg=161               cterm=bold
"    hi Search          ctermfg=253 ctermbg=66

"    " marks column
   " hi SignColumn      ctermfg=118 ctermbg=235
   " hi SpecialChar     ctermfg=161               cterm=bold
   " hi SpecialComment  ctermfg=245               cterm=italic
   " hi Special         ctermfg=81  ctermbg=232
   " hi SpecialKey      ctermfg=245

"    hi Statement       ctermfg=161               cterm=bold
"    hi StatusLine      ctermfg=238 ctermbg=253
"    hi StatusLineNC    ctermfg=244 ctermbg=232
"    hi StorageClass    ctermfg=208
"    hi Structure       ctermfg=81
"    hi Tag             ctermfg=161
"    hi Title           ctermfg=166
"    hi Todo            ctermfg=231 ctermbg=232   cterm=bold

"    hi Typedef         ctermfg=81
"    hi Type            ctermfg=81                cterm=none
"    hi Underlined      ctermfg=244               cterm=underline

"    hi VertSplit       ctermfg=244 ctermbg=232   cterm=bold
"    hi VisualNOS                   ctermbg=238
"    hi Visual                      ctermbg=235
"    hi WarningMsg      ctermfg=231 ctermbg=238   cterm=bold
"    hi WildMenu        ctermfg=81  ctermbg=16

" FIXME: Required for marks colors????
   hi Normal          ctermfg=225 ctermbg=233
   " hi Comment         ctermfg=60                cterm=italic
   " hi CursorLine                  ctermbg=234   cterm=none
   " hi CursorColumn                ctermbg=234
   " hi LineNr          ctermfg=255 ctermbg=234
   " hi NonText         ctermfg=255 ctermbg=234
" end
