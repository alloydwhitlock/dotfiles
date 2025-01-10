{ config, pkgs, ... }:
let
  homeDir = builtins.getEnv "HOME";
  userName = let
    parts = builtins.split "/" homeDir;
    lastPart = builtins.elemAt parts (builtins.length parts - 1);
  in lastPart;
in
{
  home.username = userName;
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
