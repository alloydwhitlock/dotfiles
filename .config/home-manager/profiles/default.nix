{ config, pkgs, ... }:

let
  # Get the profile name from an environment variable, default to "default"
  profileName = builtins.getEnv "NIX_PROFILE_NAME";
  
  # Always import the default profile
  defaultProfile = [ ./default/default.nix ];
  
  # Conditionally import additional profiles
  additionalProfile = 
    if profileName == "work" then [ ./work/default.nix ]
    else [];

in {
  imports = defaultProfile ++ additionalProfile;
}
