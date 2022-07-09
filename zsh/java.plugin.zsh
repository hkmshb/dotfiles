## exports
#-----------------------------------------------
export PATH="$HOME/.jenv/bin:$PATH"

## activations
#-----------------------------------------------
if (( $+commands[jenv] )); then
    eval "$(jenv init -)"
fi
