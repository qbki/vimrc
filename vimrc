if has('gui_running')
  "set guifont=Droid\ Sans\ Mono\ 10
  set guifont=Deja\ Vu\ Sans\ Mono\ 13
  "set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar
endif

" автоматически перезагружает конфигурацию vim после сохранения файла
"
" настроек, позволяя применять даже плагины без перезагрузки редактора
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

set backup
set backupdir=$HOME/.vim/backup/
set directory=$HOME/.vim/backup/
silent execute '!mkdir -p $HOME/.vim/backup'
set noswapfile

" +++ Пакетный менеджер +++
" source = http://habrahabr.ru/post/148549/
set nocompatible
filetype off " обязательно!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'git://github.com/scrooloose/nerdtree.git'
Plugin 'git://github.com/scrooloose/nerdcommenter.git'
Plugin 'git://github.com/tpope/vim-surround.git'
Plugin 'bufexplorer.zip'
Plugin 'git://github.com/ervandew/supertab.git'
Plugin 'git://github.com/othree/html5.vim.git'
Plugin 'git://github.com/msanders/snipmate.vim.git'
Plugin 'git://github.com/majutsushi/tagbar.git'
Plugin 'https://github.com/mattn/emmet-vim.git'
Plugin 'https://github.com/Valloric/YouCompleteMe.git'
Plugin 'https://github.com/tpope/vim-fugitive.git'
" Plugin 'https://github.com/w0rp/ale.git'
Plugin 'git://github.com/scrooloose/syntastic.git'
" JavaScript
" Plugin 'https://github.com/othree/javascript-libraries-syntax.vim.git'
" Plugin 'https://github.com/sheerun/vim-polyglot.git' - broken
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'mtscout6/syntastic-local-eslint.vim'
" TypeScript
Plugin 'https://github.com/leafgarland/typescript-vim.git'
" To HTML tag jump
Plugin 'https://github.com/vim-scripts/matchit.zip.git'
" Rust
Plugin 'rust-lang/rust.vim'
" GLSL
Plugin 'https://github.com/tikhomirov/vim-glsl'
Plugin 'mileszs/ack.vim'
" Python
" Plugin 'klen/python-mode'
" Vue
" Plugin 'https://github.com/natebosch/vim-lsc.git'
call vundle#end() 

filetype plugin indent on " обязательно! автоматическое определение индентации в файлах.

" +++ Цветовая схема +++
" source = http://vimcolorschemetest.googlecode.com/svn/colors/rootwater.vim
colorscheme rootwater

" nnoremap y :YcmForceCompileAndDiagnostics
" nnoremap pg :YcmCompleter GoToDefinitionElseDeclaration
" nnoremap pd :YcmCompleter GoToDefinition
" nnoremap pc :YcmCompleter GoToDeclaration

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" +++ Поддержка русского языка +++
" source = http://www.allaboutvim.ru/2008/01/blog-post.html
set keymap=russian-jcukenwin 
" по умолчанию - латинская раскладка 
set iminsert=0 
" по умолчанию - латинская раскладка при поиске 
set imsearch=0 

" +++ Отступы +++
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smartindent

" +++ Подсветка синтаксиса +++
syntax on

" +++ Проверка орфографии +++
" TODO подгадил в глобальное пространство имен, узнать больше про скриптинг и
" поменять эту функцию
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

" +++ HotKeys +++
nnoremap <F8> :NERDTreeToggle<CR>
nnoremap <F9> :TagbarToggle<CR> 
nnoremap <F7> :call ToggleLangCheck()<CR>
" paste from clipboard
nnoremap <F5> "+p
nnoremap ,g :YcmCompleter GoToDeclaration<CR>

inoremap <F5> <ESC>"+pi
" copy to clipboard
vnoremap <F4> "+y
" change language
inoremap <C-l> <C-^>

noremap <F2> <ESC>:w<CR>:!python3 %<CR><CR>

" Use Node.js for JavaScript interpretation
let $JS_CMD='node'

"if executable('node_modules/.bin/eslint')
let g:syntastic_javascript_checkers=['eslint']
"let g:syntastic_typescript_checkers=['tslint']
"endif
let g:syntastic_typescript_tslint_exe = "npx tslint"
let g:syntastic_typescript_checkers = ['tslint']

" autocmd BufRead,BufNewFile /home/gray/projects/work setlocal ts=4 sw=4

let g:NERDSpaceDelims = 1

let g:racer_experimental_completer = 1
let g:clang_complete_macros = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_rust_src_path = '/home/gray/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ale_linters = {'rust': ['rls']}
let g:ale_rust_rls_executable = '/home/gray/.cargo/bin/rls'

