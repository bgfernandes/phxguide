defmodule Phxguide.Repo do
  use Ecto.Repo,
    otp_app: :phxguide,
    adapter: Ecto.Adapters.Postgres
end
