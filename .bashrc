# https://github.com/alloydwhitlock/dotfiles 

# Prevent CTRL-D exit of everything

IGNOREEOF=3   # Shell only exists after the 3rd consecutive Ctrl-D


# Custom functions

decode_pig () {
    echo "$1" | base64 -d ; echo
}

jsonpretty() {
    [[ $# -ne 1 ]] && echo "Please provide a URL to retrive" 

    [[ $# -eq 1 ]] && curl ${1} | python -m json.tool 

}

diffgit() {
    git diff ${1}^!
}


# Custom Aliases

alias projects="cd ~/src"
alias cleanrepo="git reset --hard origin/master"
alias diffrepo="git diff HEAD^ HEAD"
alias revertcommit="git reset --soft HEAD~1"
alias prettygit="git log --oneline --decorate --graph --all"
