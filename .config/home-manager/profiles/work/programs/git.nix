{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    
    # Your personal information
    userName = lib.mkForce"adamwhitlock";
    userEmail = lib.mkForce "adam@scuba.io";


  };
}