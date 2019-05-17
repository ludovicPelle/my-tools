# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#LANG
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# HISTORY (HSTR configuration)
alias hh=hstr                                           # hh to be alias for hstr
export HSTR_CONFIG=hicolor                              # get more colors
shopt -s histappend                                     # append new history items to .bash_history
export HISTCONTROL=ignorespace     # leading space hides commands from history
#export HISTCONTROL=ignorespace,ignoredups:erasedups     # leading space hides commands from history
export HISTFILESIZE=10000                               # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}                         # increase history size (default is 500)
# ensure synchronization between Bash memory and history file
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
# if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hstr -- \C-j"'; fi
# if this is interactive shell, then bind 'kill last command' to Ctrl-x k
if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\C-a hstr -k \C-j"'; fi
#Frequently hit command firsrt
#export HSTR_CONFIG=favorites-view


#DISPLAY
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#PROMPT
if [ -f ~/.bash_prompt ]; then
    . ~/.bash_prompt
fi

# COMPLETION enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ -f ~/my-tools/bash/django_bash_completion.sh ] && ! shopt -oq posix; then
    . ~/my-tools/bash/django_bash_completion.sh
fi

if [ -x "$(command -v gulp)" ]; then
    eval "$(gulp --completion=bash)"
fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
