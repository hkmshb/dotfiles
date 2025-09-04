#!/bin/bash

set -eufo pipefail

trap 'killall Dock' EXIT

declare -a remove_labels=(
  Launchpad
  Messages
  Mail
  Maps
  Photos
  FaceTime
  Contacts
  Reminders
  Notes
  TV
  Keynote
  Pages
  "App Store"
)

for label in "${remove_labels[@]}"; do
  dockutil --no-restart --remove "${label}" || true
done


declare -a add_labels=(
  /System/Applications/Podcasts.app
  /Applications/iTerm.app
  /Applications/Ghostty.app
  /Applications/Slack.app
  /Applications/Orion.app
  /Applications/Safari.app
  /Applications/Numbers.app
  /System/Applications/Calendar.app
  /System/Applications/Books.app
  /Applications/Logseq.app
  /System/Applications/Freeform.app
  /Applications/TickTick.app
  /Applications/Bitwarden.app
)

for label in "${add_labels[@]}"; do
  dockutil --no-restart --add "${label}" || true
done
