# Replace with official docker image once released https://github.com/go-task/task/pull/1875
FROM alpine:latest AS installer

RUN apk add go-task git musl-dev

FROM ghcr.io/gleam-lang/gleam:v1.9.1-erlang-alpine AS builder

WORKDIR /build
COPY --from=installer /usr/bin/go-task /usr/bin/task
COPY . .

RUN task build_prod

FROM erlang:alpine
LABEL org.opencontainers.image.source=https://github.com/MoeDevelops/website

WORKDIR /app
COPY --from=builder /build/server/build/erlang-shipment .

ENTRYPOINT [ "./entrypoint.sh", "run" ]
