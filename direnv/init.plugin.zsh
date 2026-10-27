if command -v direnv >/dev/null 2>&1; then
    echo "Loading direnv..."
    eval "$(direnv hook zsh)"
fi
