# Adapted from: https://www.reddit.com/r/node/comments/4tg5jg/lazy_load_nvm_for_faster_shell_start/d5ib9fs

export PYENV_ROOT="$HOME/.local/opt/pyenv"
echo "Loading pyenv..."
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"