"----------------------------------------------
" Plugin: neomake/neomake
"----------------------------------------------
" Configure signs.
let g:neomake_error_sign   = {'text': '', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': '', 'texthl': 'NeomakeWarningSign'}
let g:neomake_message_sign = {'text': '➤', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign    = {'text': '', 'texthl': 'NeomakeInfoSign'}

let g:neomake_remove_invalid_entries=1
"let g:neomake_open_list = 2

"let g:neomake_highlight_lines = 0
"let g:neomake_highlight_columns = 1
"let g:neomake_place_signs = 0

let g:neomake_virtualtext_prefix = ' ⯌ '

hi default link NeomakeVirtualtextError SpellBad
hi default link NeomakeVirtualtextWarning SpellCap
hi default link NeomakeErrorSign SpellBad
hi default link NeomakeWarningSign SpellCap

"augroup my_neomake_highlights
    "au!
    "autocmd ColorScheme *
      "\ highlight link NeomakeError SpellBad |
      "\ highlight link NeomakeWarning SpellCap guisp=White
    "augroup END

" When writing a buffer (no delay).
" call neomake#configure#automake('wr')
call neomake#configure#automake('rw', 1000)

let g:neomake_c_enabled_makers=['gcc', 'cppcheck']
let g:neomake_go_enabled_makers = [ 'go', 'golangci_lint' ]

"let g:neomake_go_enabled_makers = []
"let g:neomake_go_enabled_makers = [ 'go', 'golangci_lint' ]
"let g:neomake_go_golangci_lint_maker = {
  "\ 'exe': 'golangci-lint',
  "\ 'args': [
  "\   'run',
  "\   '--out-format=line-number',
  "\   '--print-issued-lines=false',
  "\   '-E', 'misspell',
  "\   '-E', 'dupl',
  "\   '-E', 'gosec',
  "\   '%t',
  "\ ],
  "\ 'output_stream': 'stdout',
  "\ 'append_file': 0,
  "\ 'cwd': '%:h',
  "\ 'errorformat':
  "\   '%f:%l:%c: %m'
  "\ }
