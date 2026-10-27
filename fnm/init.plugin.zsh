if command -v fnm >/dev/null 2>&1; then
    echo "Loading fnm..."
    eval "$(fnm env --use-on-cd)"
fi
