# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :tutorial_app,
  ecto_repos: [TutorialApp.Repo]

# Configures the endpoint
config :tutorial_app, TutorialAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "V8ounq98Z3fqQPolaqpix2Xwafjk11oatU+E4+b8UMRBDbGwjnV1kteccw+BQyRs",
  render_errors: [view: TutorialAppWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TutorialApp.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
