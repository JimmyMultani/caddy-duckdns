# Stock Caddy rebuilt with the DuckDNS DNS provider plugin, since Caddy's DNS
# providers are compiled in rather than loaded at runtime.
FROM caddy:2-builder AS builder
RUN xcaddy build --with github.com/caddy-dns/duckdns

FROM caddy:2
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
