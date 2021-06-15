# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :kiron_acs,
  ecto_repos: [KironAcs.Repo]

config :kiron_acs, KironAcs.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# TODO
# MUDAR O SECRET PARA UMA ENV
config :kiron_acs, KironAcsWeb.Auth.Guardian,
  issuer: "kiron_acs",
  secret_key: "3oKUNIjehZKtrEWFAtLXL/4BfEfHNZw1RflRFJT1n1z7/ecTzu7Fl+Yt1Q0Vf+HE"

config :kiron_acs, KironAcsWeb.Auth.Pipeline,
  module: KironAcsWeb.Auth.Guardian,
  error_handler: KironAcsWeb.Auth.ErrorHandler

# Configures the endpoint
config :kiron_acs, KironAcsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HhKCqkbGyO5vKZBqX1E2hAy4EgpAWDKY3M/N1Hd7bIQEhRxwTuL8hsoHh+ErWUn6",
  render_errors: [view: KironAcsWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: KironAcs.PubSub,
  live_view: [signing_salt: "fF0d91gv"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
