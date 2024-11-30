{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
    ./programs/git.nix
  ];
} 