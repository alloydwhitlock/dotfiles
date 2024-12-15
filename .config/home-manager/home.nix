{ config, pkgs, ... }:

let
  profile = builtins.getEnv "HM_PROFILE";
  profilePath =
    if profile == ""
    then ./profiles/default
    else ./profiles + "/${profile}";
in
{
  # Import the profile configuration
  imports = [
    profilePath
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager release version
  home.stateVersion = "23.11";
}