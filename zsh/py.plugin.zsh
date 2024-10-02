## exports
#---------------------------------------
export VENV_DIR=${HOME}/.pyenv/

if [ ! -d ${VENV_DIR} ]; then
  mkdir -p ${VENV_DIR}
fi

