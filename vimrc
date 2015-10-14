if has('gui_running')
  set guifont=Droid\ Sans\ Mono\ 10
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar
endif

" автоматически перезагружает конфигурацию vim после сохранения файла
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

Plugin 'vundle'
Plugin 'git://github.com/scrooloose/nerdtree.git'
Plugin 'git://github.com/scrooloose/nerdcommenter.git'
Plugin 'git://github.com/tpope/vim-surround.git'
Plugin 'bufexplorer.zip'
Plugin 'PDV--phpDocumentor-for-Vim'
Plugin 'git://github.com/ervandew/supertab.git'
Plugin 'git://github.com/StanAngeloff/php.vim.git'
Plugin 'git://github.com/othree/html5.vim.git'
Plugin 'git://github.com/msanders/snipmate.vim.git'
Plugin 'git://github.com/majutsushi/tagbar.git'
Plugin 'https://github.com/mattn/emmet-vim.git'
Plugin 'git://github.com/scrooloose/syntastic.git'
Plugin 'https://github.com/othree/javascript-libraries-syntax.vim.git'
" JavaScript
" To HTML tag jump
Plugin 'https://github.com/vim-scripts/matchit.zip.git'

call vundle#end() 
filetype plugin indent on " обязательно! автоматическое определение индентации в файлах.

" +++ Цветовая схема +++
" source = http://vimcolorschemetest.googlecode.com/svn/colors/rootwater.vim
colorscheme rootwater

" nnoremap y :YcmForceCompileAndDiagnostics
" nnoremap pg :YcmCompleter GoToDefinitionElseDeclaration
" nnoremap pd :YcmCompleter GoToDefinition
" nnoremap pc :YcmCompleter GoToDeclaration
let g:ycm_confirm_extra_conf = 0

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
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" +++ Подсветка синтаксиса +++
syntax on

" +++ Поддержка PHP +++
let g:tagbar_phpctags_bin='~/.vim/phpctags/phpctags'

function! SetPHPHotKeys()
	inoremap <M-d> <ESC>:call PhpDocSingle()<CR>i
	nnoremap <M-d> :call PhpDocSingle()<CR> 
	vnoremap <M-d> :call PhpDocRange()<CR> 
endfunction

autocmd FileType php call SetPHPHotKeys()

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
inoremap <F5> <ESC>"+pi
" copy to clipboard
vnoremap <F4> "+y
" change language
inoremap <C-l> <C-^>

