{ config, pkgs, ... }:

{
  home.username = "whitlock";
  home.homeDirectory = "/home/whitlock";

  imports = [
    ./packages.nix
    ./programs/alacritty.nix
    ./programs/bash.nix
    ./programs/git.nix
    ./programs/tmux.nix
    ./programs/vim.nix
    ./programs/vscode.nix
    ./programs/zsh.nix
  ];
}
