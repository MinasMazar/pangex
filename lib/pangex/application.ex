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
      device_spec()
    ] |> Enum.filter(& &1)

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pangex.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp device_spec do
    with cmd <- start_device_cmd(), do: cmd && {Pangex.Device, %{start_device_cmd: cmd}}
  end

  defp start_device_cmd do
    Application.get_env(:pangex, :start_device_cmd)
  end
end
