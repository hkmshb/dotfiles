## aliases
#---------------------------------------
alias d='docker'
alias dc='docker compose'
alias dcb='docker compose build'
alias dcr='docker compose run'
alias dcps='docker compose ps'

alias di='docker image'
alias dr='docker run'
alias dv='docker volume'

# remove dangling images
alias di-drop-dangling='docker image rm $(docker images -f dangling=true)'


## 
#---------------------------------------
if [[ `uname -m` == "arm64" ]]; then
  export DOCKER_DEFAULT_PLATFORM=linux/amd64
fi
