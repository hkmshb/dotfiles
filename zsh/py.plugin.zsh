## exports
#-----------------------------------------------
# export PATH="$HOME/.pyenv/bin:$PATH"

## activations
#-----------------------------------------------
if (( $+commands[pyenv] )); then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    pyenv global 3.12.2
fi
