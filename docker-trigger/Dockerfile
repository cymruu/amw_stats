FROM alpine:3.10

RUN apk add --update docker-cli

WORKDIR /workspace

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
