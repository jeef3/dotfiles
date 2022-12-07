" ==============================================================================
" Plugin Configuration
" ==============================================================================

" Lightline
" source ~/.vim/lightline-xcodedark.vim

let g:lightline = {
      \ "colorscheme": "xcodedark",
      \ "enable": { "tabline": 0 },
      \ "active": {
      \   "left": [ [ "mode", "paste" ],
      \             [ ] ,
      \             [ "readonly", "filename" ] ],
      \   "right": [ [ "coc_errors", "coc_warnings", "coc_ok" ],
      \              [ ],
      \              [ "fileformat", "lineinfo" ] ],
      \ },
      \ "inactive": {
      \   "left": [  [ "filename" ] ],
      \   "right": [ [ ],
      \              [ ],
      \              [ "fileformat", "lineinfo" ] ],
      \ },
      \ "component_function": {
      \   "fileformat": "LightlineFileFormat",
      \   "readonly": "LightlineReadonly",
      \ },
      \ "separator": { "left": "", "right": "" },
      \ "subseparator": { "left": "", "right": "" },
      \ }

" let g:lightline#coc#indicator_warnings = " "
" let g:lightline#coc#indicator_errors = " "
" let g:lightline#coc#indicator_ok = ""

" call lightline#coc#register()

function! LightlineFileFormat()
  if !has('nvim')
    return winwidth(0) > 70 ? (WebDevIconsGetFileFormatSymbol()) : ''
  else
    return ''
  endif
endfunction

function LightlineReadonly()
  return &ft !~? 'help\|vimfiler' && &readonly ? '' : ''
endfunction

" FIXME: Why does it need to be here instead of up higher?
if !has('nvim')
  source ~/.vim/tabline.vim
else
  " source ~/.vim/tabline-n.vim
endif

" UltiSnips
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

" Ag
let g:ag_working_path_mode="r"

" BufExplorer
let g:bufExplorerShowDirectories=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerSplitRight=0

" Terminus
" let g:TerminusInsertCursorShape=2

" Incsearch (Fuzzy)
" map /  <Plug>(incsearch-forward)
" map ?  <Plug>(incsearch-backward)
" map g/ <Plug>(incsearch-stay)

" map z/  <Plug>(incsearch-fuzzy-/)
" map z?  <Plug>(incsearch-fuzzy-?)
" map z/ <Plug>(incsearch-fuzzy-stay)

" Incsearch - noh after motion
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
" map *  <Plug>(incsearch-nohl-*)
" map #  <Plug>(incsearch-nohl-#)
" map g* <Plug>(incsearch-nohl-g*)
" map g# <Plug>(incsearch-nohl-g#)

" fzf
if !has('nvim')
  imap <c-x><c-k> <plug>(fzf-complete-word)
  imap <c-x><c-f> <plug>(fzf-complete-path)
  noremap <C-t> :Files<cr>
  noremap <C-p> :Ag<cr>
  " noremap <leader>t :Buffers<cr>

  let g:fzf_preview_window = ['right:50%', 'ctrl-/']
endif

" CSS completion
augroup css
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci
augroup END

" Markdown
augroup markdown
  autocmd!
  autocmd FileType markdown setlocal wrap lbr conceallevel=2 spell

  " This is almost always what I meant anyway.
  autocmd FileType markdown noremap j gj
  autocmd FileType markdown noremap k gk
  autocmd FileType markdown nnoremap $ g$
augroup END

" GitGutter

let g:gitgutter_sign_added = "▎"
let g:gitgutter_sign_modified = "▎"
let g:gitgutter_sign_removed = "\uf458"
let g:gitgutter_sign_removed_first_line = "\uf458"
let g:gitgutter_sign_modified_removed = "\uf459"

" Coverage
" let g:coverage_interval = 1000
" let g:coverage_json_report_path = 'coverage/coverage-final.json'
" let g:coverage_show_covered = 1

" vim-closetag
let g:closetag_filenames = '*.html'
let g:closetag_xhtml_filenames = '*.html'

" CSS3 Syntax
augroup VimCSS3Syntax
  autocmd!

  autocmd FileType css setlocal iskeyword+=-
augroup END

" COC

