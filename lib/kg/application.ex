defmodule Kg.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Kg.Repo,
      # Start the Telemetry supervisor
      KgWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Kg.PubSub},
      # Start the Endpoint (http/https)
      KgWeb.Endpoint
      # Start a worker by calling: Kg.Worker.start_link(arg)
      # {Kg.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Kg.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    KgWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
