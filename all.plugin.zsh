ME="${(%):-%x}"
CURRENT_DIR=$(dirname ${ME})

PLUGINS=("antibody-plugin-manager")

function __import_plugin_directory() {
    (
        cd $1
        for file in $(find . -maxdepth 1 -name "*.plugin.zsh"); do
            source "${file}"
        done
    )
}

for PLUGIN in ${PLUGINS}; do
    __import_plugin_directory "${CURRENT_DIR}/${PLUGIN}"
done

unset __import_plugin_directory
