{ config, pkgs, ... }:

{

  home.username = "adamwhitlock";
  home.homeDirectory = "/Users/adamwhitlock";

  imports = [
    ./packages.nix
    ./programs/git.nix
  ];
}