FROM ghcr.io/gleam-lang/gleam:v1.9.1-erlang-alpine AS builder

# Replace with official docker image once released https://github.com/go-task/task/pull/1875
# Remove git once https://github.com/MystPi/conversation/issues/4 is merged
RUN apk add go-task git

WORKDIR /build
COPY . .

RUN go-task build_prod

FROM erlang:alpine
LABEL org.opencontainers.image.source=https://github.com/MoeDevelops/website

WORKDIR /app
COPY --from=builder /build/server/build/erlang-shipment .

ENTRYPOINT [ "./entrypoint.sh", "run" ]
