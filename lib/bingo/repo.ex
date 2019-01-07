defmodule Bingo.Repo do
  use Ecto.Repo,
    otp_app: :bingo,
    adapter: Ecto.Adapters.Postgres
end
