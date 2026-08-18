FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        zsh \
        git \
        curl \
        ca-certificates \
        unzip \
        zip \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /usr/bin/zsh tester
USER tester
ENV HOME=/home/tester
WORKDIR /home/tester

RUN mkdir -p "${HOME}/.local/bin" "${HOME}/.local/opt"

# fnm
RUN curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "${HOME}/.local/bin" --skip-shell

# uv
RUN curl -LsSf https://astral.sh/uv/install.sh | env UV_INSTALL_DIR="${HOME}/.local/bin" INSTALLER_NO_MODIFY_PATH=1 sh

# nvm
RUN git clone https://github.com/nvm-sh/nvm.git "${HOME}/.local/opt/nvm" \
    && cd "${HOME}/.local/opt/nvm" \
    && git checkout "$(git describe --abbrev=0 --tags --match 'v[0-9]*' "$(git rev-list --tags --max-count=1)")"

# pyenv
RUN git clone https://github.com/pyenv/pyenv.git "${HOME}/.local/opt/pyenv"

# sdkman
RUN export SDKMAN_DIR="${HOME}/.local/opt/sdkman" \
    && curl -s -o /tmp/sdkman.sh "https://get.sdkman.io?rcupdate=false" \
    && bash /tmp/sdkman.sh

# gvm
RUN export GVM_ROOT="${HOME}/.local/opt/gvm" \
    && curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash

# rvm -- GPG signature verification deliberately skipped: it needs a
# keyserver fetch that's flaky/slow in sandboxed environments. Less secure
# than a real install; fine for a disposable test container.
RUN export rvm_path="${HOME}/.local/opt/rvm" \
    && curl -sSL https://get.rvm.io | bash -s -- --ignore-dotfiles --verify-downloads 0 stable

COPY --chown=tester:tester docker/run-tests.sh /home/tester/run-tests.sh
RUN chmod +x /home/tester/run-tests.sh

ENTRYPOINT ["/bin/sh", "/home/tester/run-tests.sh"]
