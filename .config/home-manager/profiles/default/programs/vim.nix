# vim.nix
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
    plugins = with pkgs.vimPlugins; [
      vim-airline
      nerdtree
      vim-fugitive
      nord-vim
    ];
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

      " NERDTree configuration
      nnoremap <C-n> :NERDTreeToggle<CR>
      autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

      " color and syntax settings
      colorscheme nord
      syntax on
      syntax enable
      let python_highlight_all = 1

      " Airline configuration
      set guifont=DroidSansMono\ Nerd\ Font\ 11
      let g:airline_powerline_fonts = 1
      let g:airline#extensions#tabline#enabled = 1

      if !exists('g:airline_symbols')
        let g:airline_symbols = {}
      endif
      let g:airline_left_sep = '►'
      let g:airline_left_alt_sep = '>'
      let g:airline_right_sep = '◄'
      let g:airline_right_alt_sep = '<'

      " remove trailing whitespace on save
      autocmd BufWritePre * %s/\s\+$//e

      " write file as sudo
      cnoremap w!! w !sudo tee > /dev/null %
    '';
  };

  # Add Powerline Fonts
  home.packages = with pkgs; [
    powerline-fonts
    dejavu_fonts
  ];

}
