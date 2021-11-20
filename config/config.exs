# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

# Configures the endpoint
config :ex_change, ExChangeWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: ExChangeWeb.ErrorView, accepts: ~w(html json), layout: false]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ex_change, :conversion_api,
  url: System.get_env("CURRENCY_CONVERTER_URL"),
  api_key: System.get_env("CURRENCY_CONVERTER_API_KEY")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
