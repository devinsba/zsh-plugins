ME="${(%):-%x}"
CURRENT_DIR=$(dirname ${ME})

PLUGINS=(antibody-plugin-manager)

function __import_plugin_directory() {
    (
        cd $1
        source *.plugin.zsh 2>&1 || true
        source *.zsh 2>&1 || true
        source *.sh 2>&1 || true
    )
}

for PLUGIN in ${PLUGINS}; do
    __import_plugin_directory "${CURRENT_DIR}/${PLUGIN}"
done

unset __import_plugin_directory
