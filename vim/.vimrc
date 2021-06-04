set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

"SYNTAX
"Plugin 'jelera/vim-javascript-syntax'
"Plugin 'pangloss/vim-javascript'
"Plugin 'isRuslan/vim-es6'
"Plugin 'nathanaelkane/vim-indent-guides'
"Plugin 'https://github.com/othree/javascript-libraries-syntax.vim'
Plugin 'othree/html5.vim'
Plugin 'groenewege/vim-less'
Plugin 'css_color'
Plugin 'prettier/vim-prettier'
"Plugin 'css3-syntax-plus'


"COMPLETION
Plugin 'https://github.com/Valloric/YouCompleteMe'

"Server for autocomplete JS
"Plugin 'ternjs/tern_for_vim'
"Auto bracket etc
"Plugin 'Raimondi/delimitMate'
Plugin 'jiangmiao/auto-pairs'
" emmet is an html complex completion
Plugin 'http://github.com/mattn/emmet-vim/'
"snippet
Plugin 'SirVer/ultisnips'
"Plugin 'honza/vim-snippets'
"Comment for all language
Plugin 'scrooloose/nerdcommenter'

" FILES
"Buffers display
Plugin 'bling/vim-airline'
"Quick open files
Plugin 'ctrlpvim/ctrlp.vim'
"Filetree as an IDE
Plugin 'scrooloose/nerdtree'

"LINTING
Plugin 'scrooloose/syntastic'

call vundle#end()            " required
" enable filetypes
filetype plugin indent on     " required!

" =========================================
"           GLOBAL CONFIG
" ========================================

"256 color
set t_Co=256

"UTF-8
set encoding=utf-8

"Presentation
colorscheme loodub

" show line number
set number

"set coloration for language
if has("syntax")
    syntax on
endif

" Fix backspace won't move from current line
" set backspace=indent,eol,start


"Enhanced command line completion.
set wildmenu
"Complete files like a shell.
set wildmode=list:longest


" enable to move over lines with right and left arrows
set whichwrap=b,s,<,>,[,]

" redefine tabulation space size
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab


" status line
set statusline=%F%m%=%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [LINE=%l]\ [Col=%v]\ [%p%%]
set statusline=%F%m%=%r%h%w\ [FT=%Y\ EN=%{&ff}\ POS=%l,%v]
set laststatus=2

" Activate vim completion(piped with youcomplete)
set omnifunc=syntaxcomplete#Complete

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
inoremap <C-Space> <c-r>=SmartComplete()<CR>

command! W w !sudo tee % > /dev/null
command! Fixpython :!autopep8 --in-place --aggressive %
command! Fixjs :!fixjsstyle %
command! Lorem :r https://baconipsum.com/api/?type=meat-and-filler&format=text
command! FormatJSON %!python -m json.tool
cmap tb tabnew<space>

" =========================================
"           HOTKEYS
" ========================================
let mapleader = ","

"nnoremap <C-n> :tabnew<SPACE>
" Toggle line numbers and fold column for easy copying:
nnoremap <C-l> :set nonumber!<CR>:set foldcolumn=0<CR>

" Start a search
map <leader>h /<C-r>=expand("<cword>")<CR>

" Pull word under cursor into LHS of a substitute (for quick search and
" replace)
nmap <leader>s :%s/<C-r>=expand("<cword>")<CR>/

nmap <leader>S :!replace_all '=expand("<cword>")' '%s#=expand("<cword>")#
nmap <leader>F :!ack <C-R><C-W> .<CR>
nmap <leader>f :terminal ack <C-R><C-W> .<CR>
nmap <leader>o <c-w>gf

" go and back on declaration
map <silent><leader><Right> <C-T>
map <silent><leader><Left> <C-]>

"tabs
nnoremap <A-left> :bprevious<CR>
nnoremap <A-right> :bnext<CR>

"vsplit resizing
" resize ->
nnoremap <C-A-left> :20winc <<CR>
" resize <-
nnoremap <C-A-right> :20winc ><CR>

" autoquoting
nmap <leader>' ciw''<Esc>P
nmap <leader>" ciw""<Esc>P
nmap <leader>d' di'hPl2x
nmap <leader>d" di"hPl2x

" Reindent with f12
nmap <F12> mzgg=G`z

" to paste without ai
map <leader>v :r !xclip -o -selection c<CR>
" Yank current selection into system clipboard
vmap <leader>y :w! /tmp/clipboard<CR>
" Yank current line into system clipboard (if nothing is selected)
nmap <leader>p :r! cat /tmp/clipboard<CR>

" Folding

set foldmethod=indent
set foldlevelstart=1


" =========================================
"           AUTOCOMMAND
" ========================================
if has("autocmd")
    "no cursor underline
    autocmd BufWinEnter * set nocursorline
    "enable memorised position of cursor when reopen the file
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")

    "check syntax JS on save (no max line chars)
    autocmd BufWritePost *.js :!gjslint --disable 110 %
    autocmd BufWinEnter *.js set foldmethod=indent

    " Remove trailing whitespaces and ^M chars
    "=========================================
    autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif
    autocmd FileType .php autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

    " Save folding and view for each file
    autocmd BufWrite * mkview
    autocmd BufRead * silent loadview

    " Open all as tab
    " au BufAdd,BufNewFile,BufRead * nested tab sball

endif



" =========================================
"           PLUGIN CONFIG
" ========================================
" SYNTASTIC
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
"cause template not reconize
let g:syntastic_mode_map={ 'mode': 'active',
            \ 'active_filetypes': [],
            \ 'passive_filetypes': ['html'] }

let g:syntastic_quiet_messages = {'level': 'warnings'}
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_javascript_checkers = ['gjslint --disable=110']
"let g:syntastic_python_pylint_args = "--load-plugins pylint_django"

"AIRLINE
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

"TERN
"enable keyboard shortcuts
"let g:tern_map_keys=1
""show argument hints
"let g:tern_show_argument_hints='on_hold'
let g:used_javascript_libs = 'underscore,angularjs,jasmine,chai'

"CTRLP
let g:ctrlp_map = '<c-f>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_regexp = 1
let g:ctrlp_max_files = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v(\.git|.pyc|build|node_modules|bower_components|platforms/android|platforms/ios|build|www|dist|report)$',
            \}

" Open in tab
let g:ctrlp_open_new_file = 't'

"EMMET
let g:user_emmet_expandabbr_key='<c-e>'

" CTAGS
let g:ctags_path="~/.vim/plugin"
let g:ctags_statusline=1
set tags=./tags,tags,../tags,../../tags,/home/loodub/Projects/tags

"YOUCOMPLETEME
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_autoclose_preview_window_after_completion = 1
"let g:ycm_server_python_interpreter="/usr/bin/python3.5"


" ULTISNIPS
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-tab>"

"NERDTREE
"to auto open & close NERDTree
map <leader>n :NERDTreeToggle<CR>
autocmd TabEnter * NERDTreeClose

" NERDCOMMENT
map <silent><leader>c :call NERDComment(0, "toggle")<CR>
command! -nargs=? -range=% C :normal <line1>ggv<line2>gg<Leader>c<space>
