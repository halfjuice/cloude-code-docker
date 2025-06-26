# Use Ubuntu as base image
FROM ubuntu:22.04

# Update system and install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    build-essential \
    ca-certificates \
    gnupg \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js (required for Claude Code)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

ENV HOME=/root
ENV PATH="/root/.local/bin:${PATH}"

# Install Claude Code for the claude user
RUN npm install -g @anthropic-ai/claude-code --prefix=/root/.local

# Accept API key as build argument and set as env var
ARG ANTHROPIC_API_KEY
ENV ANTHROPIC_API_KEY=${ANTHROPIC_API_KEY}

# Create configuration directory and set API key if provided
RUN if [ -n "$ANTHROPIC_API_KEY" ]; then \
        mkdir -p /root/.config/claude-code && \
        echo "{\"apiKey\": \"$ANTHROPIC_API_KEY\"}" > /root/.config/claude-code/config.json && \
        chown -R claude:claude /root/.config; \
    fi

CMD ["claude"]