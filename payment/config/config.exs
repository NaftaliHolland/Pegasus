# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config


maybe_ipv6 = if System.get_env("ECTO_IPV6"), do: [:inet6], else: []

database_url =
    System.get_env("HOSTNAME")

database_ca_cert_filepath = System.get_env("DATABASE_CA_CERT_FILEPATH") || "/etc/ssl/certs/ca-certificates.crt"

config :payment, Payment.Repo,
  username: "MosesMuiru",
  database: System.get_env("DATABASE_NAME"),
  hostname: System.get_env("HOSTNAME"),
  password: System.get_env("PASSWORD"),
  ssl: true,
  ssl_opts: [
    server_name_indication: to_charlist(database_url),
    verify: :verify_none
  ]


config :payment,
  ecto_repos: [Payment.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :payment, PaymentWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: PaymentWeb.ErrorHTML, json: PaymentWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Payment.PubSub,
  live_view: [signing_salt: "YQUIBEHQ"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :payment, Payment.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  payment: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.0",
  payment: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
