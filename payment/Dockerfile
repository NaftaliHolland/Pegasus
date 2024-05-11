FROM elixir:1.14-alpine

# specify the dir

WORKDIR /payments

# this will include the hex package manager
RUN mix local.hex --force && mix local.rebar --force

RUN apk add --no-cache git



COPY mix.exs mix.lock ./
# install dependecies
RUN HEX_HTTP_CONCURRENCY=1 HEX_HTTP_TIMEOUT=1200 mix deps.get --only "dev"

# COMPILE
COPY config config/

RUN mix deps.compile

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
