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

      # Add a new clean-plus.zsh-theme with hostname support
      custom_theme="$ZSH_CUSTOM/themes/clean-plus.zsh-theme"
      mkdir -p "$ZSH_CUSTOM/themes"
      cat << 'EOF' > "$custom_theme"
      # clean-plus.zsh-theme with hostname
      if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="white"; fi

      PROMPT='%{$fg[$NCOLOR]%}%B%n@%m%b%{$reset_color%}:%{$fg[blue]%}%B%c/%b%{$reset_color%} $(git_prompt_info)%(!.#.$) '
      RPROMPT='[%*]'

      # git theming
      ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg_no_bold[yellow]%}%B"
      ZSH_THEME_GIT_PROMPT_SUFFIX="%b%{$fg_bold[blue]%})%{$reset_color%} "
      ZSH_THEME_GIT_PROMPT_CLEAN=""
      ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}✗"

      # LS colors, made with https://geoff.greer.fm/lscolors/
      export LSCOLORS="Gxfxcxdxbxegedabagacad"
      export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;32:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:'
      EOF
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
        eval "$(flox activate -d ~ -m run)"
      fi

      # Source oh-my-zsh AFTER plugins are configured
      if [ -f "$ZSH/oh-my-zsh.sh" ]; then
        ZSH_THEME="clean-plus"
        source "$ZSH/oh-my-zsh.sh"
      else
        echo "Warning: oh-my-zsh.sh not found"
      fi
    '';
  };
}
