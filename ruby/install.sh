if [[ ! -d $(rbenv root)/plugins ]]; then
  # create plugins folder
  mkdir -p $(rbenv root)/plugins

  # install ruby interpreter
  rbenv install 2.7.2
fi

# update plugins
rbenv update
