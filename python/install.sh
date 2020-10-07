if [[ ! -d $(pyenv root)/plugins ]]; then
  # create plugins folder
  mkdir -p $(pyenv root)/plugins

  # install python interpreter
  pyenv install 3.8.5
fi

plugins=('virtualenv' 'update')
for plugin in "${plugins[@]}"
do
  if [[ ! -d $(pyenv root)/plugins/pyenv-${plugin} ]]; then
    echo "  Installing pyenv plugin: ${plugin} ..."
    git clone https://github.com/pyenv/pyenv-${plugin}.git $(pyenv root)/plugins/pyenv-${plugin}
  fi
done

# update plugins
pyenv update
