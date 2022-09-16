defmodule Pangex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Pangex.Worker.start_link(arg)
      Pangex,
      device()
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pangex.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp device do
    with {:ok, device} <- Application.fetch_env(:pangex, :device), do: device
  end
end
