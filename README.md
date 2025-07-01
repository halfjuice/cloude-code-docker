# Claude Code Docker

A minimal Docker image for running Claude Code - Anthropic's agentic command line tool. Lightweight and fast (< 200MB).

- Docker: https://hub.docker.com/r/halfjuice/claude-code
- Github: https://github.com/halfjuice/claude-code-docker

## Usage

```bash
docker run -it \
  -e ANTHROPIC_API_KEY="your-api-key" \
  halfjuice/claude-code:latest
```

### With Project Directory
```bash
docker run -it \
  -e ANTHROPIC_API_KEY="your-api-key" \
  -v $(pwd):/home/claude-user/workspace \
  halfjuice/claude-code:latest
```

## Notes

- Claude Code is in research preview - check [Anthropic's documentation](https://docs.anthropic.com) for updates
- Add additional tools as needed by extending the Dockerfile
- For production use, consider adding specific language runtimes and development tools
