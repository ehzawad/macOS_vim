# shelterVim

clone and copy it into a home directory folder named ~/.vim

# Cool
# vim
# old shit

## BREW INSTALL CMAKE


# Edited by ehzawad@gmail.com
```bash
export ASAN_OPTIONS='stack_trace_format="[frame=%n, function=%f, location=%S]"'

export UBSAN_OPTIONS=print_stacktrace=1

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

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
export PATH="/usr/local/opt/openssl@3/bin:$PATH"

export LDFLAGS="-L/usr/local/opt/openssl@3/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@3/include"

export PATH=$PATH:/Library/PostgreSQL/14/bin

dockercleanup(){
docker system prune -a
}

tf() {
    source ~/tensorflow-metal/bin/activate
}

export PATH="$PATH:/usr/local/Cellar/sqlite:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"

# export PYTHON_CONFIGURE_OPTS="--enable-optimizations --with-lto --enable-framework"
#
export PYTHON_CONFIGURE_OPTS="--enable-optimizations --with-lto --enable-profiling --enable-framework --with-dtrace --with-system-expat --with-system-ffi --with-system-libmpdec"

allpipepip() {
pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U
}

alias brew="env PATH=${PATH//$(pyenv root)\/shims:/} brew"
export LD_PATH="$LD_PATH:/usr/local/lib"

export PATH=$(pyenv root)/shims:$PATH

```
