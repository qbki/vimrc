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

call plug#begin(stdpath('data') . '/plugged')
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

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

let g:langCheck = 0
function! ToggleLangCheck()
	if g:langCheck == 1
		let g:langCheck = 0
	else
		let g:langCheck = 1
	endif

    if g:langCheck == 1
        echo 'spell checking on'
		set spell spelllang=ru,en
    else
        echo 'spell checking off'
		set nospell
    endif
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<cr>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<cr>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<cr>

nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

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

" ----- Fixed broken highlight -----
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" ----- Directory Tree -----
lua << EOF
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = false,
    icons = {
      show = {
        file = false,
        folder = false,
      },
      glyphs = {
        symlink = "☞",
        modified = "●",
        folder = {
          arrow_closed = "⮞",
          arrow_open = "⮟",
          default = "🗀",
          open = "🗁",
          empty = "⮊",
          empty_open = "⮋",
          symlink = "☞",
          symlink_open = "☟",
        },
      },
    },
  },
  filters = {
    dotfiles = true,
  },
  git = {
    enable = false,
    show_on_dirs = false,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
    icons = {
      hint = "?",
      info = "i",
      warning = "!",
      error = "!",
    },
  },
})
EOF

nnoremap <leader>t :NvimTreeOpen<CR>
nnoremap <leader>f :NvimTreeFindFile<CR>


lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "typescript" },
  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,

    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF
