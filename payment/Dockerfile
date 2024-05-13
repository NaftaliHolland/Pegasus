FROM elixir:1.14

# specify the dir

WORKDIR /payments

# this will include the hex package manager
RUN mix local.hex --force && mix local.rebar --force

RUN apk add --no-cache git

# update -> alpine
# postgresql-client -> we need to wait for the database to come online
# inotify-tools -> reload when our code changes.
RUN apt-get update && apt-get install -y postgresql-client && apt-get install -y inotify-tools


COPY mix.exs mix.lock ./
# install dependecies
RUN HEX_HTTP_CONCURRENCY=1 HEX_HTTP_TIMEOUT=1200 mix deps.get --only "dev"

RUN mix deps.compile

# COMPILE
COPY config config/


COPY lib lib

COPY priv priv

COPY assets assets

# compile assets
# RUN mix assets.deploy

# compile the release
#RUN mix compile


RUN mix release



EXPOSE 4000

CMD ["mix", "phx.server"]
