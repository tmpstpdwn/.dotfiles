
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
alias v='nvim'
alias dmenu='dmenu_shwal'
alias dotfiles='/usr/bin/git --git-dir=/home/srykrnm/.dotfiles/ --work-tree=/home/srykrnm'

### PROMPTS ###

GREEN="\[$(tput setaf 2)\]"
RESET="\[$(tput sgr0)\]"
PS1="[  ] ${GREEN}\W ${RESET}> "

### EXPORTS ###

export MANPAGER="bat"
export BROWSER="brave"
export TEXT_EDITOR="nvim"
export IMAGE_VIEWER="nsxiv"
export PDF_VIEWER="zathura"
export AUDIO_VIDEO="mpv"
export TERMINAL="st -e"

### END ###
