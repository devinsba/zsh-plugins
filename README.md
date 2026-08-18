# zsh-plugins

## Testing

`./test.sh` syntax-checks every plugin file and sources `init.plugin.zsh`
in isolated fake `$HOME`/`$PATH` environments, once with none of the
wrapped tools present and once with fnm/uv/sdkman stubbed in, to catch
loading errors without touching the real machine or requiring the actual
tools to be installed.