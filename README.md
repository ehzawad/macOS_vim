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


alias brew="env PATH=${PATH//$(pyenv root)\/shims:/} brew"
export LD_PATH="$LD_PATH:/usr/local/lib"

export PATH=$(pyenv root)/shims:$PATH

```


### python hacks
```bash
#!/bin/bash

# Function to check if running in a virtual environment or conda environment
is_virtual_env() {
    if [[ -n "$VIRTUAL_ENV" || -n "$CONDA_DEFAULT_ENV" ]]; then
        return 0
    else
        return 1
    fi
}

# Function to enforce Python 3.12 and its associated pip
enforce_python3.12() {
    if is_virtual_env; then
        # In a virtual environment or conda environment, use the original commands
        command "$@"
    else
        # Check if the command is python, python3, pip, pip3, or pip3.12
        if [[ "$1" == "python" || "$1" == "python3" ]]; then
            echo "Please specify python3.12"
        elif [[ "$1" == "pip" || "$1" == "pip3" || "$1" == "pip3.12" ]]; then
            echo "Please specify pip3.12"
        else
            command "$@"
        fi
    fi
}

# Function to print the absolute path of the Python executable
print_python_path() {
    if is_virtual_env; then
        echo "Python environment: $(which python)"
    else
        echo "Python environment: /home/ehz/.python312/bin/python3.12"
    fi
}

# Alias python, python3, pip, pip3, and pip3.12 to the enforce_python3.12 function
alias python='enforce_python3.12 python'
alias python3='enforce_python3.12 python3'
alias pip='enforce_python3.12 pip'
alias pip3='enforce_python3.12 pip3'
alias pip3.12='enforce_python3.12 pip3.12'

# Function to handle python3.12 command
python3.12() {
    if is_virtual_env; then
        # In a virtual environment, use the Python executable from the environment
        "$(which python)" "$@"
    else
        # Outside a virtual environment, use the default Python 3.12
        /home/ehz/.python312/bin/python3.12 "$@"
    fi
}
```

also is bashrc
```bash
# Set default python3.12 and pip3.12 to the desired location
export PATH="/home/ehz/.python312/bin:$PATH"

# Check if pip3.12 is installed, and set the alias accordingly
if [[ -f "/home/ehz/.python312/bin/pip3.12" ]]; then
    alias pip3.12="/home/ehz/.python312/bin/pip3.12"
else
    alias pip3.12='echo "Please install pip3.12 in /home/ehz/.python312/bin/"'
fi

# Print the Python path when activating a virtual environment
activate() {
    source "$@"
    print_python_path
}
```
