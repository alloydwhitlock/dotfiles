{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    
    # Your personal information
    userName = "Adam Whitlock";
    userEmail = "adam@adamwhitlock.com";
    
    # Core settings
    extraConfig = {
      core = {
        editor = "nvim";
      };
    };

    # Git aliases
    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      ci = "commit";
      df = "diff";
      fuckrepo = "git reset --hard origin/head";
      lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
    };

    # Recommended settings for better usability
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = false;  # merge (the default strategy)
      };
      push = {
        default = "simple";
      };
      color = {
        ui = true;
      };
    };

  };
}