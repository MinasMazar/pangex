defmodule PangexTest do
  use ExUnit.Case
  doctest Pangex

  test "Pangex can listen to a device" do
    pid = GenServer.whereis(Pangex)

    send(pid, {:event, 'this is a stream of data'})

    assert length(Pangex.events()) > 0
  end
end
