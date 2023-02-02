# Nostr RS Relay

## Build
```bash
git clone https://github.com/getumbrel/docker-nostr-rs-relay.git
cd docker-nostr-rs-relay
docker build \
  --no-cache \
  --pull \
  -t getumbrel/nostr-rs-relay:latest .
```

## Run
```
docker run -d \
  -p 8080:8080 \
  --restart unless-stopped \
  getumbrel/nostr-rs-relay:latest
```