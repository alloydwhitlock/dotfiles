" https://github.com/alloydwhitlock/dotfiles

" generic, good to have default settings
set encoding=utf-8
set nocompatible
set history=200

" tab/space settings
set ts=4
set autoindent
set expandtab
set shiftwidth=4

" visualization settings
set bs=indent,eol,start
set number
set ruler
set cursorline
set showmatch
colorscheme elflord

" syntax-specific settings
syntax enable
let python_highlight_all = 1

" remove all trailing whitespaces
autocmd BufWritePre * %s/\s\+$//e

" write file as sudo
cnoremap w!! w !sudo tee > /dev/null %

