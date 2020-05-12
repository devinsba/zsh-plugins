# https://gist.github.com/gfguthrie/9f9e3908745694c81330c01111a9d642

export NVM_DIR="${HOME}/.local/opt/nvm"
[ -s "${NVM_DIR}/bash_completion" ] && . "${NVM_DIR}/bash_completion"  # This loads nvm bash_completion

# add our default nvm node (`nvm alias default 10.16.0`) to path without loading nvm
export PATH="$NVM_DIR/versions/node/v$(<$NVM_DIR/alias/default)/bin:$PATH"
# alias `nvm` to this one liner lazy load of the normal nvm script
alias nvm="unalias nvm; [ -s "${NVM_DIR}/nvm.sh" ] && . "${NVM_DIR}/nvm.sh"; nvm $@"
