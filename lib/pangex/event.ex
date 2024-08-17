defmodule Pangex.Event do
  defstruct [:started_at, finished_at: nil, data: []]

  def name(event) do
    Calendar.strftime(event.started_at, "%Y%m%d%H%M%S")
  end

  def new do
    struct(__MODULE__, %{started_at: DateTime.utc_now()})
  end

  def new(data: data) do
    new() |> push_data(data)
  end

  def push_data(event, data) do
    %{event | data: [data | event.data], finished_at: DateTime.utc_now()}
  end
end
