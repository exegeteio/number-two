ARG VARIANT=2.7
FROM mcr.microsoft.com/vscode/devcontainers/ruby:${VARIANT} AS devcontainer

# Set up listening ports.
EXPOSE 5000
ENV PORT 5000
ENV BINDING 0.0.0.0

# Install Rails
RUN gem install bundler rails webdrivers 

# Install a version of Node.js using nvm for dynamic front end content
ARG NODE_VERSION="lts/*"
RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
	&& apt-get -y install --no-install-recommends postgresql-client

# [Optional] Uncomment this line to install additional gems.
RUN gem install \
	bundle-audit \
	debase \
	htmlbeautifier \
	rubocop \
	ruby-debug-ide \
	solargraph

WORKDIR /workspace

# [Optional] Uncomment this line to install global node packages.
# RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g <your-package-here>" 2>&1
