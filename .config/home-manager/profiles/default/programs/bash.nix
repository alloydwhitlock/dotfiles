{ config, pkgs, lib, ... }:

{
  # Disable bash management but create our custom config file
  programs.bash.enable = false;

  # Create a custom bash configuration file & don't forget to
  # source via ```[ -f ~/.bash_hm_config ] && source ~/.bash_hm_config```
  home.file.".bash_hm_config" = {
    text = ''
      # Ensure history settings
      export HISTSIZE=100000
      export HISTFILESIZE=20000
      export HISTCONTROL=ignoreboth

      # Shell options
      shopt -s checkwinsize
    '';
  };

  # Create a small script to add to your existing bashrc
  home.activation.bashConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if ! grep -q "source ~/.bash_hm_config" ~/.bashrc; then
      echo "source ~/.bash_hm_config" >> ~/.bashrc
    fi
  '';
}