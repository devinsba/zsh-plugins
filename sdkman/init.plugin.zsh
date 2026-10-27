# Adapted from: https://www.reddit.com/r/node/comments/4tg5jg/lazy_load_nvm_for_faster_shell_start/d5ib9fs

export SDKMAN_DIR="${HOME}/.local/opt/sdkman"
if [[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]]; then
    echo "Loading SDKMAN..."
    . "${SDKMAN_DIR}/bin/sdkman-init.sh"
fi

# Point JAVA_HOME at the newest installed LTS JDK (8, 11, then 17 and every
# fourth release after it: 21, 25, ...). The Java version comes from each JDK's
# release file because SDKMAN identifiers (e.g. 25.4.4.1+1-graalce) don't
# always match it.
_sdkman_set_java_home() {
    autoload -Uz is-at-least
    local dir release version major best_dir best_version best_major=0

    for dir in "${SDKMAN_DIR}"/candidates/java/*(N/); do
        release="${dir}/release"
        [[ -r "${release}" ]] || continue
        version=${(Q)${${(M)${(f)"$(<${release})"}:#JAVA_VERSION=*}#JAVA_VERSION=}}
        [[ -n "${version}" ]] || continue

        major=${version%%.*}
        [[ "${major}" == 1 ]] && major=${${version#1.}%%.*}
        (( major == 8 || major == 11 || (major >= 17 && (major - 17) % 4 == 0) )) || continue

        if (( major > best_major )) || { (( major == best_major )) && is-at-least "${best_version}" "${version}"; }; then
            best_dir="${dir}"
            best_version="${version}"
            best_major="${major}"
        fi
    done

    [[ -n "${best_dir}" ]] && export JAVA_HOME="${best_dir}"
}
_sdkman_set_java_home
unfunction _sdkman_set_java_home
