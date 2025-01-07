{ config, pkgs, ... }:

let
  # Get the profile name from an environment variable, default to "default"
  profileName = builtins.getEnv "NIX_PROFILE_NAME";

  # Get the home directory from the environment
  homeDir = builtins.getEnv "HOME";

  # Determine the default profile based on the home directory
  defaultProfile =
    if homeDir == "/home/whitlock" || homeDir == "/Users/whitlock" then [ ./default/default.nix ]
    else [];

  # Determine the work profile conditionally based on the home directory or profileName
  additionalProfile =
    if homeDir == "/Users/adamwhitlock" || profileName == "work" then [ ./work/default.nix ]
    else [];

in {
  imports = defaultProfile ++ additionalProfile;
}

