function antibody__update_plugins_cache() {
    PLUGINS_FILE="${XDG_CONFIG_HOME}/antibody/plugins.zsh"
    antibody bundle < "${XDG_CONFIG_HOME}/antibody/plugins.txt" > "${PLUGINS_FILE}"
}
