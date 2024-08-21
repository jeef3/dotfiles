if exists('current_compiler')
  finish
endif
let current_compiler = 'tsc'

if exists(':CompilerSet') != 2  " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=npx\ tsc\ -p\ .
CompilerSet errorformat=%A%f(%l\\,%c):\ %trror\ TS%n:\ %m,%C%m,%-G
