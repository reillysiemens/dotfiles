"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"          _                       
"  __   __(_) _ __ ___   _ __  ___ 
"  \ \ / /| || '_ ` _ \ | '__|/ __|
"  _\ V / | || | | | | || |  | (__ 
" (_)\_/  |_||_| |_| |_||_|   \___|
"                                  
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle Preamble {{{

set nocompatible             " required by vundle
filetype off                 " required by vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" }}}
" Vundle Plugins {{{

" required by vundle to manage vundle
Plugin 'gmarik/Vundle.vim'

" git wrapper for vim
Plugin 'tpope/vim-fugitive'

" colorschemes
Plugin 'morhetz/gruvbox'

" editorconfig
Plugin 'editorconfig/editorconfig-vim'

" syntax highlighting extras for c, bison, and flex
Plugin 'justinmk/vim-syntax-extra'

" javascript/coffeescript plugins
Plugin 'jelera/vim-javascript-syntax'

" coffeescript plugins
Plugin 'kchmck/vim-coffee-script'
Plugin 'mintplant/vim-literate-coffeescript'

" webdev plugins
Plugin 'digitaltoad/vim-jade'
Plugin 'groenewege/vim-less'
Plugin 'wavded/vim-stylus'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'briancollins/vim-jst'

" python plugins
Plugin 'lepture/vim-jinja'
Plugin 'davidhalter/jedi-vim'
Plugin 'klen/python-mode'

" rust plugins
Plugin 'rust-lang/rust.vim'
Plugin 'cespare/vim-toml'

" file browser
Plugin 'scrooloose/nerdtree'

" fuzzy matching for filenames and other things
Plugin 'kien/ctrlp.vim'

" surround all the things
Plugin 'tpope/vim-surround'

" }}}
" Vundle Postamble {{{

" ALL plugins must be added before this line
call vundle#end()            " required by vundle
filetype plugin indent on    " required by vundle

" }}}
" Misc {{{

set encoding=utf-8
set ttyfast " faster redraw

" }}}
" Spaces & Tabs {{{

set tabstop=4 " number of visual spaces per tab
set softtabstop=4 " number of spaces in tab when editing
set shiftwidth=4
set expandtab " tabs are spaces

" }}}
" UI & Layout {{{

set number " show line numbers
set cc=80 " color coloumn at 80 lines
set nowrap " don't wrap text
set lazyredraw " redraw only when we need to

" }}}
" Leader shortcuts {{{

let mapleader="\<Space>" " leader is space
nnoremap <leader>m :silent make\|redraw!\|cw<CR>
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader><space> :nohlsearch<CR>

" }}}
" Folding {{{

set foldenable " enable folding
set foldlevelstart=10 " open most folds by default
set foldnestmax=10 " 10 nested fold max
" comma opens/closes folds
nnoremap , za
set foldmethod=indent " fold based on indent level

" }}}
" Search {{{

set incsearch " search as characters are entered
set hlsearch " highlight matches
set showmatch " highlight matching [{()}]

" }}}
" Colors {{{

syntax enable
set background=dark
colorscheme gruvbox
let g:gruvbox_contrast_dark = "soft"

" }}}
" Markdown {{{

au BufRead,BufNewFile *.md set filetype=markdown

" }}}
" EditorConfig {{{

let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" }}}
" Iced CoffeeScript {{{

" syntax highlighting for IcedCoffeeScript
" taken from suggestion at https://github.com/kchmck/vim-coffee-script/issues/73
autocmd BufNewFile,BufRead *.iced set filetype=coffee
syn match coffeeKeyword /\<\%(await\|defer\)\>/ display

" }}}
" CSON {{{

" syntax highlighting for CSON (https://github.com/bevry/cson)
au BufRead,BufNewFile *.cson set ft=coffee

" }}}
" NERDTree {{{

" start with NERDTree open if no files are specified
autocmd vimenter * if !argc() | NERDTree | endif

" exit Vim if a NERDTree is the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" }}}
" Jinja {{{
au BufNewFile,BufRead *.jinja2 set ft=jinja
" }}}
" Python Mode {{{

" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 1
"
" documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'
"
"linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" auto check on save
let g:pymode_lint_write = 1
"
" support virtualenv
let g:pymode_virtualenv = 1
"
" enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'
"
" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
"
" don't autofold code
let g:pymode_folding = 0

" }}}

" vim:foldmethod=marker:foldlevel=0
