# ~/.bash_profile

## Mac OS-specific profile changes

# set CLICOLOR if you want ANSI colors in iTerm2
export CLICOLOR=1

# set colors to match iTerm2 terminal colors
export TERM=xterm-256color

## General sourcing and exports for all the things

# source .bashrc if it exists
if [ -f ~/.bashrc ]; then
        . ~/.bashrc;
fi

# use /usr/local/bin if it exists
export PATH=/usr/local/bin:$PATH

# define history format to use timestamp
export HISTTIMEFORMAT="%m/%d/%y %T "
