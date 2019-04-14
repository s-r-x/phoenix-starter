FROM elixir:latest
RUN set -xe && \
  apt-get update -y && \
  apt install -y inotify-tools && \
  NODE_VER="10.15.3" && \
  NODE_URL="https://nodejs.org/dist/v10.15.3/node-v${NODE_VER}-linux-x64.tar.xz" && \
  mix local.hex --force && \
  mix archive.install hex phx_new 1.4.3 --force && \
  mix local.rebar --force && \
  curl -fSL -o node.tar.xz $NODE_URL && \
  tar -xf node.tar.xz --strip-components=1 -C /usr/local && \
  rm node.tar.xz
WORKDIR /app
CMD ["sh", "-c", "mix deps.get && npm --prefix assets/ install && mix phx.server"]
