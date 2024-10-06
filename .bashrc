
### BASHRC  ###

### SOME-RANDOM-STUFF ###

[[ $- != *i* ]] && return

### ALIAS ###

alias ls='exa -lah'
alias ..='cd ..'
alias grep='grep --color=auto'
alias cat='bat'
alias lf='lf-ub'
alias xclipc='xclip -selection clipboard'
alias xclipp='xclip -o'
alias v='vim'
alias dmenu='dmenu_shwal'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

### PROMPTS ###

GREEN="\[$(tput setaf 2)\]"
RESET="\[$(tput sgr0)\]"
PS1="[  ] ${GREEN}\W ${RESET}> "

### EXPORTS ###

export MANPAGER="bat"
export BROWSER="firefox"
export TEXT_EDITOR="nvim"
export IMAGE_VIEWER="nsxiv"
export PDF_VIEWER="zathura"
export AUDIO_VIDEO="mpv"
export TERMINAL="alacritty -e"

### END ###
