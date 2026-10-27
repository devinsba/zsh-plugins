export NVM_DIR="${HOME}/.local/opt/nvm"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    echo "Loading NVM..."
    \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi
