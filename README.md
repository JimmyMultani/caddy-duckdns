# caddy-duckdns

[Caddy](https://caddyserver.com) with the [`caddy-dns/duckdns`](https://github.com/caddy-dns/duckdns) plugin built in, so it can get Let's Encrypt certificates (including wildcards) for DuckDNS domains via the DNS-01 challenge — no port 80 needed.

```
ghcr.io/jimmymultani/caddy-duckdns:latest
```

Everything else is stock `caddy:2`: same paths (`/etc/caddy/Caddyfile`, `/data`, `/config`), same entrypoint.

## Usage

Pass your DuckDNS token (shown at the top of duckdns.org once logged in) as an environment variable, and reference it in your Caddyfile:

```caddyfile
*.example.duckdns.org {
	tls {
		dns duckdns {$DUCKDNS_TOKEN}
	}
	reverse_proxy 127.0.0.1:8080
}
```

```yaml
services:
  caddy:
    image: ghcr.io/jimmymultani/caddy-duckdns:latest
    environment:
      - DUCKDNS_TOKEN=${DUCKDNS_TOKEN}
    volumes:
      - ./Caddyfile:/etc/caddy/Caddyfile:ro
      - ./data:/data
```

See [JimmyMultani/nas-docker-configs](https://github.com/JimmyMultani/nas-docker-configs) (`configs/reverse-proxy.yaml`) for a real deployment.

## Images

Every push to `main` publishes `latest` and `sha-<commit>` for `linux/amd64` and `linux/arm64`. Caddy and the plugin aren't pinned yet, so `latest` is whatever was current at build time — see the open issues for versioning and scheduled rebuilds.
