## exports
#-----------------------------------------------
export PATH="$HOME/.jenv/bin:$PATH"

## activations
#-----------------------------------------------
# NOTE: unlike pyenv and goenv, jenv can't be used to install a jdk/jre. You
# have to use `brew install`. However, after installation, you need to do 
# `jenv add <JAVA-HOME>` to add the jdk/jre to jenv for management.

if (( $+commands[jenv] )); then
    eval "$(jenv init -)"
    jenv global zulu64-17.0.11
fi

