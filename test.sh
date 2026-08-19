#!/bin/sh
# Syntax-checks every zsh file in this repo, then sources init.plugin.zsh in
# isolated fake environments (fake $HOME + $PATH, so nothing on the real
# machine is touched or relied on) to make sure loading it doesn't error,
# both when the wrapped tools (fnm, uv, sdkman) are absent and when they're
# present.
#
#   ./test.sh
set -eu

cd "$(dirname "$0")"

status=0
out=$(mktemp)
trap 'rm -f "$out"' EXIT

echo "== syntax check =="
for f in $(find . -name '*.zsh' -o -name 'update_antidote_plugin_cache'); do
    if ! zsh -n "$f"; then
        echo "FAIL: $f"
        status=1
    fi
done

run_load_test() {
    label="$1"
    fake_home="$2"
    fake_path="$3"

    if HOME="$fake_home" PATH="$fake_path:/usr/bin:/bin" zsh -f -c 'source ./init.plugin.zsh' >"$out" 2>&1; then
        echo "OK: load with $label"
    else
        echo "FAIL: load with $label"
        cat "$out"
        status=1
    fi
}

echo "== load test: tools absent =="
ABSENT_HOME=$(mktemp -d)
ABSENT_PATH=$(mktemp -d)
run_load_test "no tools installed" "$ABSENT_HOME" "$ABSENT_PATH"

echo "== load test: tools present (stubbed) =="
PRESENT_HOME=$(mktemp -d)
STUB_BIN=$(mktemp -d)
for tool in fnm uv uvx; do
    printf '#!/bin/sh\n:\n' > "${STUB_BIN}/${tool}"
    chmod +x "${STUB_BIN}/${tool}"
done
mkdir -p "${PRESENT_HOME}/.local/opt/sdkman/bin"
printf '#!/bin/zsh\n:\n' > "${PRESENT_HOME}/.local/opt/sdkman/bin/sdkman-init.sh"
run_load_test "fnm/uv/sdkman installed" "$PRESENT_HOME" "$STUB_BIN"

rm -rf "$ABSENT_HOME" "$ABSENT_PATH" "$PRESENT_HOME" "$STUB_BIN"

exit $status
