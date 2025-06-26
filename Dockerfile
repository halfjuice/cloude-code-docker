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

# Create a non-root user for security
RUN useradd -m -s /bin/bash claude

# Create a working directory and set ownership
WORKDIR /workspace
RUN chown -R claude:claude /workspace

# Switch to non-root user
USER claude

# Set up environment
ENV HOME=/home/claude
ENV PATH="/home/claude/.cargo/bin:/home/claude/.local/bin:$PATH"

# Install Claude Code for the claude user
RUN npm install -g @anthropic-ai/claude-code --prefix=/home/claude/.local

# Create a directory for projects
RUN mkdir -p /home/claude/projects
WORKDIR /home/claude/projects

# Accept API key as build argument and set as env var
ARG ANTHROPIC_API_KEY
ENV ANTHROPIC_API_KEY=${ANTHROPIC_API_KEY}

# Create configuration directory and set API key if provided
RUN if [ -n "$ANTHROPIC_API_KEY" ]; then \
        mkdir -p /home/claude/.config/claude-code && \
        echo "{\"apiKey\": \"$ANTHROPIC_API_KEY\"}" > /home/claude/.config/claude-code/config.json && \
        chown -R claude:claude /home/claude/.config; \
    fi

CMD ["bash", "-c", "cd /home/claude/projects && exec bash"]