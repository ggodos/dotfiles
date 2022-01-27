# export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="norm"
HYPHEN_INSENSITIVE="true"
zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time
# zstyle ':omz:update' frequency 13
# DISABLE_MAGIC_FUNCTIONS="true"
# DISABLE_LS_COLORS="true"
DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="mm/dd/yyyy"
# ZSH_CUSTOM=/path/to/new-custom-folder
plugins=(
    git
    fast-syntax-highlighting
    zsh-system-clipboard
)

source $ZSH/oh-my-zsh.sh

# export MANPATH="/usr/local/man:$MANPATH"
# export LANG=en_US.UTF-8

setopt autocd		# Automatically cd into typed directory.
setopt interactive_comments

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.cache/zsh/history
zstyle :compinstall filename '/home/maxim/.zshrc'

EDITOR=nvim

### "bat" as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

#PATHES
. "$HOME/.cargo/env"

PATH="/usr/local/go/bin:$PATH"
PATH="${HOME}/.cargo/bin:$PATH"
PATH="/opt/ltex-ls-15.1.0/bin:$PATH"
PATH="${HOME}/scripts:$PATH"
PATH="${HOME}/tools:$PATH"
PATH="${HOME}/.config/dmscripts/scripts:$PATH"
PATH="${HOME}/Qt/Tools/QtCreator/bin:$PATH"
PATH="${HOME}/Qt/Tools/QtDesignStudio/bin:$PATH"

config_dirs+=(
"${HOME}/.config/dmscripts/config"
)

#aliases
alias open='xdg-open'
alias vim='nvim'
alias copy='xargs echo -n | xclip -selection clipboard'
alias lf='lfrun'
alias fsw='file_switch'

# python environment
alias penv='python_virtualenv -p 3.10 -e venv 1>/dev/null \
    && source ./venv/bin/activate '
alias deact='deactivate'

# git
alias addup='git add -u'
alias addall='git add .'
#alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias stat='git status'  # 'status' is protected name so using 'stat' instead
alias tag='git tag'
alias newtag='git tag -a'



# folders
alias proj="cd ~/dev/proj/"
alias nvimconf="cd ~/.config/nvim"
alias sem1="cd ~/learn/sem1"
alias sem2="cd ~/learn/sem2"
alias sem3="cd ~/learn/sem3"
alias sem4="cd ~/learn/sem4"

# configurate
alias nviminit="vim ~/.config/nvim/init.vim"
alias xmonadconf="vim ~/.xmonad/xmonad.hs"
alias config='/usr/bin/git --git-dir=/home/maxim/dotfiles/ --work-tree=/home/maxim'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='exa -al --color=always --group-directories-first $* --icons'
    alias la='exa -a --color=always --group-directories-first $*  --icons' 
    alias ll='exa -l --color=always --group-directories-first $*  --icons' 
    alias lt='exa -aT --color=always --group-directories-first $* --icons'
    alias l.='exa -a1 $* | grep "^\."'                            

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# gpg encryption
# verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
# receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"


# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' completer _expand_alias _complete _ignored
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)	


# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char


### Function extract for common file formats ###
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

function ex {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: ex <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       ex <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace)      unace x ./"$n"      ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

bindkey -s '^o' 'lf\n'
bindkey -s '^a' 'bc -lq\n'
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'
bindkey '^[[P' delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line


#PERL perl
PATH="/home/maxim/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/maxim/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/maxim/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/maxim/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/maxim/perl5"; export PERL_MM_OPT;


if [[ -x /usr/lib/command-not-found ]] ; then
	if (( ! ${+functions[command_not_found_handler]} )) ; then
		function command_not_found_handler {
			[[ -x /usr/lib/command-not-found ]] || return 1
			/usr/lib/command-not-found --no-failure-msg -- ${1+"$1"} && :
		}
	fi
fi

which_term(){
    term=$(ps -p $(ps -p $$ -o ppid=|xargs) -o args=);
    echo $term
}
