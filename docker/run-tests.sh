#!/bin/sh
# Runs inside the container built from docker/Dockerfile. /plugins is a
# read-only mount of the repo; the container's real $HOME already has
# fnm/uv/nvm/pyenv/sdkman/gvm/rvm actually installed (see Dockerfile), so
# the "present" pass exercises each plugin against genuine tool output
# instead of a stub.
#
# Pass/fail is NOT the exit code of the sourced file: several plugins
# (nvm, rvm, gvm, sdkman) end in a `[ -s file ] && cmd` guard, whose exit
# code is just the guard's own falsy result when the tool is absent --
# that's correct, expected behavior, not a failure. Instead, a sentinel
# is printed after sourcing (proving zsh didn't choke on it) and the
# captured output is scanned for actual zsh error text.
set -eu

cd /plugins

status=0
out=$(mktemp)

echo "== syntax check =="
for f in $(find . -name '*.zsh' -o -name 'update_antidote_plugin_cache'); do
    if ! zsh -n "$f"; then
        echo "FAIL: $f"
        status=1
    fi
done

check_load() {
    label="$1"
    home_dir="$2"
    path_dir="$3"
    src="$4"

    HOME="$home_dir" PATH="$path_dir:/usr/bin:/bin" \
        zsh -f -c "${src}; print PLUGIN_TEST_SENTINEL" >"$out" 2>&1

    if ! grep -q PLUGIN_TEST_SENTINEL "$out"; then
        echo "FAIL: $label (zsh didn't survive sourcing)"
        cat "$out"
        status=1
    elif grep -Eiq 'parse error|command not found|no such file or directory|bad substitution|unrecognized option|permission denied|not an identifier|read-only variable' "$out"; then
        echo "FAIL: $label"
        cat "$out"
        status=1
    else
        echo "OK: $label"
    fi
}

echo "== per-plugin load test: tool absent =="
ABSENT_HOME=$(mktemp -d)
ABSENT_PATH=$(mktemp -d)
for dir in */; do
    plugin="${dir%/}"
    [ -f "${plugin}/init.plugin.zsh" ] || continue
    check_load "$plugin (absent)" "$ABSENT_HOME" "$ABSENT_PATH" "source ./${plugin}/init.plugin.zsh"
done

echo "== per-plugin load test: tool present (real install) =="
for dir in */; do
    plugin="${dir%/}"
    [ -f "${plugin}/init.plugin.zsh" ] || continue
    check_load "$plugin (present)" "$HOME" "$PATH" "source ./${plugin}/init.plugin.zsh"
done

echo "== full init.plugin.zsh load (curated PLUGINS set) =="
check_load "init.plugin.zsh" "$HOME" "$PATH" "source ./init.plugin.zsh"

rm -rf "$ABSENT_HOME" "$ABSENT_PATH" "$out"
exit $status
