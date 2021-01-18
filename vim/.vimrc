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

"Write file as sudo
cnoremap w!! w !sudo tee > /dev/null %

