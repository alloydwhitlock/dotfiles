{ config, pkgs, ... }:

{

  home.username = "whitlock";
  home.homeDirectory = "/Users/whitlock";

  imports = [
    ./packages.nix
    ./programs/git.nix
    ../default/programs/zsh.nix
  ];
}
