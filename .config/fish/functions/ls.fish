function ls --wraps='exa -lah' --wraps='eza ' --wraps='eza -lah' --description 'alias ls=eza -lah'
    eza -lah $argv
end
