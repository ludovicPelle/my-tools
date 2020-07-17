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
Plugin 'https://github.com/prettier/vim-prettier'
"Plugin 'css3-syntax-plus'


"COMPLETION
"Plugin 'neoclide/coc.nvim'
Plugin 'https://github.com/ycm-core/YouCompleteMe.git'


"Auto bracket etc
"Plugin 'Raimondi/delimitMate'
" Plugin 'jiangmiao/auto-pairs'

" emmet is an html complex completion
Plugin 'http://github.com/mattn/emmet-vim/'
"snippet
Plugin 'SirVer/ultisnips'
"Plugin 'honza/vim-snippets'
"Comment for all language
Plugin 'scrooloose/nerdcommenter'

"Git sweet shortcuts"
Plugin 'fugitive.vim'

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
set wildmode=longest,list:longest


" enable to move over lines with right and left arrows
set whichwrap=b,s,<,>,[,]

" redefine tabulation space size
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" force relaod if file changed
"set autoread

" status line
set statusline=%F%m%=%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [LINE=%l]\ [Col=%v]\ [%p%%]
set statusline=%F%m%=%r%h%w\ [FT=%Y\ EN=%{&ff}\ POS=%l,%v]
set laststatus=2

" Activate vim completion(piped with youcomplete)
set omnifunc=syntaxcomplete#Complete
set complete=.,b,u,]
set completeopt=menu,preview

" tabs
set tabpagemax=100

imap <C-Space> <C-P>

function Fixjs()
    :silent !fixjsstyle %
    :e
    :redraw!
endfunction
function Fixpython()
    :silent !autopep8 --in-place --aggressive %
    :e
    :redraw!
endfunction

function Fixcss()
    normal mzgg=G`z
    :%s#:\(\s\)\{0,\}\(\S\)#: \2#g " unify rule decla spacing 'name: rule';
    :%s#^}\n\(\n\+\)\(.\)#}\r\r\2#g " unify 1 line between blocks
    :%s#\([a-z][0-9]{};\)$#\1;#g " 'autofix' missing ;
endfunction

function DiffAndCommit()
    " open commit in split
    :Gcommit %
    " resize split
    :resize 10
    " switch bottom window
    :execute("normal \<C-w>j")
    " execute vertical diff
    :Gdiff | execute("normal \<C-w>k")
endfunction

function GenerateScssColors()
    :execute("normal! :/@rgb$/+1,/@endrgb$/-1d\<cr> | :/@color$/+1,/@endcolor$/-1y | :/@rgb$/\<cr>|p\<esc> | :/@rgb$/+1,/@endrgb$/-1s#:.*rgb(\\(.*\\)).*$#-rgb: \\1;#g\<cr>")
    :execute("normal! :/Start$/+1,/End$/-1d\<cr> |:/@rgb$/+1,/@endrgb$/-1y | :/Start$/\<cr>|p\<esc> | :/@color$/+1,/@endcolor$/-1y | :/Start$/\<cr>|p\<esc> |:/Start$/+1,/End$/-1s#.*--\\(.*\\):.*#$\\1:var(--\\1);#g\<cr>")
    :execute("normal! :/@map$/+1,/@endmap$/-1d\<cr> | :/Start$/+1,/End$/-1y | :/@map$/\<cr>|p\<esc> | :/@map$/+1,/@endmap$/-1s#\\$\\(.*\\):.*$#\\1: $\\1,#g\<cr>")
endfunction

command! W w !sudo tee % > /dev/null
command! Fixpython call Fixpython()
command! Fixjs call Fixjs()
command! Fixcss call Fixcss()
command! GenerateScssColors call GenerateScssColors()
nmap <F2> :Gcommit %<CR>
nmap <F3> :Gdiff<CR>
" Quick diff in vslit and commit on top split
nmap <F4> :call DiffAndCommit()<CR>
autocmd FileType javascript nmap <F6> :Fixjs<CR>
autocmd FileType python nmap <F6> :Fixpython<CR>
" add space
autocmd BufWinEnter *.css nmap <F6> :Fixcss<CR>
autocmd BufWinEnter *.scss nmap <F6> :Fixcss<CR>
autocmd BufWinEnter *.scss nmap <F5> :GenerateScssColors<CR>
autocmd BufWinEnter *.less nmap <F6> :Fixcss<CR>
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


nmap <leader>S :!replace '=expand("<cword>")' '%s#=expand("<cword>")#
nmap <leader>F :!ack <C-R><C-W>
nmap <leader>f :vertical terminal ack <C-R><C-W>
nmap <leader>o <c-w>gf

" go and back on declaration
map <silent><leader><Right> <C-T>
nmap <silent><leader>d g]
map <silent><leader><Left> g]

"tabs
nnoremap <A-left> gT
nnoremap <A-right> gt
nnoremap <A-S-left> :bprevious<CR>
nnoremap <A-S-right> :bnext<CR>

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

" Next error
nmap <F9> lnext
" Reindent with f12
nmap <F12> :Prettier<cr>

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
    "autocmd BufWritePost *.js :!gjslint --quiet --disable=110 %
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
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
" Prevent buffer redraw bug on Syntastic Error auto loc list
if exists("g:loaded_slowsave")
    finish
endif
let g:loaded_slowsave = 1
let s:save_cpo = &cpo
set cpo&vim
autocmd BufWritePost * call s:UpdateErrors()
function! s:UpdateErrors()
    "echo "Sleeping for a second..."
    sleep 300m
    redraw
endfunction
let &cpo = s:save_cpo



"cause html template not always detected
"let g:syntastic_mode_map={
            ""\ 'mode': 'active',
            ""\ 'active_filetypes': [],
            ""\ 'passive_filetypes': ['html'] }

"let g:syntastic_quiet_messages = {'regex': '.*FixIt.*'}
let g:syntastic_python_checkers = ['flake8']
"let g:syntastic_javascript_checkers = ['jshint']
" let g:syntastic_python_pylint_args = '--load-plugins pylint_django'

"AIRLINE
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = '>'
"let g:airline#extensions#tabline#left_alt_sep = '>'
"if !exists('g:airline_symbols')
    "let g:airline_symbols = {}
"endif
"let g:airline_powerline_fonts=0
"" unicode symbols
"let g:airline_left_sep = '>'
"let g:airline_right_sep = '<'
let g:airline_detect_modified=1

let g:airline#extensions#tabline#show_close_button = 0 " remove 'X' at the end of the tabline
let g:airline#extensions#tabline#tabs_label = ''       " can put text here like BUFFERS to denote buffers (I clear it so nothing is shown)
let g:airline#extensions#tabline#buffers_label = ''    " can put text here like TABS to denote tabs (I clear it so nothing is shown)
let g:airline#extensions#tabline#fnamemod = ':t'       " disable file paths in the tab
let g:airline#extensions#tabline#show_tab_count = 0    " dont show tab numbers on the right
let g:airline#extensions#tabline#show_buffers = 0      " dont show buffers in the tabline
let g:airline#extensions#tabline#tab_min_count = 2     " minimum of 2 tabs needed to display the tabline
let g:airline#extensions#tabline#show_splits = 0       " disables the buffer name that displays on the right of the tabline
let g:airline#extensions#tabline#show_tab_nr = 0       " disable tab numbers
let g:airline#extensions#tabline#show_tab_type = 0     " disables the weird ornage arrow on the tabline

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
set tags=tags,../tags,~/tags

"YOUCOMPLETEME
let g:ycm_show_diagnostics_ui = 0
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_cache_omnifunc = 0
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_server_python_interpreter="/usr/bin/python3.8"

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
