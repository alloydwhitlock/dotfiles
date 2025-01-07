{ config, pkgs, ... }:

let
  homeDir = builtins.getEnv "HOME";
in
{
  home.username = "whitlock";
  home.homeDirectory = homeDir;

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

