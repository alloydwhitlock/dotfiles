"https://github.com/alloydwhitlock/dotfiles

"Generic, good to have default settings
set encoding=utf-8
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
colorscheme elflord

"Syntax-specific settings
syntax enable
let python_highlight_all = 1

"Remove all trailing whitespaces
autocmd BufWritePre * %s/\s\+$//e

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

"Enable Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"Vundle needs to manage Vundle
Plugin 'gmarik/Vundle.vim'

"Vundle plugins begin

Plugin 'vim-scripts/indentpython.vim'
Bundle 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'


"Vundle plugins end

call vundle#end()
filetype plugin indent on
