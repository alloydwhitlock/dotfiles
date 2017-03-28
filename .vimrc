"https://github.com/alloydwhitlock/dotfiles

"Generic, good to have default settings
set nocompatible
set history=200
set paste

"Tab/space settings
set ts=4
set autoindent
set expandtab
set shiftwidth=4

"Visualization settings
set bs=indent,eol,start
set number
set ruler
set cursorline
set showmatch
colorscheme molokai

"Syntax-specific settings
syntax enable 
let python_highlight_all = 1

"Enable Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"Vundle needs to manage Vundle
Plugin 'gmarik/Vundle.vim'

"Vundle plugins begin

"Vundle plugins end

call vundle#end()
filetype plugin indent on
