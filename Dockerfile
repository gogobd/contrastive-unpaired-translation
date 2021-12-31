FROM debian:bullseye-slim

ENV SHELL /bin/bash
  
# Install system dependencies
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl \
    wget \
    git \
    screen \
    unzip \
    vim \
    procps \
    locales \
    python3-pip \
 && apt-get clean

# Python unicode issues
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

# https://github.com/cdr/code-server
## Code server
RUN mkdir -p ~/.local/lib ~/.local/bin
RUN curl -sfL https://github.com/cdr/code-server/releases/download/v3.12.0/code-server-3.12.0-linux-amd64.tar.gz | tar -C ~/.local/lib -xz
RUN mv ~/.local/lib/code-server-3.12.0-linux-amd64 ~/.local/lib/code-server-3.12.0
RUN ln -s ~/.local/lib/code-server-3.12.0/bin/code-server ~/.local/bin/code-server
RUN PATH="~/.local/bin:$PATH"

## Fix broken python plugin # https://github.com/cdr/code-server/issues/2341
#RUN mkdir -p ~/.local/share/code-server/ && mkdir -p ~/.local/share/code-server/User && echo "{\"extensions.autoCheckUpdates\": false, \"extensions.autoUpdate\": false}" > ~/.local/share/code-server/User/settings.json 
RUN curl -sfLO https://open-vsx.org/api/ms-toolsai/jupyter/2021.8.12/file/ms-toolsai.jupyter-2021.8.12.vsix \
 && curl -sfLO https://open-vsx.org/api/ms-python/python/2021.9.1218897484/file/ms-python.python-2021.9.1218897484.vsix \
 && ~/.local/bin/code-server --install-extension ./ms-toolsai.jupyter-2021.8.12.vsix || true \
 && ~/.local/bin/code-server --install-extension ./ms-python.python-2021.9.1218897484.vsix || true \
 && rm ms-toolsai.jupyter-2021.8.12.vsix \
 && rm ms-python.python-2021.9.1218897484.vsix

WORKDIR /app
CMD ~/.local/bin/code-server --bind-addr 0.0.0.0:8080 /app

# docker build -t contrastive-unpaired-translation .
# docker exec -it $(docker run --gpus all -v /Volumes/remote/nasberrypi03.precalc.org/Public/Shared\ Data/deeplearning/datasets/:/datasets -v $(pwd):/app -p 8080:8080 -p 8081:8081 -it -d contrastive-unpaired-translation) cat /root/.config/code-server/config.yaml
