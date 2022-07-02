let g:lightline = {
      \ 'colorscheme': 'sonokai',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \ 'right': [ ['neomake_warnings', 'neomake_errors','neomake_infos', 'neomake_ok'],
      \            [ 'lineinfo' ],
      \            [ 'percent' ],
      \            [ 'fileformat', 'fileencoding', 'filetype' ],
      \     ],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ 'component_type': {
      \   'neomake_warnings': 'warning',
      \   'neomake_errors': 'error',
      \   'neomake_ok': 'left',
      \ },
      \ 'component_expand': {
      \   'neomake_infos': 'lightline#neomake#infos',
      \   'neomake_warnings': 'lightline#neomake#warnings',
      \   'neomake_errors': 'lightline#neomake#errors',
      \   'neomake_ok': 'lightline#neomake#ok',
      \ },
      \ }
