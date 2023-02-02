FROM docker.io/library/rust:1.67.0 as builder

ARG VERSION=0.8.1

WORKDIR /

RUN git clone --depth 1 --branch "${VERSION}" https://github.com/scsibug/nostr-rs-relay.git

WORKDIR /nostr-rs-relay

RUN cargo install cargo-auditable && \
	cargo new --bin nostr-rs-relay && \
	cargo auditable build --release --locked

FROM docker.io/library/debian:bullseye-slim

RUN apt-get update \
    && apt-get install -y ca-certificates tzdata sqlite3 libc6 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --from=builder /nostr-rs-relay/target/release/nostr-rs-relay /app/nostr-rs-relay

ENV RUST_LOG=info,nostr_rs_relay=info

ENTRYPOINT ["/app/nostr-rs-relay"]