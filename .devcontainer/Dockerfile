ARG VARIANT=2.7
FROM mcr.microsoft.com/vscode/devcontainers/ruby:0-${VARIANT} AS devcontainer

# Install Rails
RUN gem install rails webdrivers 

# Install a version of Node.js using nvm for dynamic front end content
ARG NODE_VERSION="lts/*"
RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

# [Optional] Uncomment this line to install additional gems.
RUN gem install rubocop bundle-audit
WORKDIR /workspace

# [Optional] Uncomment this line to install global node packages.
# RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g <your-package-here>" 2>&1
