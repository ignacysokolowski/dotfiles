# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

bash_prompt() {
  # define colors for prompt.
  local PS_CLEAR="\[\033[0;00m\]"
  local ORANGE="\[\033[0;33m\]"
  local GRAY="\[\033[0;37m\]"
  local GREEN="\[\033[0;32m\]"
  local RED="\[\033[0;31m\]"
  local RED_BG="\[\033[0;7;31m\]"
  local PINK="\[\033[0;35m\]"
  local CYAN="\[\033[0;36m\]"

  # append git branch and status to prompt.
  local git_branch=`git branch 2> /dev/null | grep '*' | sed 's!* !!'`

  if [ "x$git_branch" != x ]; then
    # change master branch to uppercase.
    if [ "$git_branch" == 'master' ]; then
      git_branch="${RED_BG}MASTER${PS_CLEAR}"
    fi
    # get modified, untracked and staged number.
    local status=`git status -s 2> /dev/null`
    local modified=`echo "$status" | grep ' M ' | wc -l`
    local untracked=`echo "$status" | grep '?? ' | wc -l`
    local staged=`echo "$status" | grep 'M  \|A ' | wc -l`

    local GIT_STATUS=" ${RED}[$git_branch ${PINK}$staged ${GREEN}$modified ${CYAN}$untracked${RED}]"
  fi

  # append SVN status to prompt.
  local svn_status=`svn st 2> /dev/null`

  if [ "x$svn_status" != x ]; then
    # get modified and new number.
    local modified=`echo "$svn_status" | grep 'M ' | wc -l`
    local new=`echo "$svn_status" | grep '? ' | wc -l`

    local SVN_STATUS=" ${RED}[SVN ${GREEN}$modified ${CYAN}$new${RED}]"
  fi

  # prepend virtualenv name to prompt.
  if [ x$VIRTUAL_ENV != x ]; then
    local folder=`dirname "${VIRTUAL_ENV}"`
    local ENV_NAME=`basename "$folder"`
    local IN_VIRTUALENV="($ENV_NAME)"
  fi

  PS1="$IN_VIRTUALENV${ORANGE}\u${GRAY}@${ORANGE}\h${GRAY}:${GREEN}\w$GIT_STATUS$SVN_STATUS${PS_CLEAR}\n${ORANGE}\$${PS_CLEAR} "
}

PROMPT_COMMAND=bash_prompt

export VIRTUAL_ENV_DISABLE_PROMPT=1

export MYSQL_PS1="MySQL \u@\h:\d> "

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.local_bash_aliases ]; then
    . ~/.local_bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ -f ~/.ssh/sssha ]; then
  . ~/.ssh/sssha
fi

# set PATH so it includes user's private bin if it exists.
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# Vi editing mode.
set -o vi

# Run local bashrc, ignored by dotfiles source control.
if [ -f ~/.local_bashrc ]; then
    . ~/.local_bashrc
fi
