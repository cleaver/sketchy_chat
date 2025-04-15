import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sketchy_chat, SketchyChatWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "gYGqVfS8vgolOL+r/n654GdYTc+ah1Nwxl54uwXWG/7zGfuYm56Nnbb87SnSAYip",
  server: false

# In test we don't send emails
config :sketchy_chat, SketchyChat.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true
