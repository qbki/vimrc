" TODO
" + Менеджер пакетов.
" + Толковая подсветка исходного кода.
" - Навигация.
"   + по буферам = bufexplorer
"   + по файлам = NERDTree "   - по коду
" - Проверка орфографии: английский, русский.
" + Научить понимать русский язык.
"   + раскладка
" - Научить понимать PHP.
"   + комментирование = PDV--phpDocumentor-for-Vim
" - Научить понимать HTML (4, 5).
" - Научить понимать CSS.
" - Научить понимать JavaScript (включая JQuery, node.js)
" - Научить работать с БД.
"   - Подключение к БД.
"   - Автодополнение.
"   - Запросы.
" - Адаптировать для KDE.
" понимать: индентация, автодополнение, комментирование, подсветка ошибок на
" лету. [список не полон]

if has('gui_running')
  set guifont=Droid\ Sans\ Mono\ 10
endif

" автоматически перезагружает конфигурацию vim после сохранения файла
" настроек, позволяя применять даже плагины без перезагрузки редактора
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

" +++ Пакетный менеджер +++
" source = http://habrahabr.ru/post/148549/
set nocompatible
filetype off " обязательно!

set rtp+=~/.vim/bundle/vundle/

call vundle#rc()

Bundle 'vundle'
Bundle 'https://github.com/Valloric/YouCompleteMe.git'
" взял с github т.к. с vim.org не работает меню для управления элементами
" каталога по нажатию клавиши [m].
Bundle 'git://github.com/scrooloose/nerdtree.git'
Bundle 'git://github.com/scrooloose/nerdcommenter.git'
Bundle 'git://github.com/tpope/vim-surround.git'
Bundle 'bufexplorer.zip'
Bundle 'PDV--phpDocumentor-for-Vim'
" Bundle 'git://github.com/ervandew/supertab.git'
Bundle 'git://github.com/StanAngeloff/php.vim.git'
Bundle 'git://github.com/othree/html5.vim.git'
" Bundle 'git://github.com/msanders/snipmate.vim.git'
Bundle 'git://github.com/majutsushi/tagbar.git'
Bundle 'git://github.com/mattn/zencoding-vim.git'
Bundle 'git://github.com/scrooloose/syntastic.git'
Bundle 'https://github.com/othree/javascript-libraries-syntax.vim.git'
" Bundle 'SyntaxComplete'
" Bundle 'clang-complete'
" Bundle 'Cpp11-Syntax-Support'
" Bundle 'OmniCppComplete'
" Ruby & Rails
Bundle 'rails.vim'
" JavaScript
Bundle 'javascript-libraries-syntax.vim'
Bundle 'https://github.com/SirVer/ultisnips.git'

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
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smartindent

" +++ Подсветка синтаксиса
syntax on

" +++ Поддержка PHP +++
let g:tagbar_phpctags_bin='~/.vim/phpctags/phpctags'

function! SetPHPHotKeys()
	inoremap <M-d> <ESC>:call PhpDocSingle()<CR>i
	nnoremap <M-d> :call PhpDocSingle()<CR> 
	vnoremap <M-d> :call PhpDocRange()<CR> 
endfunction

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
		set spell spelllang=ru,en
  else
		set nospell
  endif

endfunction

" +++ HotKeys +++
nmap <F8> :NERDTreeToggle<CR>
nmap <F9> :TagbarToggle<CR> 
nmap <F7> :call ToggleLangCheck()<CR>
nmap <F5> "+p
imap <F5> <ESC>"+pi
vmap <F4> "+y

autocmd FileType php call SetPHPHotKeys()
