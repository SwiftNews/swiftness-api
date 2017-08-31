# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :swift_news,
  ecto_repos: [SwiftNews.Repo]

# Configures the endpoint
config :swift_news, SwiftNewsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QODxSUucFEJM1XYHdCXSH/3h0DQiOWqE0tvA2UotxL7hJ/K+ifGyF2Az0r38zzv8",
  render_errors: [view: SwiftNewsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SwiftNews.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
