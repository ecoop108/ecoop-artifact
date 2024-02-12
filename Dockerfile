# Base image with vscode frontend for web browser
FROM linuxserver/code-server:4.21.0

# Clone repository with compiler
RUN git clone https://github.com/ecoop108/vpy

# Copy examples to default workspace
RUN mv ./vpy/examples /config/workspace

# Copy run configuration file to workspace
RUN mkdir /config/workspace/.vscode
COPY launch.json /config/workspace/.vscode/launch.json

# Fix permissions
RUN chown abc:abc -R /config/workspace

# Install python and pip
RUN apt update
RUN apt install -y python3.11 python3.11-dev python3-pip

# Install vpy compiler to python PATH
RUN python3.11 -m pip install ./vpy

# Clone repository with vscode extension
RUN git clone https://github.com/ecoop108/vpy-vscode-ext

# Download and install (latest) nodejs 
RUN curl -fsSL https://deb.nodesource.com/setup_21.x | bash - && apt install -y nodejs

# Install dependencies to build vscode extension 
RUN --mount=type=cache,target=/root/.cache \
    npm install -g @vscode/vsce @types/vscode @types/watch typescript

# Build extension 
WORKDIR /vpy-vscode-ext
RUN npm install
RUN vsce package

# Install extension in vscode
RUN /app/code-server/bin/code-server --extensions-dir /config/extensions --install-extension ./vpy-0.0.1.vsix

# Install f5-anything extension to provide runtime integration
RUN /app/code-server/bin/code-server --extensions-dir /config/extensions --install-extension ms-python.python
