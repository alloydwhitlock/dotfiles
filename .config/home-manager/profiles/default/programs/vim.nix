{ config, pkgs, ... }:

{
  programs.vim = {
    enable = true;
    
    settings = {
      expandtab = true;
      number = true;
      tabstop = 4;
      shiftwidth = 4;
    };

    extraConfig = ''
      " basic settings
      set encoding=utf-8
      set nocompatible
      set history=200
      set bs=indent,eol,start
      set cursorline
      set showmatch
      set autoindent
      set ruler

      " color and syntax settings
      colorscheme elflord
      syntax on
      syntax enable
      let python_highlight_all = 1

      " remove trailing whitespace on save
      autocmd BufWritePre * %s/\s\+$//e

      " write file as sudo
      cnoremap w!! w !sudo tee > /dev/null %
    '';
  };
}