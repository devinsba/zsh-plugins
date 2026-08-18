#!/bin/sh
# Docker-based tests: builds an image with fnm, uv, sdkman, nvm, pyenv,
# gvm, and rvm actually installed, then sources every plugin (not just
# the ones init.plugin.zsh currently loads) against the real tool output.
# Slower and heavier than test.sh, but catches things a stub can't, e.g.
# a real `pyenv init -` or `fnm env` emitting something a guard doesn't
# handle. rvm's GPG signature check is skipped -- see docker/Dockerfile.
#
#   ./test-docker.sh
set -eu

cd "$(dirname "$0")"

docker build -t zsh-plugins-test -f docker/Dockerfile . >&2
exec docker run --rm -it -v "$(pwd):/plugins:ro" zsh-plugins-test
