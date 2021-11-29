call plug#begin('~/.local/share/nvim/plugged')
  " Deps
  Plug 'tpope/vim-rhubarb'           " Depenency for tpope/fugitive

  " General
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'gregsexton/gitv'

  Plug 'preservim/nerdcommenter'

  Plug 'benmills/vimux'
  Plug 'christoomey/vim-tmux-navigator'

  Plug 'sebdah/vim-delve'
  Plug 'junegunn/vim-emoji'
  Plug 'junegunn/goyo.vim'
  Plug 'ap/vim-css-color'

  " Editor improvements
  Plug 'neomake/neomake'
  Plug 'vim-scripts/ZoomWin'


  " Fuzzy file finder
  Plug 'nvim-lua/popup.nvim' " Required by telescope
  Plug 'nvim-lua/plenary.nvim' " Required by telescope
  Plug 'nvim-telescope/telescope.nvim'
  " Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  " Plug 'junegunn/fzf.vim'

  " Snippets
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'
  Plug 'rafamadriz/friendly-snippets'

  " Statusline
  " Plug 'hoob3rt/lualine.nvim'
  Plug 'itchyny/lightline.vim'
  Plug 'sinetoami/lightline-neomake'

  " Language support
  " Plug 'vim-ruby/vim-ruby'
  Plug 'elixir-lang/vim-elixir'
  Plug 'ekalinin/Dockerfile.vim'
  Plug 'elzr/vim-json'
  " Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'tags': '*'}
  Plug 'mattn/vim-goimports'
  Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }
  Plug 'vim-python/python-syntax'
  Plug 'rust-lang/rust.vim'
  Plug 'hashivim/vim-terraform'

  " LSP + treesitter plugins
  Plug 'neovim/nvim-lspconfig' " LSP for neovim
  Plug 'glepnir/lspsaga.nvim' " Better ui for LSP
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Better syntax highlighting
  Plug 'hrsh7th/cmp-nvim-lsp' " Completion
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-vsnip' " Completion for vsnip
  Plug 'hrsh7th/vim-vsnip'
  Plug 'onsails/lspkind-nvim' " Icons for Completion

  " Needs to be loaded at the end
  "Plug 'sheerun/vim-polyglot'

  " Eye candy
  Plug 'kyazdani42/nvim-web-devicons'

  " Themes
  Plug 'sainnhe/everforest'
  Plug 'liuchengxu/space-vim-theme'
  Plug 'sonph/onehalf', { 'rtp': 'vim' }
  " Plug 'kyoz/purify', { 'rtp': 'vim' }
  "Plug 'crusoexia/vim-monokai'
  "Plug 'joshdick/onedark.vim'
  Plug 'rakr/vim-one' ", { 'rtp': 'vim' }
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'kaicataldo/material.vim', { 'branch': 'main' }
  Plug 'sainnhe/edge'
  Plug 'connorholyday/vim-snazzy'
  Plug 'sainnhe/sonokai'
  Plug 'phanviet/vim-monokai-pro'
  Plug 'sickill/vim-monokai'
  Plug 'tomasr/molokai'
  Plug 'dracula/vim'

  " Needs to be loaded at the end
  Plug 'sheerun/vim-polyglot'

" All of your Plugins must be added before the following line
call plug#end()            " required

set autoindent                    " take indent for new line from previous line
set smartindent                   " enable smart indentation
set autoread                      " reload file if the file changes on the disk
set autowrite                     " write when switching buffers
set autowriteall                  " write on :quit
set clipboard=unnamedplus
"set colorcolumn=81                " highlight the 80th column as an indicator
"set completeopt-=preview          " remove the horrendous preview window
set completeopt=menu,menuone,noselect " from hrsh7th/cmp
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

" true colors
set termguicolors

" Location of tags file
set tags=./.git/tags,./tags,tags;

let g:sonokai_style = 'shusia'
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1
colorscheme dracula

"----
"  Theme: Space dark
"----
"let g:space_vim_theme_background = 235
"color space_vim_theme

" Grey comments instead of green
"hi Comment guifg=#5C6370 ctermfg=59

" Fix background in ruler and gutter
"hi LineNr ctermbg=NONE guibg=NONE

