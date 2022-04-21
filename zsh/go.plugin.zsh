## exports
#---------------------------------------
export GO111MODULE=on
export GOPATH=${HOME}/go
export GOROOT=/Users/abdulhakeem/sdk/go1.18
export PATH=${GOPATH}/bin:${PATH}


## aliases
#--------------------------------------
alias arm-go='GOOS=linux GOARCH=arm CC_FOR_TARGET=arm-linux-gnueabi-gcc go'
