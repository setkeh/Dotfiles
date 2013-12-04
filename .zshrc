#!/bin/zsh

#Git
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
	    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
	    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' enable git cvs svn

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
vcs_info
if [ -n "$vcs_info_msg_0_" ]; then
echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
fi
}

# completion
autoload -U compinit
compinit

# prompt
autoload -U promptinit
promptinit
#prompt elite

# history
export HISTSIZE=2000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

# User Defined Exports
export PATH=$PATH:$HOME/avr32-tools/bin
export PATH=$PATH:$HOME/.gem/ruby/1.9.3/bin

# setopt
setopt ALL_EXPORT
setopt notify globdots correct pushdtohome cdablevars autolist
setopt correctall autocd recexact longlistjobs nohup incappendhistory sharehistory extendedhistory
setopt autoresume histignoredups pushdsilent menucomplete
setopt autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -a zsh/mapfile mapfile

autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
colors
fi

for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
(( count = $count + 1 ))
done

#Start WM/DE On Logon TTY1
echo "Checking Current TTY"
TTY=$(tty)
if [ $TTY = "/dev/tty1" ]
	then
	echo "Current TTY = $TTY Running Awesome"
	/usr/bin/xinit
	# This can be changed from /usr/bin/xinit to somthing like
	# /usr/bin/enlightenment_start
	# or
	# /usr/bin/awesome
	# Depending on how you would like to start your WM
else
	echo "Current TTY = $TTY"
	echo "No Need for a Display Manager"
	echo "Have Fun"
fi

# Set the Prompt
PR_NO_COLOR="%{$terminfo[sgr0]%}"
PROMPT='%{$fg[cyan]%}%n%{$fg[blue]%}@%{$fg[magenta]%}%m %{$fg[yellow]%}%~ %{$fg[red]%}$(vcs_info_wrapper)%{$fg[green]%}%#%{$reset_color%} '
#PS1="%F{yellow}%B[%f$PR_BLUE%n$PR_YELLOW@$PR_RED%U%m%u$PR_YELLOW:$PR_RED%2c$PR_YELLOW]$PR_BLUE$(vcs_info_wrapper)%(!.#.$) $PR_NO_COLOR"
RPS1="$PR_LIGHT_YELLOW(%D{%m-%d %H:%M})$PR_NO_COLOR"

# Some Basic but handy Exports change these to match your systems defaults (or your configuration)
LC_ALL='en_AU.UTF-8'
LANG='en_AU.UTF-8'
LC_CTYPE='en_AU.UTF-8'
#LC_CTYPE=C

# This is usefull for AMD / Catalyst Graphics Cards.
LIBGL_DRIVERS_PATH=/usr/lib32/xorg/modules/dri

unsetopt ALL_EXPORT

# Baisc Proxy for Current Shell can be started with "proxy" and stopped with "proxyoff"
 function proxy(){
     export http_proxy="http://username:password@ip/domain:port/"
     export https_proxy=$http_proxy
     export ftp_proxy=$http_proxy
     export rsync_proxy=$http_proxy
     export no_proxy="localhost,127.0.0.1,localaddress,.local"
     echo -e "\nProxy environment variable set."
 }
 function proxyoff(){
     unset HTTP_PROXY
     unset http_proxy
     unset HTTPS_PROXY
     unset https_proxy
     unset FTP_PROXY
     unset ftp_proxy
     unset RSYNC_PROXY
     unset rsync_proxy
     echo -e "\nProxy environment variable removed."
 } 

#User Exports
export EDITOR="/usr/bin/vim"
export DISPLAY=:0
export GPU_USE_SYNC_OBJECTS=1
export GPU_MAX_ALLOC_PERCENT=100
export LIBVA_DRIVER_NAME=vdpau
export VDPAU_DRIVER=r600

# Aliases Start
alias man='LC_ALL=C LANG=C man'
alias ls='ls --color=auto '
alias ncmpc='ncmpc -c'
alias =clear
#alias vim='vim -o /home/setkeh/notes' 
alias partyline='telnet 74.112.203.77 57660'

#Other Handy/Dev Alias's
alias net='sudo wifi-menu wlp3s0'
alias android='/opt/android-sdk/tools/android'
alias adb='/opt/android-sdk/platform-tools/adb'
# Aliases End

# key binding
bindkey -e
bindkey "\e[1~" beginning-of-line # Home
bindkey "\e[4~" end-of-line # End
bindkey "\e[5~" beginning-of-history # PageUp
bindkey "\e[6~" end-of-history # PageDown
bindkey "\e[2~" quoted-insert # Ins
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey '^?' backward-delete-char
bindkey '^[[3~' delete-char
bindkey "\e[7~" beginning-of-line # Home
bindkey "\e[8~" end-of-line # End

zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors \
     'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
        
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

## add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -A -o pid,user,cmd'
zstyle ':completion:*:processes-names' command 'ps axho command'

# New completion:
# 1. All /etc/hosts hostnames are in autocomplete
# 2. If you have a comment in /etc/hosts like #%foobar.domain,
# then foobar.domain will show up in autocomplete!
zstyle ':completion:*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts | grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}')

# http://www.sourceguru.net/ssh-host-completion-zsh-stylee/
zstyle -e ':completion::*:*:*:hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
        named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd\
        avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail\
        firebird gnats haldaemon hplip irc klog list man cupsys postfix\
        proxy syslog www-data mldonkey sys snort

# SSH Completion
zstyle ':completion:*:scp:*' tag-order files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
