### .profile ###

[[ -f ~/.bashrc ]] && . ~/.bashrc

### EXPORTS ###

# add all folders in ~/.local/bin to $PATH

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.scripts:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

### DEFAULT APPS ###

export MANPAGER="bat"
export BROWSER="firefox"
export TEXT_EDITOR="vim"
export IMAGE_VIEWER="nsxiv"
export PDF_VIEWER="zathura"
export AUDIO_VIDIO="mvp"
export TERMINAL="alacritty -e"
export MENU="dmenu"

### STARTX ###

#startx

### END ###