if !has('nvim')
  let g:coc_snippet_next = '<tab>'

  inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1):
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

  " Make <CR> to accept selected completion item or notify coc.nvim to format
  " <C-g>u breaks current undo, please make your own choice.
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
  inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

  nmap <leader>rn <Plug>(coc-rename)
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gr <Plug>(coc-references)
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)
  nmap <silent> <leader>qf :CocFix<CR>
  nmap <silent><nowait> <space>s  :<C-u>CocList -A -I symbols<cr>

  command! -nargs=0 Prettier :CocCommand prettier.formatFile
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " COC lists using fzf
  " nnoremap <silent> <space>s       :<C-u>CocFzfList symbols<CR>

  autocmd CursorHold * silent call CocActionAsync('highlight')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

  " hi! link CocErrorHighlight ErrorMsg
  " hi! link CocErrorSign ErrorMsg
  hi! CocErrorHighlight guifg=#f92672 gui=undercurl cterm=undercurl
  hi! CocErrorSign guifg=#f92672
  nmap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocActionAsync('doHover')
    endif
  endfunction
endif

" ALE
" let g:ale_fix_on_save = 1
" let g:ale_lint_on_save = 1
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_insert_leave = 0
" let g:ale_lint_on_enter = 0

" let g:ale_fixers = {
"       \ '*': ['remove_trailing_lines', 'trim_whitespace'],
"       \ 'typescriptreact': ['prettier', 'eslint'],
"       \}

" Dart LSC
let g:lsc_auto_map = v:true

" OmniSharp
augroup omnisharp_commands
  autocmd!

  autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> <buffer> K <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> <space>s <Plug>(omnisharp_find_symbol)
augroup END

" vim-matchup
let g:matchup_matchparen_offscreen = {'method': "popup"}

" Telescope (nvim only)
if has('nvim')
  noremap <C-t> <cmd>lua require"telescope.builtin".git_files(require"telescope.themes".get_dropdown{
        \ find_command="rg --files",
        \ prompt_prefix=" 🔍 ", 
        \ selection_caret=" ",
        \ prompt_title="", 
        \ previewer=false,
        \ winblend=5
        \ })<cr>
  noremap <C-p> <cmd>lua require"telescope.builtin".live_grep(require"telescope.themes".get_dropdown{
        \ prompt_prefix=" 🔍 ", 
        \ selection_caret=" ",
        \ prompt_title="Find in files", 
        \ winblend=5
        \ })<cr>
  noremap <C-s> <cmd>lua require"telescope.builtin".lsp_dynamic_workspace_symbols({
        \ prompt_prefix=" ﬦ ", 
        \ selection_caret=" ",
        \ prompt_title="Symbols", 
        \ winblend=5
        \ })<cr>
  " noremap " <cmd>lua require"telescope.builtin".registers(require"telescope.themes".get_cursor{
  "       \ prompt_prefix=" 📋 ", 
  "       \ selection_caret=" ",
  "       \ prompt_title="Paste from …", 
  "       \ winblend=5,
  "       \ layout_config={ height = 20 }
  "       \ })<cr>
  inoremap <C-r> <cmd>lua require"telescope.builtin".registers(require"telescope.themes".get_cursor{
        \ prompt_prefix=" 📋 ", 
        \ selection_caret=" ",
        \ prompt_title="Paste from …", 
        \ winblend=5,
        \ layout_config={ height = 20 }
        \ })<cr>
endif


if has('nvim')
  " Coq
  " let g:coq_settings = {
  "       \ "auto_start": "shut-up",
  "       \ "limits.completion_manual_timeout": 0.5,
  "       \ "clients.tree_sitter.enabled": v:false,
  "       \ "clients.tmux.enabled": v:false,
  "       \ "clients.buffers.enabled": v:false,
  "       \ "clients.snippets.enabled": v:false,
  "       \ "display.pum.fast_close": v:false,
  "       \ "display.preview.positions": { "north": 2, "south": 4, "east": 1, "west": 3 },
  "       \ "keymap.recommended": v:false,
  "       \ "keymap.jump_to_mark": "",
  "       \ "keymap.bigger_preview": "",
  "       \}

  " inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
  " inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
  " inoremap <silent><expr> <CR> pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"

  " Neo tree
  " nmap <silent> <leader>be :Neotree source=buffers action=show reveal<cr>
  " nmap <silent> <leader>bt :Neotree source=filesystem action=show reveal<cr>

  " DAP
  nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
  nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
  nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
  nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
  nnoremap <silent> <Leader>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>
  nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
  nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
  nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
  nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>

  " Instant Markdown
  let g:instant_markdown_autostart = 0
endif
