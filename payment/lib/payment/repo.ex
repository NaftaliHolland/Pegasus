defmodule Payment.Repo do
  use Ecto.Repo,
    otp_app: :payment,
    adapter: Ecto.Adapters.Postgres
end
