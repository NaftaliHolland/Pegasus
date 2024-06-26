import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :payment, Payment.Repo,
  username: "postgres",
  password: System.get_env("POSTGRES"),
  hostname: "localhost",
  database: "payment_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

config :tesla, adapter: Tesla.Mock

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :payment, PaymentWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "aZonNyCBXCivlB8OuzQt+VwWyrMG7r6tACAbxGvtr9Y+S/apiOsnwCL5I+9ZTqJc",
  server: false

# In test we don't send emails.
config :payment, Payment.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
