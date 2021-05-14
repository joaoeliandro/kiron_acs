defmodule KironAcs.Repo do
  use Ecto.Repo,
    otp_app: :kiron_acs,
    adapter: Ecto.Adapters.Postgres
end