"----
"  Theme: onehalf
"---
"set cursorline
"color onehalfdark
"let g:airline_theme='onehalfdark'

"----
"  Theme: vim-one
"---
"colorscheme one
"set background=dark
"let g:airline_theme='onedark'

"----
"  Theme: purify
"---
"color purify
"let g:airline_theme='purify'

"----
"  Theme: palenight
"---
"set background=dark
"colorscheme palenight
"let g:airline_theme = "palenight"

"----
"  Theme: monokai
"----
"colorscheme monokai
"let g:airline_theme='monokai_tasty'

" Clear the background
"highlight Normal guibg=NONE ctermbg=NONE
"hi LineNr     ctermbg=NONE guibg=NONE
"hi SignColumn ctermbg=NONE guibg=NONE

"----
"  Theme: palenight
"----
"set background=dark
"colorscheme palenight
"let g:airline_theme='palenight'

"" Italics for my favorite color scheme
"let g:palenight_terminal_italics=1
"

"----
"  Theme: papercolor
"----
"set background=light
"colorscheme PaperColor
"let g:airline_theme='papercolor'
let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default': {
  \       'override' : {
  \         'spellbad':   ['#000000', '0'],
  \         'spellcap':   ['#000000', '0'],
  \       }
  \     }
  \   }
  \ }

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
" <Ctrl-l> redraws the screen and removes any search highlighting.
" nnoremap <silent> <C-l> :nohl<CR><C-l>
" nnoremap <silent> * :BLines <C-R><C-W>*<CR>
" nnoremap <silent> <leader>* :Rg <C-R><C-W>*<CR>
":nnoremap * /\<<C-R>=expand('<cword>')<CR>\><CR>

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
" Plugin: NerdComment
"----------------------------------------------
let g:NERDSpaceDelims = 1

"----------------------------------------------
" Plugin: ZoomWin configuration
"----------------------------------------------
map <Leader>z :ZoomWin<CR>

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
" Plugin: sebdah/vim-delve
"----------------------------------------------
" Set the Delve backend.
let g:delve_backend = "native"


"----------------------------------------------
" Plugin: vimwiki
"----------------------------------------------
" Set path to Syncthing path
let g:vimwiki_list = [{'path': '~/Sync/vimwiki/'}]


"----------------------------------------------
" Language: Mutt
"----------------------------------------------
au BufRead /tmp/mutt-* set tw=72

"----------------------------------------------
" Plugin: vimux
"----------------------------------------------
" Emulate tslime behavior to work with a REPL
"function! VimuxSlime()
"  call VimuxSendText(@v)
"  call VimuxSendKeys("Enter")
"endfunction

" If text is selected, save it in the v buffer and send that buffer it to tmux
"vmap <C-c><C-c> "vy :call VimuxSlime()<CR>

" Select current paragraph and send it to tmux
"nmap <C-c><C-c> vip :call VimuxSlime()<CR>

"----------------------------------------------
" Language: Python
"----------------------------------------------
let g:python3_host_prog = '/usr/bin/python'

"----------------------------------------------
" Language: Ruby
"----------------------------------------------
let g:ruby_host_prog = '/home/simon/.asdf/installs/ruby/2.7.2/bin/neovim-ruby-host'

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
" au Filetype go nmap <leader>ga <Plug>(go-alternate-edit)
" au Filetype go nmap <leader>gah <Plug>(go-alternate-split)
" au Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)
" au FileType go nmap <leader>gt :GoDeclsDir<cr>
" au FileType go nmap <leader>gc <Plug>(go-coverage-toggle)
" au FileType go nmap <leader>gd <Plug>(go-def)
" au FileType go nmap <leader>gdv <Plug>(go-def-vertical)
" au FileType go nmap <leader>gdh <Plug>(go-def-split)
" au FileType go nmap <leader>gD <Plug>(go-doc)
" au FileType go nmap <leader>gDv <Plug>(go-doc-vertical)

" Run goimports when running gofmt
let g:go_fmt_command = "goimports"

" Use fzf for declarations
let g:go_decls_mode = 'fzf'

" Go def for definitions
" let g:go_def_mode = 'gopls'

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

let test#strategy = "tslime"

au FileType make set noexpandtab
