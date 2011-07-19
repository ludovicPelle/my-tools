"Remove ALL autocommands for the current group.
au!

"Presentation
colorscheme delek
"colorscheme molokai
" cursor (line under it, reverse color)
set cursorline
" line number
hi LineNr ctermfg=Darkgray guifg=#3D3D3D

"remove whitespace
"if has("autocmd")
"autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif
"endif

if has("syntax")
	syntax on
endif

" Behaviors
set nocompatible
set encoding=utf-8
set backspace=indent,eol,start
set autoindent
set ruler
set number

" enable to move over lines with right and left arrows
set whichwrap=b,s,<,>,[,]

" redefine tabs
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" status line
set statusline=%F%m%=%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [LINE=%l]\ [Col=%v]\ [%p%%]
set laststatus=2

" Backups
set backup                      " Enable creation of backup file.
set backupdir=~/.vim/backups    " Where backups will go.
set directory=~/.vim/tmp        " Where temporary files will go.

"enable memorised position of cursor when reopen the file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g'\"" | endif
endif

" enable filetypes
filetype on
filetype plugin on

" Plugin specifics
"=================

" define my name for snipmate plugin
let g:snips_author = 'Ludovic Pellé <ludovic_pelle@carpe-hora.com>'

" activate symfony for php files
if has("autocmd")
autocmd FileType php set ft=php.symfony
endif

"Ctags
  let g:ctags_path="home/ludovic/.vim/plugin"
  let g:ctags_statusline=1

" language specifics
"===================

" php
if has("autocmd")
autocmd FileType php noremap <F7> :!php -l %<CR>

autocmd FileType php noremap <F9> :!php %<CR>

" symfony
autocmd FileType symfony noremap <F8> :SfSwitchView<CR>

" javascript
autocmd FileType javascript noremap <F7> :!gjslint %<CR>
endif

" Smart completion
function! SmartComplete()
  let line = getline('.') " curline
  let substr = strpart(line, -1, col('.')+1) " from start to cursor
  let substr = matchstr(substr, "[^ \t]*$") " word till cursor
  let has_period = match(substr, '\.') != -1 " position of period, if any
  let has_slash = match(substr, '\/') != -1 " position of slash, if any

  return "\<C-P>" " omnifunc if available
endfunction

" Call smart completion when pressing Ctrl-Space
 inoremap <C-Space> <c-r>=SmartComplete()<CR>
 imap <C-@> <C-Space>
"
" Highlight unwanted spaces
"==========================
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
" Remove trailing whitespaces and ^M chars
"=========================================
autocmd FileType c,cpp,java,php,js,css,html,xml,vim autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))