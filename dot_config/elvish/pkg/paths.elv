#!/usr/bin/env elvish

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

## bun
set E:BUN_BIN      = $E:HOME/.bun/bin

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
  $E:ANDROID_SDK_ROOT/emulator
  $E:ANDROID_SDK_ROOT/platform-tools
  $E:CZROOT/r/bin
  $E:PNPM_HOME
  $E:BUN_BIN
  $E:GOBIN
]

