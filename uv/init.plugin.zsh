if command -v uv >/dev/null 2>&1; then
    echo "Loading uv..."
    eval "$(uv generate-shell-completion zsh)"
    eval "$(uvx --generate-shell-completion zsh)"
fi
