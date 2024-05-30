# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PATH=$PATH:/home/ehz/.FileZilla3/bin
export PATH=$PATH:/home/ehz/.node/bin/

asrttsserver(){
ssh root@192.168.10.98
}

MTBserver() {
    ssh -t root@192.168.10.98 "ssh -t appadm@10.45.57.103 'sudo -i'"
}

MTBproj() {
    ssh -t root@192.168.10.98 "ssh -t appadm@10.45.57.103 'sudo -i bash -c \"cd /usr/local/rasa3-main && bash\"'"
}

#!/bin/bash

# SSH and server details
proxy_command="ssh -q -W %h:%p root@192.168.10.98"
remote_user="appadm"
remote_host="10.45.57.103"
remote_directory="/home/appadm"
local_base_directory="/home/ehz/MTBserverSCPed"

# Function to pull files/directories from the remote server
function pullmtb() {
  if [ $# -eq 0 ]; then
    echo "Please provide the absolute path of the file or directory on the remote server."
    return 1
  fi

  remote_path="$1"
  local_path="$local_base_directory/pullmtb/${remote_path##*/}"

  if ssh -o ProxyCommand="$proxy_command" "$remote_user@$remote_host" test -d "$remote_path"; then
    scp -r -o ProxyCommand="$proxy_command" "$remote_user@$remote_host:$remote_path" "$local_path"
  else
    scp -o ProxyCommand="$proxy_command" "$remote_user@$remote_host:$remote_path" "$local_path"
  fi

  echo "Pull operation completed."
}

# Function to push files/directories to the remote server
function pushmtb() {
  if [ $# -eq 0 ]; then
    echo "Please provide the absolute path of the file or directory on your local PC."
    return 1
  fi

  local_path="$1"
  remote_path="$remote_directory/${local_path##*/}"

  if test -d "$local_path"; then
    scp -r -o ProxyCommand="$proxy_command" "$local_path" "$remote_user@$remote_host:$remote_path"
  else
    scp -o ProxyCommand="$proxy_command" "$local_path" "$remote_user@$remote_host:$remote_path"
  fi

  echo "Push operation completed."
}

export PATH=/usr/local/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

pull(){
scp -r -o ProxyJump=root@192.168.10.98 -o 'ProxyCommand=ssh -W %h:%p root@192.168.10.98 "sudo -u appadm ssh"' appadm@10.45.57.103:/usr/local/rasa3-main .
}

push(){
scp -r -o ProxyJump=root@192.168.10.98 -o 'ProxyCommand=ssh -W %h:%p root@192.168.10.98 "sudo -u appadm ssh"' . appadm@10.45.57.103:/usr/local/rasa3-main
}
#
#
#

export PATH="$HOME/.ruby3/bin:$PATH"
#
#


# Function to get the list of installed Python versions
get_python_versions() {
    local python_dirs
    python_dirs=$(find "$HOME/.python"* -maxdepth 0 -type d 2>/dev/null)
    python_versions=()
    for dir in $python_dirs; do
        version=$(basename "$dir" | sed 's/\.python//')
        python_versions+=("$version")
    done
}

# Get the list of installed Python versions
get_python_versions

# Set the PATH to include the bin directories of installed Python versions
for version in "${python_versions[@]}"; do
    export PATH="$HOME/.python$version/bin:$PATH"
done

# Check if pip is installed for each Python version and set the aliases accordingly
for version in "${python_versions[@]}"; do
    if [[ -f "$HOME/.python$version/bin/pip" ]]; then
        alias pip$version="$HOME/.python$version/bin/pip"
    else
        alias pip$version='echo "Please install pip'"$version"' in $HOME/.python'"$version"'/bin/"'
    fi
done

# Function to check if running in a virtual environment or conda environment
is_virtual_env() {
    if [[ -n "$VIRTUAL_ENV" || -n "$CONDA_DEFAULT_ENV" ]]; then
        return 0
    else
        return 1
    fi
}

# Function to enforce a specific Python version and its associated pip
enforce_python() {
    if is_virtual_env; then
        # In a virtual environment or conda environment, use the original commands
        command "$@"
    else
        # Check if the command is python, python3, pip, or pip3
        if [[ "$1" == "python" || "$1" == "python3" ]]; then
            echo "Please specify the desired Python version. Available versions: ${python_versions[*]}"
        elif [[ "$1" == "pip" || "$1" == "pip3" ]]; then
            echo "Please create a virtual environment and then run pip. It is recommended."
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
        echo "Python environment: $HOME/.python$version/bin/python$version"
    fi
}

# Alias python, python3, pip, and pip3 to the enforce_python function
alias python='enforce_python python'
alias python3='enforce_python python3'
alias pip='enforce_python pip'
alias pip3='enforce_python pip3'

# Function to handle python* command for each version
for version in "${python_versions[@]}"; do
    eval "python$version() {
        if is_virtual_env; then
            # In a virtual environment, use the Python executable from the environment
            \"\$(which python)\" \"\$@\"
        else
            # Outside a virtual environment, use the default Python \$version
            $HOME/.python$version/bin/python$version \"\$@\"
        fi
    }"
done

# Print the Python path when activating a virtual environment
activate() {
    source "$@"
    print_python_path
}
