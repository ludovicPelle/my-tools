set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}
"
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-scripts/snipMate'
Plugin 'bling/vim-airline'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'leafgarland/typescript-vim'


" All of your Plugins must be added before the following line
call vundle#end()            " required
" enable filetypes
filetype on
filetype plugin on

"Remove ALL autocommands for the current group.
au!

"256 color
set t_Co=256
"UTF-8
set encoding=utf-8
"Presentation
colorscheme distinguished

"Cursor (no underline , konsole bug...
autocmd BufWinEnter * set nocursorline

" line number
hi LineNr ctermfg=Darkgray guifg=#3D3D3D

" remove whitespace
if has("autocmd")
  filetype plugin indent on    " required
  autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif
endif

" case sensitive
set noic

" bash_alias linking
"set shell=/bin/bash\ -i

if has("syntax")
  syntax on
endif

" Behaviors
set nocompatible
set encoding=utf-8
set backspace=indent,eol,start
set autoindent
set foldmethod=indent

"set ruler
"line number
set number

"Enhanced command line completion.
set wildmenu
"Complete files like a shell.
set wildmode=list:longest

" enable to move over lines with right and left arrows
set whichwrap=b,s,<,>,[,]

" redefine tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" status line
set statusline=%F%m%=%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [LINE=%l]\ [Col=%v]\ [%p%%]
set statusline=%F%m%=%r%h%w\ [FT=%Y\ EN=%{&ff}\ POS=%l,%v]
set laststatus=2


"if exists('+colorcolumn')
 " set colorcolumn=80
"else
"  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
"endif
" Backups
"set backup                      " Enable creation of backup file.
"set backupdir=~/.vim/backups    " Where backups will go.
"set directory=~/.vim/tmp        " Where temporary files will go.

"enable memorised position of cursor when reopen the file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g'\"" | endif
endif


" Plugin specifics
"=================

" define my name for snipmate plugin
let g:snips_author = 'Ludovic Pellé <ludovic.pelle@iprotego.com>'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Syntastic
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0
"let g:syntastic_quiet_warnings = 0  " we do want the warnings to be displayed
"let g:syntastic_auto_loc_list = 0   " auto open the errors list
"let g:syntastic_always_populate_loc_list = 0
"let g:syntastic_enable_signs = 0    " open a bar on the left when an error is detected


" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = '>'
"let g:airline#extensions#tabline#left_alt_sep = '>'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_powerline_fonts=0
" unicode symbols
  let g:airline_left_sep = '>'
  let g:airline_right_sep = '<'
  let g:airline_detect_modified=1

" activate symfony for php files
"if has("autocmd")
 "autocmd FileType php set ft=php.symfony
"endif

"Ctags
let g:ctags_path="~/.vim/plugin"
let g:ctags_statusline=1
set nocp
set tags=tags
map <silent><leader><Left> <C-T>
map <silent><leader><Right> <C-]>
map <silent><leader><Up> <C-W>]

" tagbar
let g:tagbar_left = 1           " display the tagbar on the left side
set updatetime=500              " show tags' prototype after 500 milliseconds
let g:tagbar_width = 50         " width in characters of the tagbar
let g:tagbar_autoshowtag = 1    " always show the current tag in the tagbar
let g:tagbar_autofocus = 1      " the cursor will move to the Tagbar window when it is opened.
map <leader>t :TagbarToggle<CR>

" CtrlP behavior
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_regexp = 1
" Open in tab
let g:ctrlp_open_new_file = 't'

" Hotkeys
" =================
let mapleader = ","
"cmap tn tabnew
"cmap vs vsplit
cmap find !ack<space>
cmap tb tabnew<space>

"map <silent><leader><Right> <C-T>
" go to the declaration of a class, variable, ...)
"map <silent><leader><Left> <C-]>
" go back

