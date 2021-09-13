# NOTE: Setting pyenv and pyenv virtualenv variables is not needed when
# using oh-my-zsh with the pyenv plugin

# Environment variable PYENV_ROOT to point to the pyenv repo
# export PYENV_ROOT="$HOME/.pyenv"
export PYENV_ROOT="$HOME/.pyenv"

# Add $PYENV_ROOT/bin to $PATH for access to the pyenv command-line utility
export PATH="$PYENV_ROOT/bin:$PATH"

# Enable pyenv shims and autocompletion
# NOTE: Must be placed toward the end since it manipulates PATH during init
eval "$(pyenv init --path)"

# Enable auto-activation of virtualenvs
eval "$(pyenv virtualenv-init -)"

# TODO not sure if of any use
# Fix to access Python virtualenv from vim with zsh shell
# https://vi.stackexchange.com/questions/7644/use-vim-with-virtualenv/7654#7654
if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi
