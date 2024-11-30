{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "whitlock";
  home.homeDirectory = "/home/whitlock";

  # Import the profile configuration
  imports = [ 
    ./profiles
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager release version
  home.stateVersion = "23.11";
}
