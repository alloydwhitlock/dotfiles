{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    escapeTime = 1;
    historyLimit = 80000;
    keyMode = "vi";
    mouse = false;
    terminal = "screen-256color";

    extraConfig = ''
      # status pane options
      set -g status-bg black
      set -g status-fg white
      set -g status-interval 5
      set -g status-justify left
      set -g status-right-length 50

      # window preferences
      set -g window-status-separator ""
      set -g window-status-format " #[fg=black,bg=green]#I #[fg=black,bg=green]#W "
      set -g window-status-current-format " #[fg=black,bg=blue]#I#[fg=black,bg=blue,nobold,noitalics,nounderscore] #[fg=black,bg=blue]#W "
      set -g status-left "#H"

      # adjust visual preferences
      setw -g aggressive-resize on

      # bind 'a' to allow nested tmux session support
      bind-key a send-prefix

      # kill current pane
      bind-key k kill-pane

      # show/hide status bar
      bind-key -n S-Up set-option -g status
      bind-key -n S-Down set-option -g status

    '';
  };
}
