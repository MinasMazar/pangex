defmodule Pangex.StubbedDevice do
  use GenServer

  import Pangex.Device, only: [build_event: 2]

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    timer = :timer.send_interval(2_000, :call)
    {:ok, %{timer: timer}}
  end

  def handle_info(:call, state) do
    send(Pangex, {:event, build_event(%{}, context: state)})
    {:noreply, state}
  end
end
