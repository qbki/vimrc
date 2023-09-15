function! ToggleLangCheck()
  if &spell
    echo 'Spell checking OFF'
    set nospell
  else
    echo 'Spell checking ON'
    set spell spelllang=ru,en
  endif
endfunction
