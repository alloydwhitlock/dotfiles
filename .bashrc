### https://github.com/alloydwhitlock/dotfiles

## prevent CTRL-D exit of everything

IGNOREEOF=3   # Shell only exists after the 3rd consecutive Ctrl-D


## prompt modification
export PS1="[\[$(tput sgr0)\]\[\033[38;5;1m\]\$?\[$(tput sgr0)\]\[\033[38;5;15m\]] \[$(tput sgr0)\]\[\033[38;5;5m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;6m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;4m\][\w]\[$(tput sgr0)\]\[\033[38;5;6m\]:\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"


## editor options

# svn

export SVN_EDITOR=vim


## history options

# history shell options
shopt -s lithist
shopt -s histappend
shopt -s histreedit
shopt -s histverify

# set massive history sizes
HISTSIZE=100000
HISTFILESIZE=20000


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

alias projects="cd ~/src"
alias cleanrepo="git reset --hard origin/master"
alias diffrepo="git diff HEAD^ HEAD"
alias revertcommit="git reset --soft HEAD~1"
alias prettygit="git log --oneline --decorate --graph --all"

