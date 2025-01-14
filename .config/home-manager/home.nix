
{ config, pkgs, ... }:

{
  # Import the profile configuration
  imports = [ ./profiles/default.nix ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager release version
  home.stateVersion = "24.11";
}
