defmodule Pangex.DB do
  alias Pangex.Event
  require Logger

  def save_event(event) do
    event
    |> event_pathname()
    |> Path.expand(base_dir())
    |> write_file(to_markdown(event))
  end

  defp write_file(pathname, content) do
    Logger.info("Saving event at #{pathname}")
    File.write(pathname, content)
  end

  defp event_pathname(event) do
    with name <- Event.name(event) do
      name <> ".md"
    end
  end

  defp base_dir do
    Application.get_env(:pangex, :base_dir) || "~"
  end

  defp to_markdown(event) do
    """
    # Event <%= @datetime %>

    <%= for entry <- @event.data do %>
    - <%= inspect entry %>
    <% end %>
    """
    |> EEx.eval_string(assigns: [event: event, datetime: human_datetime(event.started_at)])
  end

  defp human_datetime(datetime) do
    Calendar.strftime(datetime, "%d %b %Y, %H:%M:%S")
  end
end
