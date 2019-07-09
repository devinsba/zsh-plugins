ME="$(pwd)/${(%):-%x}"
CURRENT_DIR=$(dirname ${ME})

PLUGINS=(antibody-plugin-manager)

function __import_plugin_directory() {
    (
        cd $1
        source *.plugin.zsh
        source *.zsh
        source *.sh
    )
}

for PLUGIN in ${PLUGINS}; do
    __import_plugin_directory "${CURRENT_DIR}/${PLUGIN}"
done

unset __import_plugin_directory
