ME="${(%):-%x}"
CURRENT_DIR=$(dirname ${ME})

PLUGINS=("antibody-plugin-manager")

for PLUGIN in ${PLUGINS}; do
    source "${CURRENT_DIR}/${PLUGIN}/load.plugin.zsh"
done
