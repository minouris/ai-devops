FROM mcr.microsoft.com/devcontainers/base:ubuntu

RUN apt-get update && \
    apt-get install -y ca-certificates && \
    rm -rf /var/lib/apt/lists/*

ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
ENV NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt

RUN --mount=type=secret,id=zscaler_root_ca \
    sudo cp /run/secrets/zscaler_root_ca /usr/local/share/ca-certificates/zscaler_root_ca.crt

RUN update-ca-certificates

# Note: Azure DevOps CLI extension is installed via postCreateCommand in devcontainer.json
# This ensures AZURE_CLI_DISABLE_CONNECTION_VERIFICATION is available during installation
