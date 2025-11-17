# ~/.bashrc

# ignore for non-intractive
case $- in
    *i*) ;;
      *) return;;
esac

# prevent CTRL-D exit of everything
IGNOREEOF=3   # Shell only exists after the 3rd consecutive Ctrl-D


# shell options
shopt -s checkwinsize

# source local bashrc if it exists (for machine-specific settings)
[[ -f ~/.bashrc_local ]] && source ~/.bashrc_local

# editor options
export SVN_EDITOR=vim
export GIT_EDITOR=vim

# Ensure history settings
export HISTSIZE=100000
export HISTFILESIZE=20000
export HISTCONTROL=ignoreboth

# history shell options
shopt -s lithist
shopt -s histappend
shopt -s histreedit
shopt -s histverify

# color ls, grep, fgrep, egrep
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# enable programmable completion features (you don't need to enable
# this, if you don't want to use programmable completion)
[[ $PS1 && -f /etc/bash_completion ]] && . /etc/bash_completion || true     

# tmux plugin manager
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# custom aliases
alias cleanrepo="git reset --hard origin/master"
alias revertcommit="git reset --soft HEAD~1"
alias tmux="tmux attach -t whitlock || tmux new -s whitlock"
alias emacs="emacs -nw"
alias tree="tree -F -a --dirsfirst"