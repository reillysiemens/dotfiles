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
Plugin 'VundleVim/Vundle.vim'

" colorschemes
Plugin 'morhetz/gruvbox'

" fuzzy matching for filenames and other things
Plugin 'ctrlpvim/ctrlp.vim'

" file browser
Plugin 'scrooloose/nerdtree'

" git wrapper for vim
Plugin 'tpope/vim-fugitive'

" handy bracket mappings
Plugin 'tpope/vim-unimpaired'

" surround all the things
Plugin 'tpope/vim-surround'

" syntax highlighting extras for c, bison, and flex
Plugin 'justinmk/vim-syntax-extra'

" javascript plugins
Plugin 'jelera/vim-javascript-syntax'

" python plugins
Plugin 'lepture/vim-jinja'
Plugin 'davidhalter/jedi-vim'
Plugin 'python-mode/python-mode'
Plugin 'psf/black'

" rust plugins
Plugin 'rust-lang/rust.vim'
Plugin 'cespare/vim-toml'

" go plugins
Plugin 'fatih/vim-go'

" saltstack plugins
Plugin 'saltstack/salt-vim'

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
" Meta {{{
" http://stackoverflow.com/a/15317146
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
" }}}
" Spaces & Tabs {{{

set tabstop=4 " number of visual spaces per tab
set softtabstop=4 " number of spaces in tab when editing
set shiftwidth=4 " number of spaces used in indenting
set expandtab " tabs are spaces

" overrides for specific filetypes
autocmd FileType javascript,json set tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType css,html set tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType c,cpp set tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileTYpe yml,yaml set tabstop=2 softtabstop=2 shiftwidth=2

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
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" count matches for a pattern under the cursor (https://j.mp/2QSFa8Z)
nnoremap <leader>* *<C-O>:%s///gn<CR>

" Thanks, nXqd: https://superuser.com/a/437744
nnoremap <leader>p :setlocal paste! paste?<CR>
nnoremap <leader>l :setlocal list! list?<CR>

" Run rustfmt on .rs files. https://vi.stackexchange.com/a/11196
autocmd FileType rust nnoremap <buffer><silent><leader>r :RustFmt<CR>

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

" search from visual selection
vnoremap // y/<C-R>"<CR>

" }}}
" Colors {{{

if has("termguicolors")
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

syntax enable
set background=dark
colorscheme gruvbox
let g:gruvbox_contrast_dark = "soft"

" }}}
" Markdown {{{

au BufRead,BufNewFile *.md set filetype=markdown

" }}}
" NERDTree {{{

" don't show help text at the top of NERDTree
let NERDTreeMinimalUI=1

" ignore these files in NERDTree
let NERDTreeIgnore = ['\.pyc$', '\.egg-info$', '__pycache__']

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
let g:pymode_lint_options_pep8 = {'max_line_length': 88}
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
"
" prevent auto insertion of autocomplete options
set completeopt=menuone,noinsert

" }}}
" Black {{{
autocmd BufWritePre *.py execute ':Black'
" }}}
" Rustfmt {{{
autocmd BufWritePre *.rs execute ':RustFmt'
let g:rustfmt_command = "rustfmt --edition=2018"
" }}}

" vim:foldmethod=marker:foldlevel=0
