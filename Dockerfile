FROM debian:stable-slim as builder
WORKDIR /vlmcsd
# hadolint ignore=DL3008
RUN apt-get update && \
    apt-get install -y git make build-essential ca-certificates --no-install-recommends && \
    git clone --branch master --single-branch https://github.com/Wind4/vlmcsd.git /vlmcsd && \
    make

FROM debian:stable-slim
COPY --from=builder /vlmcsd/bin/vlmcsd /usr/bin/vlmcsd
EXPOSE 1688/tcp
CMD [ "/usr/bin/vlmcsd", "-D", "-d" ]
