{ config, pkgs, lib, ... }:

{
  programs.git = lib.mkForce {
    enable = true;

    userName = "adamwhitlock";
    userEmail = "adam@scuba.io";

    extraConfig = {
      core = {
        editor = "nvim";
      };
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = false;
      };
      push = {
        default = "simple";
      };
      color = {
        ui = true;
      };
      credential = {
        helper = "osxkeychain";
      };
    };

    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      ci = "commit";
      df = "diff";
      fuckrepo = "reset --hard origin/HEAD";
      lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
    };
  };
}
