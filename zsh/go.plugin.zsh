## exports
#---------------------------------------
export GO111MODULE=on
# export GOPATH=${HOME}/go
# export GOROOT=/Users/abdulhakeem/sdk/go1.18
# export PATH=${GOPATH}/bin:${PATH}

export GOBIN=${HOME}/go/bin
export GOENV_ROOT=${HOME}/.goenv

export PATH=${GOENV_ROOT}/bin:${PATH}

## aliases
#--------------------------------------
alias arm-go='GOOS=linux GOARCH=arm CC_FOR_TARGET=arm-linux-gnueabi-gcc go'

## activations
#--------------------------------------
if (( $+commands[goenv] )); then
	eval "$(goenv init -)"
	goenv global 1.19.3
fi

export PATH=${GOROOT}/bin:${PATH}
export PATH=${GOPATH}/bin:${PATH}
export PATH=${GOBIN}:${PATH}
