## aliases
#--------------------------------------
alias gb='git branch'
alias gs='git status -sb'

alias gc='git commit'
alias gco='git checkout'

alias gd='git diff'
alias gds='git diff --staged'

alias glo='git log --oneline --decorate'
alias glog='git log --oneline --decorate --graph'

alias gcd='git checkout develop'
alias gcd!='git checkout develop && git pull'

alias gcm='git checkout main'
alias gcm!='git checkout main && git pull'

alias gcs='git checkout staging'
alias gcs!='git checkout staging && git pull'

alias gb-prune='git remote prune origin'
