# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
#HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# append to history whenever prompt is displayed
PROMPT_COMMAND='history -a'

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=50000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
# on debian style systems
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable bash-completion if available and not already done by the system
if [ -z "$BASH_COMPLETION" -a -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	*color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -z "$color_prompt" -a -n "$force_color_prompt" ]; then
	if [ -x $(which tput) ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

__svn_ps1() {
	local i=`svn info 2>/dev/null`

	if [ -n "$i" ]; then
		local p=`echo "$i" | grep '^URL:' | egrep -o '(tags|branches)/[^/]+|trunk' | egrep -o '[^/]+$'`
		local r=`echo "$i" | grep Revision: | cut -f 2 -d " "`
		printf "${1:- (%s)}" "${p}@rev$r"
	fi
}

if [ -r /usr/share/git/completion/git-prompt.sh ]; then
	. /usr/share/git/completion/git-prompt.sh
fi

__vcs_ps1() {
	local fmt=${1:- (%s)}

	local gitps1=$(__git_ps1 "${fmt}")
	echo -n "$gitps1"

	if [ -d ".svn" ]; then
		local svnps1=$(__svn_ps1 "${fmt}")
		echo -n "$svnps1"
	fi
}
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUPSTREAM=auto
export GIT_PS1_SHOWDIRYSTATE GIT_PS1_SHOWSTASHSTATE GIT_PS1_SHOWUPSTREAM

if [ "$color_prompt" = yes ]; then
	if [ `id -u` -eq 0 ]; then
		color_username_root='\[\033[01;31m\]'
	fi

    PS1='${debian_chroot:+($debian_chroot)}'"${color_username_root:-\[\033[01;33m\]}"'\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]$(__vcs_ps1 " (\[\033[01;35m\]%s\[\033[00m\])")\n'"${color_username_root}"'\$\[\033[00m\] '
	unset color_username_root
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h \w$(__vcs_ps1 " (%s)")\n\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h \w\a\]$PS1"
	;;
*)
	;;
esac

# enable color support of ls and also add handy aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

if [ -x $(which dircolors) ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# source host-specific configuration
if [ -f ~/.bashrc.local ]; then
	. ~/.bashrc.local
fi

# enable vi line editing
set -o vi

# enable extended globbing
shopt -s extglob
