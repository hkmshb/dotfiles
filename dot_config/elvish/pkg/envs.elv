#!/usr/bin/env elvish

# env-vars 
# --------------------------------------------
set E:TERM      = xterm-256color


# paths
# --------------------------------------------

## misc
set E:CZROOT    = $E:HOME/.local/share/chezmoi
set E:PROJECTS  = $E:HOME/projects

## android
set E:ANDROID_HOME     = $E:HOME/Library/Android/sdk
set E:ANDROID_SDK_ROOT = $E:HOME/Library/Android/sdk

## golang
set E:GO111MODULE  = on
set E:CGO_ENABLED  = 1
set E:GOPATH       = $E:HOME/go
set E:GOBIN        = $E:GOPATH/bin

## pnpm
set E:PNPM_HOME    = $E:HOME/Library/pnpm

## podman
# set E:DOCKER_HOST = ssh://core@localhost:63336
set E:DOCKER_SOCK = /run/user/503/podman/podman.sock

set paths = [
  /bin
  /sbin
  /usr/bin
  /usr/sbin
  /usr/local/bin
  /usr/local/sbin
  /opt/homebrew/bin
  $E:HOME/.local/bin
  $E:ANDROID_SDK_ROOT/emulator
  $E:ANDROID_SDK_ROOT/platform-tools
  $E:CZROOT/r/bin
  $E:PNPM_HOME/bin
  $E:PNPM_HOME
  $E:GOBIN
]

