{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
    ./programs/alacritty.nix
    ./programs/bash.nix
    ./programs/git.nix
    ./programs/tmux.nix
    ./programs/vim.nix
    ./programs/vscode.nix
  ];
} 