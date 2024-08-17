defmodule Pangex do
  @moduledoc """
  Documentation for `Pangex`.
  """
  alias Pangex.{DB, Event}
  require Logger
  use GenServer

  @initial_state %{event: nil, event_threshold: 4}

  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_) do
    {:ok, @initial_state}
  end

  def state, do: :sys.get_state(__MODULE__)
  def events, do: Map.get(state(), :events)

  @impl true
  def handle_info({:event, data}, state = %{event: nil}) do
    Logger.debug("Starting recording event")
    {:noreply, schedule_stop_recording(%{state | event: Event.new(data: data)})}
  end

  def handle_info({:event, data}, state) do
    Logger.debug("Received event of size #{length data}B")
    {:noreply, %{state | event: Event.push_data(state.event, data)}}
  end

  def handle_info(:maybe_stop_recording, state) do
    seconds_till_last_event = Time.diff(Time.utc_now(), state.event.finished_at, :second)
    Logger.debug("Maybe stop? #{seconds_till_last_event} since last event")
    if seconds_till_last_event > state.event_threshold do
      {:noreply, stop_recording(state)}
    else
      {:noreply, schedule_stop_recording(state)}
    end
  end

  defp stop_recording(state) do
    Logger.debug("Stoppoing event recording")
    DB.save_event(state.event)
    %{state | event: nil}
  end

  defp schedule_stop_recording(state) do
    Process.send_after(self(), :maybe_stop_recording, 4_000)
    state
  end
end
