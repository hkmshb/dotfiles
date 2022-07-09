## exports
#---------------------------------------
export PATH="./bin:/usr/local/bin:/usr/local/sbin:$HOME/.local/bin:$CZROOT/bin:$PATH"


## aliases
#---------------------------------------
alias cz='chezmoi'
alias cm='chezmoi'
alias reload!='source ~/.zshrc'


## activations
#---------------------------------------
export EDITOR=micro

# direnv
eval "$(direnv hook $SHELL)"
