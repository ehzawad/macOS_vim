# shelterVim

clone and copy it into a home directory folder named ~/.vim

# Cool
# vim
# old shit

## BREW INSTALL CMAKE


# Edited by ehzawad@gmail.com
```bash
parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}
COLOR_DEF='%f'
COLOR_USR='%F{243}'
COLOR_DIR='%F{197}'
COLOR_GIT='%F{39}'
NEWLINE=$'\n'
setopt PROMPT_SUBST
export PROMPT='${COLOR_USR}%n ${COLOR_DIR}%~ ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF}${NEWLINE}%% '

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
```
