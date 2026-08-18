# zsh-plugins

## Testing

`./test.sh` syntax-checks every plugin file and sources `init.plugin.zsh`
in isolated fake `$HOME`/`$PATH` environments, once with none of the
wrapped tools present and once with fnm/uv/sdkman stubbed in, to catch
loading errors without touching the real machine or requiring the actual
tools to be installed. Fast, no Docker required.

`./test-docker.sh` is slower but more thorough: it builds a container
with fnm, uv, sdkman, nvm, pyenv, gvm, and rvm actually installed, then
sources every plugin in the repo individually (not just the ones
`init.plugin.zsh` currently loads) against the real tool output, both
with the tool present and with it removed from `$PATH`/`$HOME`. This is
what caught pyenv's plugin unconditionally calling `pyenv init -` with
no guard -- a stub wouldn't have. rvm's GPG signature check is skipped
to avoid a flaky keyserver dependency; see `docker/Dockerfile`.