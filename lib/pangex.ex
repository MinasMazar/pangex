defmodule Pangex do
  @moduledoc """
  Documentation for `Pangex`.
  """
  require Logger
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
    Logger.debug("Received event of size #{length event}B")
    {:noreply, %{state | events: [event | state.events]}}
  end
end
