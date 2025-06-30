#!/usr/bin/env elvish

## misc
set E:CZROOT    = $E:HOME/.local/share/chezmoi
set E:PROJECTS  = $E:HOME/projects
set E:PATH      = /usr/local/bin':'/usr/local/sbin':'/opt/homebrew/bin':'$E:HOME/.local/bin':'$E:CZROOT/bin':'$E:PATH

## android
set E:ANDROID_HOME     = $E:HOME/Library/Android/sdk
set E:ANDROID_SDK_ROOT = $E:HOME/Library/Android/sdk
set E:PATH             = $E:PATH':'$E:ANDROID_SDK_ROOT/emulator':'$E:ANDROID_SDK_ROOT/platform-tools

## golang
set E:GO111MODULE  = on
set E:CGO_ENABLED  = 1
set E:GOBIN        = $E:HOME/go/bin
set E:PATH         = $E:PATH':'$E:GOBIN

## pnpm
set E:PNPM_HOME    = $E:HOME/Library/pnpm
set E:PATH         = $E:PATH':'$E:PNPM_HOME

