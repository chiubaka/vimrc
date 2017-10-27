" Vundle settings
set nocompatible " required
filetype off " required

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim " required
call vundle#begin() " required

" This plugin is required for Vundle to work
Plugin 'VundleVim/Vundle.vim' "required

" Plugin for Python utility support directly in Vim
Plugin 'klen/python-mode'
" Tells python-mode to use Python 3 syntax checking
" let g:pymode_python ='python3'

" Plugin for convenient file explorer interface in Vim
Plugin 'scrooloose/nerdtree'
" Automatically opens Vim with the file explorer
autocmd vimenter * NERDTree

" Plugin for showing visual indent guides
" Plugin 'nathanaelkane/vim-indent-guides'
" Turns indent guides on by default
" let g:indent_guides_enable_on_vim_startup = 1

" Plugin for stupidly simple code commenting shortcuts. `gcc` to comment out
" a line, `gc` to comment out the target of a motion (`gcap` to comment out 
" a paragraph). Can be used as a command like `:7,17Commentary` or as part of
" a `:global` invocation like with `:g/TODO/Commentary`
Plugin 'tpope/vim-commentary'


" Plugin for asynchronous code linting.
" TODO: This plugin probably needs to be configured properly
Plugin 'w0rp/ale'

" All plugins must be added before this line but after `call vundle#begin()`
call vundle#end() " required
filetype plugin indent on " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" Other settings
" Turn on syntax highlighting
syntax on
" Allow backspace to delete indent, eol, and start characters
set backspace=indent,eol,start

" Disable Arrow keys in Escape mode to train myself
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
