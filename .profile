### .profile ###

[[ -f ~/.bashrc ]] && . ~/.bashrc

### EXPORTS ###

# add all folders in ~/.local/bin to $PATH

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.scripts:$PATH"

### DEFAULT APPS ###

export MANPAGER="bat"
export BROWSER="brave"
export TEXT_EDITOR="nvim"
export IMAGE_VIEWER="nsxiv"
export PDF_VIEWER="zathura"
export AUDIO_VIDIO="mvp"
export TERMINAL="alacritty -e"
export MENU="dmenu"

### STARTX ###

#startx

### END ###

