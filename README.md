# container-health-logger (chl)

Debug util to log container health to stdout as JSON

example log message:
```json
{
  "timestamp": "2025-10-11T21:06:37.912244",
  "container": "quirky_lamarr",
  "health": "healthy"
}
```

timestamp is ISO8601 format

## docker compose
```yaml
services:
  chl:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: chl
    image: ghcr.io/hollanbm/container-health-logger:latest
    environment:
      - DOCKER_HOST=unix:///var/run/docker.sock
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
    restart: unless-stopped
```