" Toggle line numbers and fold column for easy copying:
nnoremap <C-l> :set nonumber!<CR>:set foldcolumn=0<CR>
"<C-S-v>:set smartindent!<CR>:set autoindent!<CR>
" Start a substitute
"map <leader>s :%s/

" Start a search
map <leader>h /<C-r>=expand("<cword>")<CR>

" Pull word under cursor into LHS of a substitute (for quick search and
" replace)
nmap <leader>s :%s/<C-r>=expand("<cword>")<CR>/

nmap <leader>S :!replace_all '=expand("<cword>")' '%s#=expand("<cword>")#

"nmap <leader>R :!%s/<C-r>=expand("<cword>")<CR>/

"to force write as sudoer
command W w !sudo tee % > /dev/null

"auto folding
"map <silent><leader>F :EnableFastPHPFolds<Cr>
"map <silent><leader>f :EnablePHPFolds<Cr>
"map <silent><leader>g :DisablePHPFolds<Cr>

"to auto open & close NERDTree
autocmd TabEnter * NERDTreeClose

"
" NerdTree
map <leader>n :NERDTreeToggle<CR>

"NerdComment
map <silent><leader>c :call NERDComment(0, "toggle")<CR>
command C :call NERDComment(0, "toggle")

" to paste without ai
map <leader>v :r !xclip -o -selection c<CR>

" Completion
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview
"set complete=.,w,b,u,t,i,k~/.vim/syntax/php.api

"tabs
nnoremap <A-left> :bprevious<CR>
nnoremap <A-right> :bnext<CR>

"vsplit
" resize ->
nnoremap <C-A-left> :20winc <<CR>
" resize <-
nnoremap <C-A-right> :20winc ><CR>


" language specifics
"===================

" php
if has("autocmd")
  autocmd FileType php noremap <F7> :!php -l %<CR>
  autocmd FileType php noremap <F9> :!php %<CR>

  " bash
  autocmd FileType sh noremap <F9> :!./ %<CR>

  " symfony
  "autocmd FileType symfony noremap <F8> :SfSwitchView<CR>

  " javascript

  autocmd FileType javascript noremap <F7> :!fixjsstyle %<CR>
  autocmd FileType javascript map <F5> gg=G
  "python :make check errors
  autocmd FileType python2 noremap <F7> :make<CR>
  set makeprg=python2\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
  set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
endif

"FUNCTIONS
"===============


"jquery color angular snippet
au BufRead,BufNewFile *.js set ft=javascript.angular
"less
au BufRead,BufNewFile *.less set ft=less
"angular tmpl
au BufRead,BufNewFile *.html set ft=html.angularhtml
" Smart completion
"" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType less setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType javascript.angular setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType javascript.angular setlocal shiftwidth=4
autocmd FileType javascript.angular setlocal softtabstop=4
autocmd FileType javascript.angular setlocal tabstop=4
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType python setlocal shiftwidth=4
autocmd FileType python setlocal softtabstop=4
autocmd FileType python setlocal tabstop=4
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

"jquery color angular snippet
au BufRead,BufNewFile *.js set ft=javascript.angular
au BufRead,BufNewFile *.ts set ft=typescript
"less
au BufRead,BufNewFile *.less set ft=less
"angular tmpl
au BufRead,BufNewFile *tpl.html set ft=html.angularhtml
function! SmartComplete()
  let line = getline('.') " curline
  let substr = strpart(line, -1, col('.')+1) " from start to cursor
  let substr = matchstr(substr, "[^ \t]*$") " word till cursor
  let has_period = match(substr, '\.') != -1 " position of period, if any
  let has_slash = match(substr, '\/') != -1 " position of slash, if any

  "TODO finish autocomplete

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
autocmd FileType .php autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
autocmd BufWritePost *.py :make
"autocmd BufWritePost *.js :!fixjsstyle %
" Save and reload folding/
"=========================================
autocmd BufWrite * mkview
autocmd BufRead * silent loadview
