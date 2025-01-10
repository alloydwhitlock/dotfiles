{ config, pkgs, ... }:

let
  # Get the profile name from an environment variable, if set
  profileName = builtins.getEnv "NIX_PROFILE_NAME";
  # Get the home directory from the environment
  homeDir = builtins.getEnv "HOME";
  # Get the username part of the home directory
  userName = let
    parts = builtins.split "/" homeDir;
    lastPart = builtins.elemAt parts (builtins.length parts - 1);
  in lastPart;
  
  # Determine which profile to use based on profile name or username
  activeProfile = 
    if profileName != "" then
      if profileName == "work" then [ ./work/default.nix ]
      else if profileName == "default" then [ ./default/default.nix ]
      else throw "Unknown profile name: ${profileName}"
    else if userName == "adamwhitlock" then [ ./work/default.nix ]
    else if userName == "whitlock" then [ ./default/default.nix ]
    else throw "Unknown user profile for ${userName}";
    
in {
  imports = activeProfile;
}


