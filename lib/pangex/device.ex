defmodule Pangex.Device do
  alias Porcelain.Process
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(state) do
    proc = %Process{pid: pid} = Porcelain.spawn_shell("cat #{state.path}",
      out: {:send, self()}
    )
    {:ok, Map.put(state, :proc, proc)}
  end

  def handle_info({_pid, :result, result}, state) do
    IO.inspect(result)
    {:noreply, state}
  end

  def handle_info({_pid, :data, :out, data}, state) do
    IO.inspect(data)
    {:noreply, state}
  end

  def build_event(event, context: _state) do
    with event <- Map.put(event, :type, :nop) do
      event
    end
  end
end
