# Adapted from the google-cloud-sdk Homebrew cask caveat
if command -v brew >/dev/null 2>&1; then
    GOOGLE_CLOUD_SDK_DIR="$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"
    if [[ -d "${GOOGLE_CLOUD_SDK_DIR}" ]]; then
        echo "Loading Google Cloud SDK..."
        source "${GOOGLE_CLOUD_SDK_DIR}/path.zsh.inc"
        source "${GOOGLE_CLOUD_SDK_DIR}/completion.zsh.inc"
    fi
fi
