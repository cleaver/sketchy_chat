defmodule SketchyChat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SketchyChatWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:sketchy_chat, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: SketchyChat.PubSub},
      {Registry, keys: :unique, name: SketchyChat.Chat.Registry},
      # Start a worker by calling: SketchyChat.Worker.start_link(arg)
      # {SketchyChat.Worker, arg},
      # Start to serve requests, typically the last entry
      SketchyChatWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SketchyChat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SketchyChatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
