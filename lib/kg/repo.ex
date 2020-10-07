defmodule Kg.Repo do
  use Ecto.Repo,
    otp_app: :kg,
    adapter: Ecto.Adapters.Postgres
end
