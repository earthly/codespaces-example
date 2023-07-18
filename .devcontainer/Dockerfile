# Basic Dockerfile for installing latest Earthly version
FROM mcr.microsoft.com/devcontainers/universal:2

RUN apt update && apt install -y bash-completion 

# For additional Earthly install information view our documentation here:
# https://earthly.dev/get-earthly
RUN /bin/sh -c 'wget https://github.com/earthly/earthly/releases/latest/download/earthly-linux-amd64 -O /usr/local/bin/earthly && chmod +x /usr/local/bin/earthly && /usr/local/bin/earthly bootstrap --with-autocomplete'