## exports
#---------------------------------------
export PATH="./bin:/usr/local/bin:/usr/local/sbin:$HOME/.local/bin:$CZROOT/bin:$PATH"
export PATH="/opt/protobuf/bin:$PATH"


# aliases
#---------------------------------------
alias cz='chezmoi'
alias cm='chezmoi'
alias reload!='source ~/.zshrc'

alias vi='nvim'


## activations
#---------------------------------------
export EDITOR=vi


# direnv
eval "$(direnv hook $SHELL)"
