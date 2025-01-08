{config, pkgs, ...}: {
  programs.zsh = {
    enable = true;
    
    initExtraFirst = ''
      # Install oh-my-zsh if not present
      if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Installing oh-my-zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
      fi

      # Source Homebrew if installed
      if [ -f "/opt/homebrew/bin/brew" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi

      # Ensure ZSH_CUSTOM is set for custom plugins
      export ZSH="$HOME/.oh-my-zsh"
      export ZSH_CUSTOM="$ZSH/custom"
      
      # Configure oh-my-zsh plugins BEFORE sourcing oh-my-zsh
      plugins=(git branch docker colorize)
    '';
    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.7.1";
          sha256 = "03r6hpb5fy4yaakqm3lbf4xcvd408r44jgpv4lnzl9asp4sb9qc0";
        };
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "1g3pij5qn2j7v7jjac2a63lxd97mcsgw6xq6k5p7835q9fjiid98";
        };
      }
    ];
    initExtra = ''
      # Enable Flox if available
      if [ -d "${config.home.homeDirectory}/.flox" ]; then
        eval "$(flox activate)" || echo "Failed to evaluate flox activate"
      fi
      
      # Source oh-my-zsh AFTER plugins are configured
      if [ -f "$ZSH/oh-my-zsh.sh" ]; then
        ZSH_THEME="clean"
        source "$ZSH/oh-my-zsh.sh"
      else
        echo "Warning: oh-my-zsh.sh not found"
      fi
    '';
  };
}




