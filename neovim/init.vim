call plug#begin('~/.config/nvim/plugged')
  " Deps
  Plug 'tpope/vim-rhubarb'           " Depenency for tpope/fugitive

  " General
  Plug 'bling/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'tpope/vim-fugitive'
  Plug 'gregsexton/gitv'
  Plug 'scrooloose/nerdtree'
  Plug 'preservim/nerdcommenter'
  Plug 'jgdavey/tslime.vim'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'vim-scripts/ZoomWin'
  Plug 'majutsushi/tagbar'
  Plug 'junegunn/fzf.vim'
  Plug 'janko/vim-test'
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'sebdah/vim-delve'
  Plug 'junegunn/vim-emoji'
  Plug 'neomake/neomake'
  Plug 'vimwiki/vimwiki'
  Plug 'ludovicchabant/vim-gutentags'

  " Vim only plugins
  if !has('nvim')
    Plug 'Shougo/vimproc.vim', {'do' : 'make'}  " Needed to make sebdah/vim-delve work on Vim
    Plug 'Shougo/vimshell.vim'                  " Needed to make sebdah/vim-delve work on Vim
  endif

  " Language support
  Plug 'vim-ruby/vim-ruby'
  Plug 'elixir-lang/vim-elixir'
  Plug 'ekalinin/Dockerfile.vim'
  Plug 'elzr/vim-json'
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'tags': '*'}
  Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
  Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }

  " Plug 'dense-analysis/ale'

  " Needs to be loaded at the end
  " Plug 'sheerun/vim-polyglot'

  " Themes
  Plug 'liuchengxu/space-vim-dark'
  Plug 'ajmwagar/vim-deus'
  Plug 'sonph/onehalf'
  Plug 'rakr/vim-one', { 'rtp': 'vim' }
  Plug 'kyoz/purify', { 'rtp': 'vim' }
  Plug 'drewtempelmeyer/palenight.vim'

" All of your Plugins must be added before the following line
call plug#end()            " required

set autoindent                    " take indent for new line from previous line
set smartindent                   " enable smart indentation
set autoread                      " reload file if the file changes on the disk
set autowrite                     " write when switching buffers
set autowriteall                  " write on :quit
set clipboard=unnamedplus
"set colorcolumn=81                " highlight the 80th column as an indicator
set completeopt-=preview          " remove the horrendous preview window
"set cursorline                    " highlight the current line for the cursor
set encoding=utf-8
set expandtab                     " expands tabs to spaces
set softtabstop=2
set tabstop=2
set shiftwidth=2
set list                          " show trailing whitespace
set listchars=tab:\|\ ,trail:▫
set nospell                       " disable spelling
set noswapfile                    " disable swapfile usage
set nowrap
set noerrorbells                  " No bells!
set novisualbell                  " I said, no bells!
set number                        " show number ruler
"set relativenumber                " show relative numbers in the ruler
set ruler
set formatoptions=tcqronj         " set vims text formatting options
set title                         " let vim set the terminal title
set updatetime=100                " redraw the status bar often

set nocompatible              " be iMproved, required
filetype plugin indent on    " required

set fileformat=unix
set backspace=indent,eol,start
syntax on
let mapleader=","

"set term=builtin_ansi
if !has('nvim')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set term=screen-256color
  set termguicolors
endif

" 256 colors in terminal
set t_Co=256

" true colors
if (has("termguicolors"))
  set termguicolors
endif

" Location of tags file
set tags=./.git/tags,./tags,tags;

"----
"  Theme: Space dark
"----
"let g:space_vim_dark_background = 235
"color space-vim-dark
"let g:airline_theme='violet'

" Grey comments instead of green
"hi Comment guifg=#5C6370 ctermfg=59

" Fix background in ruler and gutter
"hi LineNr ctermbg=NONE guibg=NONE

"----
"  Theme: onehalf
"---
"set cursorline
"color onehalflight
"let g:airline_theme='onehalfdark'

"----
"  Theme: vim-one
"---
"colorscheme one
"set background=dark
"let g:airline_theme='one'

"----
"  Theme: purify
"---
"color purify
"let g:airline_theme='purify'

"----
"  Theme: palenight
"---
set background=dark
colorscheme palenight
let g:airline_theme = "palenight"

"----
"  Theme: palenight
"----
"set background=dark
"colorscheme palenight
"let g:airline_theme='palenight'

"" Italics for my favorite color scheme
"let g:palenight_terminal_italics=1

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>


" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

au BufRead,BufNewFile {Guardfile,vagranfile,Vagrantfile,Gemfile,Rakefile,Thorfile,config.ru} set ft=ruby

" Bubble single lines
" nmap <C-k> [e
" nmap <C-j> ]e

" Bubble multiple lines
"vmap <C-k> [egv
"vmap <C-j> ]egv

" Disable arrow keys
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" Map keys to change tabs
noremap <C-p> :tabnext<CR>
noremap <C-o> :tabprev<CR>

" Use modeline overrides
" set modeline
" set modelines=10
"
" set showtabline=1

"----------------------------------------------
" Plugin: fzf
"----------------------------------------------
map <Leader>p :Files<CR>
map <Leader>b :Buffers<CR>
map <Leader>l :Lines<CR>
map <Leader>t :Tags<CR>

"----------------------------------------------
" Plugin: ZoomWin configuration
"----------------------------------------------
map <Leader>z :ZoomWin<CR>

"----------------------------------------------
" Plugin: tagbar
"----------------------------------------------
map <Leader>o :TagbarToggle<CR>

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>

" command! -nargs=1 Execute
"       \ | execute ':execute '.<q-args>
"       \ | execute ':redraw!'

