# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :my_horse_stable,
  ecto_repos: [MyHorseStable.Repo]

# Configures the endpoint
config :my_horse_stable, MyHorseStable.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pI6YjUaFRAEG8iRNzpfVeSU+pFr7xtcYDDlMl6bAWsIuuSTHlg6g2IlmLw84CadU",
  render_errors: [view: MyHorseStable.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MyHorseStable.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
