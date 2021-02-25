# init
if (( $+commands[rbenv] )); then
    eval "$(rbenv init -)"
    rbenv global 2.7.2
fi
