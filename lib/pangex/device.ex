defmodule Pangex.Device do
  require Logger
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(state) do
    Logger.debug("Starting device with command #{inspect state.start_device_cmd}")
    port = Port.open({:spawn, state.start_device_cmd}, [])
    monitor = Port.monitor(port)
    {:ok,
     state
     |> Map.put(:port, port)
     |> Map.put(:monitor, monitor)}
  end

  def handle_info({_port, {:data, data}}, state) do
    send(Pangex, {:event, data})
    {:noreply, state}
  end

  def handle_info({_port, :closed}, state) do
    IO.puts("PORT CLOSED")
    {:noreply, state}
  end

  def handle_info({:DOWN, _ref, :port, _obj, reason}, state) do
    IO.puts("Down due to #{inspect reason}")
    {:stop, {:shutdown, :normal}, state}
  end
end
