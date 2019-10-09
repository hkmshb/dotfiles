alias d='docker $*'
alias d-c='docker-compose $*'
alias d-rmdi='docker rmi $(docker images --quiet --filter "dangling=true")'
