defmodule KironAcsWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :kiron_acs

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
