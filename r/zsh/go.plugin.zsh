## exports
#---------------------------------------
export GO111MODULE=on
export CGO_ENABLED=1

export GOBIN=${HOME}/go/bin
export PATH=${GOBIN}:${PATH}

## aliases
#--------------------------------------
alias arm-go='GOOS=linux GOARCH=arm CC_FOR_TARGET=arm-linux-gnueabi-gcc go'

