" Backup file settings
set nobackup
set nowritebackup
set noswapfile

" Command line settings
set cmdheight=1
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Russia language support
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

" Indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Misc
let mapleader = ','
colorscheme rootwater

" Mouse support
set mousemodel=extend
set mouse=a

" NOTE: Modelines have some security vulnerabilities, keep it disabled.
set nomodeline
set nofixendofline
set nocompatible

if has('gui_running')
  set guifont=Deja\ Vu\ Sans\ Mono\ 13
  set guioptions+=m  " menu bar
  set guioptions-=T  " toolbar
  set guioptions-=r  " right-hand scroll bar
  set guioptions-=L  " left-hand scroll bar
endif

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has('patch-8.1.1564')
  set nu
  set signcolumn=number
else
  set signcolumn=yes
endif

let PLUGIN_DIR = stdpath('data') . '/plugged'
let CONFIG_DIR = stdpath('config')

call plug#begin(PLUGIN_DIR)
Plug 'honza/vim-snippets' " snippets for ultisnips
Plug 'jlanzarotta/bufexplorer'
Plug 'mileszs/ack.vim'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'SirVer/ultisnips'
Plug 'tikhomirov/vim-glsl'
Plug 'tpope/vim-fugitive'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'vim-scripts/matchit.zip'
Plug 'puremourning/vimspector'
Plug 'editorconfig/editorconfig-vim'
Plug 'pangloss/vim-javascript'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()
let g:coc_global_extensions = ['coc-eslint',  'coc-json', 'coc-tsserver']

source ./src/utils.vim

" ----- Clipboard -----
" To copy from command line you should type `q:` and yank as usual.
" To past into command line you should type `:<C-r>+`.
nnoremap <leader>y <esc>"+y
nnoremap <leader>p <esc>"+p
nnoremap <leader>P <esc>"+P
vnoremap <leader>y "+y<esc>
vnoremap <leader>p d<esc>"+p
vnoremap <leader>P d<esc>"+P
vnoremap <leader>x x<esc>:let @+=@"<cr>

" ----- Change language -----
nnoremap <C-l> i<C-^><esc>l
inoremap <C-l> <C-^>
cnoremap <C-l> <C-^>

" ----- Misc -----
nnoremap <leader>l :call ToggleLangCheck()<CR>

let g:coc_disable_startup_warning = 1

let g:UltiSnipsExpandTrigger='<C-b>'
let g:UltiSnipsJumpForwardTrigger='<C-j>'
let g:UltiSnipsJumpBackwardTrigger='<C-k>'
let g:UltiSnipsSnippetDirectories=['UltiSnips']

let g:vimspector_enable_mappings = 'HUMAN'

" ----- Fixed broken highlight ----- Remove if treesitter works
" autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
" autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

if isdirectory(PLUGIN_DIR . '/coc.nvim')
  source ./src/coc.nvim.vim
endif

if isdirectory(PLUGIN_DIR . '/nvim-tree.lua')
  source ./src/nvim-tree.lua
  nnoremap <leader>t :NvimTreeOpen<CR>
  nnoremap <leader>f :NvimTreeFindFile<CR>
endif

if isdirectory(PLUGIN_DIR . '/nvim-treesitter')
  source ./src/nvim-treesitter.lua
endif
