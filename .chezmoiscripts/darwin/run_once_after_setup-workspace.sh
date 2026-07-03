#!/bin/bash

# create project dirs
# --------------------------------------------------------

folders=("ash", "foss" "hazel", "work")
for folder in "${folders[@]}"; do
  mkdir -p ~/projects/$folder
done


# symlink elvish scripts 
# --------------------------------------------------------
if [ -d ~/.config/elvish ]; then
  ln -s ~/.config/elvish ~/projects/ash/
fi


# set shell
# --------------------------------------------------------

# check that elvish is installed
if command -v elvish >/dev/null 2>&1; then
  ELVISH_PATH=$(command -v elvish)
  
  # check if elvish is already listed  in /etc/shells
  if ! grep -Fx $ELVISH_PATH /etc/shells >/dev/null; then
    echo $ELVISH_PATH >> /etc/shells
  fi

  # set default shell
  chsh -s $(which elvish)
fi

