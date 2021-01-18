### https://github.com/alloydwhitlock/dotfiles

# ignore for non-intractive
case $- in
    *i*) ;;
      *) return;;
esac


## prevent CTRL-D exit of everything

IGNOREEOF=3   # Shell only exists after the 3rd consecutive Ctrl-D


## prompt modification

# verify window size after command
shopt -s checkwinsize

## import local bashrc_local which shouldn't be pushed to git
[[ -f ~/.bashrc_local ]] && source ~/.bashrc_local

## editor options

# svn options
export SVN_EDITOR=vim
export GIT_EDITOR=vim

## history options

# history shell options
shopt -s lithist
shopt -s histappend
shopt -s histreedit
shopt -s histverify

# custom history options
HISTSIZE=100000
HISTFILESIZE=20000

# ignore lines with starting space or duplicates
HISTCONTROL=ignoreboth


## command color options

# color ls, grep, fgrep, egrep
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi



# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

## custom functions

# JSON pretty 'dat URL
jsonpretty() {
    [[ $# -ne 1 ]] && echo "Please provide a URL to retrive"

    [[ $# -eq 1 ]] && curl ${1} | python -m json.tool

}

# provide the diff from a provided git commit
diffgit() {
    git diff ${1}^!
}

# show Git repo information
ps1_git_branch() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    git diff --quiet --ignore-submodules=dirty 2>/dev/null >&2 && dirty="" || dirty=" ±"
    echo " git:${ref#refs/heads/}${dirty}"
}

## custom aliases

alias projects="cd ~/Source"
alias cleanrepo="git reset --hard origin/master"
alias diffrepo="git diff HEAD^ HEAD"
alias revertcommit="git reset --soft HEAD~1"
alias prettygit="git log --oneline --decorate --graph --all"
alias tmux="tmux attach -t whitlock || tmux new -s whitlock"
