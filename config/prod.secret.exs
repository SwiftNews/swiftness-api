use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :swift_news, SwiftNewsWeb.Endpoint,
  secret_key_base: "SonYP66F6J7CvDGaQoa6X0NtBOcenkR1maP00PXMuDBtxzwg0i6Ry1Gw8SxNY5b0"

# Configure your database
config :swift_news, SwiftNews.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "swift_news_prod",
  pool_size: 15
