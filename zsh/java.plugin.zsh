## exports
#-----------------------------------------------
export PATH="$HOME/.jenv/bin:$PATH"

## activations
#-----------------------------------------------
if (( $+commands[jenv] )); then
    eval "$(jenv init -)"
    jenv global zulu64-11.0.21
fi
