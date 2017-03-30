set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'https://github.com/Valloric/YouCompleteMe'
Plugin 'marijnh/tern_for_vim'
call vundle#end()            " required
" enable filetypes
filetype plugin indent on     " required!

"256 color
set t_Co=256
"UTF-8
set encoding=utf-8
"Presentation
colorscheme delek

" show line number
set number

"set coloration for language
if has("syntax")
    syntax on
endif
"Completion
set omnifunc=syntaxcomplete#Complete
