### https://github.com/alloydwhitlock/dotfiles


## Mac OS-specific profile changes

# Set CLICOLOR if you want Ansi Colors in iTerm2
export CLICOLOR=1

#Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color


## Generic sourcing and exports for all the things

# Source .bashrc if it exists
if [ -f ~/.bashrc ]; then
        . ~/.bashrc;
fi

# Use /usr/local/bin if it exists
export PATH=/usr/local/bin:$PATH

# Define history format to use timestamp
export HISTTIMEFORMAT="%m/%d/%y %T "

