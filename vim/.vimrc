" Remove ALL autocommands for the current group.
au!

" Presentation
colorscheme delek
" colorscheme molokai
" cursor (line under it, reverse color)
set cursorline
" line number
hi LineNr ctermfg=Darkgray guifg=#3D3D3D

" remove whitespace
" if has("autocmd")
" autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif
" endif
" case sensitive
set noic

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
set wildmenu " Enhanced command line completion.
set wildmode=list:longest " Complete files like a shell.

" enable to move over lines with right and left arrows
set whichwrap=b,s,<,>,[,]

" redefine tabs
set expandtab
"set shiftwidth=2
"set softtabstop=2
"set tabstop=2
set shiftwidth=2
set softtabstop=2
set tabstop=2

" status line
set statusline=%F%m%=%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [LINE=%l]\ [Col=%v]\ [%p%%]
set laststatus=2


"if exists('+colorcolumn')
 " set colorcolumn=80
"else
"  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
"endif
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
let g:snips_author = 'Ludovic Pellé <ludovic_pelle@iprotego.com>'

" activate symfony for php files
if has("autocmd")
autocmd FileType php set ft=php.symfony
endif

" activate css for scss files
if has("autocmd")
au BufRead,BufNewFile *.scss set filetype=scss
autocmd FileType scss set ft=css
au BufRead,BufNewFile *.less set filetype=scss
autocmd FileType less set ft=css
endif


"Ctags
let g:ctags_path="~/.vim/plugin"
"  let g:ctags_statusline=1
" Ctags
 set nocp
 set tags=tags
 map <silent><leader><Left> <C-T>
 map <silent><leader><Right> <C-]>
 map <silent><leader><Up> <C-W>]

" tagbar
let g:tagbar_left = 1           " display the tagbar on the left side
set updatetime=500              " show tags' prototype after 500 milliseconds
let g:tagbar_width = 25         " width in characters of the tagbar
let g:tagbar_autoshowtag = 1    " always show the current tag in the tagbar
let g:tagbar_autofocus = 1      " the cursor will move to the Tagbar window when it is opened.
nnoremap <silent> <F10> :TagbarToggle<CR>

" Syntastic
let g:syntastic_enable_signs = 1    " open a bar on the left when an error is detected
let g:syntastic_auto_loc_list = 1   " auto open the errors list
let g:syntastic_quiet_warnings = 0  " we do want the warnings to be displayed

" Completion
" automatically open and close the popup menu / preview window
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"set completeopt=menuone,menu,longest,preview


" Hotkeys
" =================
  let mapleader = ","
"cmap tn tabnew
"cmap vs vsplit
cmap find !ack-grep --ignore-dir=lib

map <silent><leader><Right> <C-T>
" go to the declaration of a class, variable, ...)
map <silent><leader><Left> <C-]>
" go back

" Toggle line numbers and fold column for easy copying:
nnoremap <C-l> :set nonumber!<CR>:set foldcolumn=0<CR>
" Start a substitute
  map <leader>s :%s/

" Start a search
  map <leader>h /<C-r>=expand("<cword>")<CR>

" Pull word under cursor into LHS of a substitute (for quick search and
" replace)
  nmap <leader>S :%s/<C-r>=expand("<cword>")<CR>/

"to force write as sudoer
command W w !sudo tee % > /dev/null

"auto folding
map <silent><leader>F :EnableFastPHPFolds<Cr>
map <silent><leader>f :EnablePHPFolds<Cr>
map <silent><leader>g :DisablePHPFolds<Cr>

"to auto open & close NERDTree
autocmd TabEnter * NERDTreeClose

"
" NerdTree
 map <leader>n :NERDTreeToggle<CR>

"NerdComment
map <silent><leader>c :call NERDComment(0, "toggle")<CR>
command C :call NERDComment(0, "toggle")

" to paste without ai
 map <leader>p :set invpaste paste?<CR>

" Call smart completion when pressing Ctrl-Space
 set complete=.,w,b,u,t,i,k~/.vim/syntax/php.api
 au FileType php set omnifunc=phpcomplete#CompletePHP

"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
" set completeopt=menuone,menu,longest,preview

 inoremap <C-Space> <c-r>=SmartComplete()<CR>
 imap <C-@> <C-Space>

" language specifics
"===================

" php
if has("autocmd")
autocmd FileType php noremap <F7> :!php -l %<CR>

autocmd FileType php noremap <F9> :!php %<CR>

autocmd FileType sh noremap <F9> :!./ %<CR>

" symfony
autocmd FileType symfony noremap <F8> :SfSwitchView<CR>

" javascript
autocmd FileType javascript noremap <F7> :!gjslint %<CR>
autocmd FileType javascript noremap <F8> :!fixjsstyle %<CR>
endif
"jquery color angular snippet
au BufRead,BufNewFile *.js set ft=javascript.angular
"less
au BufRead,BufNewFile *.less set ft=css
"angular tmpl
au BufRead,BufNewFile *.html set ft=html.angularhtml

"FUNCTIONS
"===============


"Toggle comment
"
" Smart completion
function! SmartComplete()
  let line = getline('.') " curline
  let substr = strpart(line, -1, col('.')+1) " from start to cursor
  let substr = matchstr(substr, "[^ \t]*$") " word till cursor
  let has_period = match(substr, '\.') != -1 " position of period, if any
  let has_slash = match(substr, '\/') != -1 " position of slash, if any

  "TODO finish autocomplete

  return "\<C-P>" " omnifunc if available
endfunction

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
