## exports
#---------------------------------------
export GO111MODULE=on

export GOENV_ROOT=${HOME}/.goenv
export PATH=${GOENV_ROOT}/bin:${PATH}

## aliases
#--------------------------------------
alias arm-go='GOOS=linux GOARCH=arm CC_FOR_TARGET=arm-linux-gnueabi-gcc go'

## activations
#--------------------------------------
if (( $+commands[goenv] )); then
	eval "$(goenv init -)"
	goenv global 1.20.1
fi

export GOBIN=${HOME}/go/bin
export PATH=${GOBIN}:${PATH}
export PATH=${GOROOT}/bin:${PATH}
export PATH=${PATH}:${GOPATH}/bin
