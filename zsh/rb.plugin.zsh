## exports
#-----------------------------------------------
# export PATH="$HOME/.pyenv/bin:$PATH"

## activations
#-----------------------------------------------
if (( $+commands[rbenv] )); then
    eval "$(rbenv init - --path)"
    rbenv global 3.1.1
fi
