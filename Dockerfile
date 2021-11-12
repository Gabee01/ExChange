# https://hub.docker.com/_/elixir/
FROM elixir:1.12.3-alpine

# init
RUN apk update && \
    apk add ca-certificates && update-ca-certificates && \
    apk add git bash openssl curl alpine-sdk coreutils && \
    mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install hex phx_new --force

COPY . /opt
ENV MIX_ENV=dev PORT=4000

WORKDIR /opt
EXPOSE 4000
CMD ["sh", "-c", "mix phx.server"]
