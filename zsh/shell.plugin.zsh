## functions
#---------------------------------------
function kubectl-log() {
  if [[ ! "$1" =~ "nodes|pods" ]]; then
    echo "error: command unknown - '$1'. expected: nodes, pods"
    return
  fi

  local ln=$(kubectl get $1 | grep $2)
  if [[ $ln == "" ]]; then
    echo "error: no '$1' named '$2' found"
    return
  fi

  kubectl logs $(echo $ln | awk '{print $1}')
}


## exports
#---------------------------------------
export PATH="./bin:/usr/local/bin:/usr/local/sbin:$HOME/.local/bin:$CZROOT/bin:$PATH"
export PATH="/opt/protobuf/bin:/opt/bin:$PATH"


## activations
#---------------------------------------
export EDITOR=vi

# direnv
eval "$(direnv hook $SHELL)"

# mise
eval "$(mise activate zsh)"


# aliases
#---------------------------------------
alias cz='chezmoi'
alias reload!='source ~/.zshrc'

alias cat='bat'
alias vi='nvim'
alias .pl='pipelight --config ./.pipelight.ts'

# mise
alias .m='mise'
alias .mi='mise install'
alias .mr='mise run'
alias .mu='mise use'

# k8s
alias .kc='kubectl'
alias .kc-info='kubectl cluster-info'
alias .kc-gnod='kubectl get nodes'
alias .kc-gpod='kubectl get pods'
alias .kc-plog="kubectl-log pods $1"

# hammerspoon
# usage: <bash-command>; (.hs-alert|.hs-nag)
alias .hs-alert='hs -A -c "notifyTaskCompleted()"'
alias .hs-nag='hs -A -c "nagScreen()"'

