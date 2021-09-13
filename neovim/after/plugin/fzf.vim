if !exists('g:fzf_layout') | finish | endif

map <Leader>p :Files<CR>
map <Leader>b :Buffers<CR>
map <Leader>l :Lines<CR>
let $FZF_DEFAULT_COMMAND = 'rg --hidden --files -g "!.git/*"'
