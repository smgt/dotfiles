call plug#begin('~/.local/share/nvim/plugged')
  " Deps
  Plug 'tpope/vim-rhubarb'           " Depenency for tpope/fugitive

  " General
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  " Plug 'preservim/nerdcommenter'
  Plug 'tpope/vim-commentary'
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'
  Plug 'kyazdani42/nvim-tree.lua' " File tree

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'gregsexton/gitv'

  " Tmux
  Plug 'benmills/vimux'
  Plug 'christoomey/vim-tmux-navigator'

  " Editor improvements
  Plug 'ray-x/guihua.lua', {'do': 'cd lua/fzy && make' }
  Plug 'vim-scripts/ZoomWin'
  Plug 'chentau/marks.nvim'
  "Plug 'sebdah/vim-delve'
  Plug 'junegunn/goyo.vim'

  " Fuzzy file finder
  Plug 'nvim-lua/popup.nvim' " Required by telescope
  Plug 'nvim-lua/plenary.nvim' " Required by telescope
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim' " Faster telescope
  Plug 'nvim-telescope/telescope-symbols.nvim'
  Plug 'nvim-telescope/telescope-dap.nvim' " DAP in telescope

  " Snippets
  " Plug 'hrsh7th/vim-vsnip'
  " Plug 'hrsh7th/vim-vsnip-integ'
  " Plug 'rafamadriz/friendly-snippets'

  " Statusline
  Plug 'hoob3rt/lualine.nvim'

  " Language support
  Plug 'vim-crystal/vim-crystal'
  Plug 'PyGamer0/vim-apl'
  Plug 'baruchel/vim-notebook'
  Plug 'hashivim/vim-terraform'
  Plug 'ellisonleao/glow.nvim'

  " LSP + treesitter plugins
  Plug 'jose-elias-alvarez/null-ls.nvim' " Linters etc
  Plug 'neovim/nvim-lspconfig' " LSP for neovim
  Plug 'williamboman/nvim-lsp-installer' " Install LSP servers
  Plug 'tami5/lspsaga.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Better syntax highlighting
  Plug 'hrsh7th/cmp-nvim-lsp' " Complete lsp
  Plug 'hrsh7th/cmp-buffer' " Complete buffers
  Plug 'hrsh7th/cmp-path' "Complete paths
  Plug 'hrsh7th/cmp-cmdline' " Complete commands
  Plug 'hrsh7th/cmp-vsnip' " Complete vsnip
  Plug 'hrsh7th/nvim-cmp' " Compleation plugin

  " Snippets
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'honza/vim-snippets'

  " Debugging with dap
  Plug 'mfussenegger/nvim-dap'
  Plug 'leoluz/nvim-dap-go'
  Plug 'rcarriga/nvim-dap-ui'

  " Symbol sidebar
  " Plug 'sidebar-nvim/sidebar.nvim'

  " Eye candy
  Plug 'kyazdani42/nvim-web-devicons' " Icons
  Plug 'onsails/lspkind-nvim' " Icons for Completion
  Plug 'junegunn/vim-emoji'
  Plug 'norcalli/nvim-colorizer.lua'

  " Themes
  " neovim support
  Plug 'catppuccin/nvim', {'as': 'catppuccin'}
  Plug 'rakr/vim-one' ", { 'rtp': 'vim' }
  Plug 'marko-cerovac/material.nvim'
  Plug 'sainnhe/sonokai'
  Plug 'sainnhe/edge'
  Plug 'ray-x/aurora'
  Plug 'shaunsingh/moonlight.nvim'
  Plug 'sainnhe/everforest'
  Plug 'dracula/vim'
  Plug 'EdenEast/nightfox.nvim'
  Plug 'folke/tokyonight.nvim'
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'tanvirtin/monokai.nvim'
  Plug 'drewtempelmeyer/palenight.vim'
  Plug 'sainnhe/gruvbox-material'
  Plug 'rose-pine/neovim'
  Plug 'navarasu/onedark.nvim'
  Plug 'RRethy/nvim-base16'
  Plug 'rebelot/kanagawa.nvim'

  " Plug 'liuchengxu/space-vim-theme'
  " Plug 'sonph/onehalf', { 'rtp': 'vim' }
  " Plug 'kyoz/purify', { 'rtp': 'vim' }
  "Plug 'crusoexia/vim-monokai'
  "Plug 'joshdick/onedark.vim'

  " Needs to be loaded at the end
  " Plug 'sheerun/vim-polyglot'

" All of your Plugins must be added before the following line
call plug#end()            " required

set autoindent                    " take indent for new line from previous line
set smartindent                   " enable smart indentation
set autoread                      " reload file if the file changes on the disk
set autowrite                     " write when switching buffers
set autowriteall                  " write on :quit
set clipboard=unnamedplus
set cursorline
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
let mapleader=','

" true colors
set termguicolors
" enable curor coloring from themes
set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor50

" Location of tags file
set tags=./.git/tags,./tags,tags;

" let g:gruvbox_material_background = 'medium'
" let g:gruvbox_material_enable_italic = 1
" let g:gruvbox_material_disable_italic_comment = 0
" colorscheme gruvbox-material

let g:sonokai_style = 'maia'
let g:sonokai_enable_italics = 1
"colorscheme sonokai

let g:everforest_enable_italic = 1
let g:everforest_background = 'hard'
"colorscheme everforest

"colorscheme duskfox

"let g:aurora_italic = 1
"let g:aurora_bold = 1
"colorscheme aurora

" colorscheme dracula

let g:palenight_terminal_italics=1
"colorscheme palenight
"

let g:tokyonight_style = 'storm'
let g:tokyonight_sidebars = [ 'Sidebar', 'NvimTree' ]
colorscheme tokyonight
"colorscheme kanagawa

"----
"  Theme: papercolor
"----
" set background=light
" colorscheme PaperColor
" "let g:airline_theme='papercolor'
" let g:PaperColor_Theme_Options = {
"   \   'theme': {
"   \     'default': {
"   \       'override' : {
"   \         'spellbad':   ['#000000', '0'],
"   \         'spellcap':   ['#000000', '0'],
"   \       }
"   \     }
"   \   }
"   \ }

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
if has('autocmd')
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

au BufRead,BufNewFile {Guardfile,vagranfile,Vagrantfile,Gemfile,Rakefile,Thorfile,config.ru} set ft=ruby
au BufRead,BufNewFile *.cr set ft=crystal

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
let g:delve_backend = 'native'


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
let g:ruby_host_prog = '/usr/bin/ruby'

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
let g:go_fmt_command = 'goimports'

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
let g:go_metalinter_command = ''
let g:go_metalinter_deadline = '5s'
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
let g:go_addtags_transform = 'snakecase'

let test#strategy = 'tslime'

let g:terraform_fmt_on_save=1

au FileType make set noexpandtab

let g:notebook_cmd = 'dyalog'
let g:notebook_stop = ')off'
let g:notebook_send0 = ''
let g:notebook_send = "'VIMDYALOGAPLNOTEBOOK'"
let g:notebook_detect = 'VIMDYALOGAPLNOTEBOOK'
let g:notebook_shell_internal = '/bin/sh'
