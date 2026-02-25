# ~/.zshrc

# Install oh-my-zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Default editor is vim
export EDITOR=vim

# Default git editor is vim
export GIT_EDITOR=vim


# Source Homebrew if installed
if [ -f "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Ensure ZSH_CUSTOM is set for custom plugins
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"

ZSH_THEME="robbyrussell"

# Configure oh-my-zsh plugins
plugins=(git branch docker colorize)

# Create clean-plus theme with hostname support
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

# Set the theme
ZSH_THEME="clean-plus"

# Source oh-my-zsh
if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  source "$ZSH/oh-my-zsh.sh"
else
  echo "Warning: oh-my-zsh.sh not found"
fi

# Install zsh-syntax-highlighting if not present
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Install zsh-autosuggestions if not present
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# Source the plugins
source "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" 2>/dev/null
source "$ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" 2>/dev/null

# Enable Flox if available
if [ -d "$HOME/.flox" ]; then
  eval "$(flox activate -d ~ -m run)" 2>/dev/null
fi

# Source local zshrc if it exists (for machine-specific settings)
[ -f ~/.zshrc_local ] && source ~/.zshrc_local

# Use .local bin folder path
export PATH="$HOME/.local/bin:$PATH"

# Functions

tmux() {
  local default_session="whitlock"

  # No args: attach/create default
  if [ "$#" -eq 0 ]; then
    command tmux attach -t "$default_session" 2>/dev/null \
      || command tmux new -s "$default_session"
    return
  fi

  # If the first arg looks like a tmux subcommand (or an option), pass through
  case "$1" in
    -*|attach|a|new|new-session|ls|list-sessions|kill-session|kill-server|detach|rename-session|switch-client|has-session|display-message|show-options|set-option|source-file)
      command tmux "$@"
      return
      ;;
  esac

  # Single arg that isn't a subcommand: treat it as a session name
  if [ "$#" -eq 1 ]; then
    if command tmux has-session -t "$1" 2>/dev/null; then
      command tmux attach -t "$1"
    else
      command tmux new -s "$1"
    fi
    return
  fi

  # Anything else: just pass through
  command tmux "$@"
}

# Aliases
alias cleanrepo="git reset --hard origin/master"
alias revertcommit="git reset --soft HEAD~1"

export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"
