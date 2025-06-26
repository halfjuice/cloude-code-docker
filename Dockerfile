# Minimal Alpine Dockerfile for Claude Code
FROM alpine:3.19

# Install essential dependencies
RUN apk add --no-cache \
    curl \
    git \
    bash \
    nodejs \
    npm \
    build-base

# Create a non-root user
RUN adduser -D -s /bin/bash claude-user

# Switch to non-root user
USER claude-user
WORKDIR /home/claude-user

# Set up environment for Claude Code
ENV PATH="/home/claude-user/.local/bin:${PATH}"

# Entry point
CMD ["/bin/bash"]