"----------------------------------------------
" Plugin: Tmux navigator
"----------------------------------------------
" tmux will send xterm-style keys when its xterm-keys option is on.
if &term =~ '^screen'
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" Tmux vim integration
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1

" Move between splits with ctrl+h,j,k,l
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>

"----------------------------------------------
" Plugin: Ultisnips
"----------------------------------------------
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"----------------------------------------------
" Plugin: neomake/neomake
"----------------------------------------------
" Configure signs.
let g:neomake_error_sign   = {'text': '✖', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': '∆', 'texthl': 'NeomakeWarningSign'}
let g:neomake_message_sign = {'text': '➤', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign    = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}

let g:neomake_remove_invalid_entries=1


" When writing a buffer (no delay).
call neomake#configure#automake('wr')

"----------------------------------------------
" Plugin: sebdah/vim-delve
"----------------------------------------------
" Set the Delve backend.
let g:delve_backend = "native"


"----------------------------------------------
" Plugin: zchee/deoplete-go
"----------------------------------------------
" Enable completing on startup
let g:deoplete#enable_at_startup = 1
" Enable completing of go pointers
let g:deoplete#sources#go#pointer = 1

" Enable autocomplete of unimported packages
let g:deoplete#sources#go#unimported_packages = 0

let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

" Use tab for compleating
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"


"----------------------------------------------
" Plugin: vimwiki
"----------------------------------------------
" Set path to Syncthing path
let g:vimwiki_list = [{'path': '~/Sync/vimwiki/'}]


"----------------------------------------------
" Language: C
"----------------------------------------------
let g:neomake_c_enabled_makers=['gcc', 'cppcheck']

"----------------------------------------------
" Language: Golang
"----------------------------------------------
"au FileType go set noexpandtab
"au FileType go set shiftwidth=4
"au FileType go set softtabstop=4
"au FileType go set tabstop=4

" Mappings
" au FileType go nmap <F8> :GoMetaLinter<cr>
" au FileType go nmap <F9> :GoCoverageToggle -short<cr>
" au FileType go nmap <F10> :GoTest -short<cr>
" au FileType go nmap <F12> <Plug>(go-def)
au Filetype go nmap <leader>ga <Plug>(go-alternate-edit)
au Filetype go nmap <leader>gah <Plug>(go-alternate-split)
au Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)
au FileType go nmap <leader>gt :GoDeclsDir<cr>
au FileType go nmap <leader>gc <Plug>(go-coverage-toggle)
au FileType go nmap <leader>gd <Plug>(go-def)
au FileType go nmap <leader>gdv <Plug>(go-def-vertical)
au FileType go nmap <leader>gdh <Plug>(go-def-split)
au FileType go nmap <leader>gD <Plug>(go-doc)
au FileType go nmap <leader>gDv <Plug>(go-doc-vertical)

" Run goimports when running gofmt
let g:go_fmt_command = "goimports"

" Enable syntax highlighting per default
" let g:go_highlight_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_structs = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_build_constraints = 1
" let g:go_highlight_extra_types = 1

" Show the progress when running :GoCoverage
let g:go_echo_command_info = 1

" Show type information
"let g:go_auto_type_info = 1

" Highlight variable uses
"let g:go_auto_sameids = 1

" Fix for location list when vim-go is used together with Syntastic
let g:go_list_type = "quickfix"

" Add the failing test name to the output of :GoTest
let g:go_test_show_name = 1

let g:go_gocode_propose_source=1

" gometalinter configuration
let g:go_metalinter_command = ""
let g:go_metalinter_deadline = "5s"
let g:go_metalinter_enabled = [
    \ 'deadcode',
    \ 'gas',
    \ 'goconst',
    \ 'gocyclo',
    \ 'golint',
    \ 'gosimple',
    \ 'ineffassign',
    \ 'vet',
    \ 'vetshadow'
\]

" Set whether the JSON tags should be snakecase or camelcase.
let g:go_addtags_transform = "snakecase"

" neomake configuration for Go.
let g:neomake_go_enabled_makers = [ 'go', 'golangci_lint' ]
let g:neomake_go_golangci_lint_maker = {
  \ 'exe': 'golangci-lint',
  \ 'args': [
  \   'run',
  \   '--out-format=line-number',
  \   '--print-issued-lines=false',
  \   '-E', 'misspell',
  \   '-E', 'dupl',
  \   '-E', 'gosec',
  \   '%t',
  \ ],
  \ 'output_stream': 'stdout',
  \ 'append_file': 0,
  \ 'cwd': '%:h',
  \ 'errorformat':
  \   '%f:%l:%c: %m'
  \ }

" let g:neomake_go_enabled_makers = [ 'go', 'gometalinter' ]
" let g:neomake_go_gometalinter_maker = {
"   \ 'args': [
"   \   '--tests',
"   \   '--enable-gc',
"   \   '--concurrency=3',
"   \   '--fast',
"   \   '-D', 'aligncheck',
"   \   '-D', 'dupl',
"   \   '-D', 'gocyclo',
"   \   '-D', 'gotype',
"   \   '-E', 'misspell',
"   \   '-E', 'unused',
"   \   '%:p:h',
"   \ ],
"   \ 'append_file': 0,
"   \ 'errorformat':
"   \   '%E%f:%l:%c:%trror: %m,' .
"   \   '%W%f:%l:%c:%tarning: %m,' .
"   \   '%E%f:%l::%trror: %m,' .
"   \   '%W%f:%l::%tarning: %m'
"   \ }


let test#strategy = "tslime"

au FileType make set noexpandtab
