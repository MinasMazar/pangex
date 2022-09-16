defmodule Pangex do
  @moduledoc """
  Documentation for `Pangex`.
  """
  use GenServer

  @initial_state %{
    events: []
  }
  def start_link(_) do
    GenServer.start_link(__MODULE__, @initial_state, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_info({:event, event}, state) do
    IO.inspect(event)
    {:noreply, state}
  end
end
