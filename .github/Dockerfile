FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y \
    git

COPY target/release/simeis-server ./
CMD ["./simeis-server"]