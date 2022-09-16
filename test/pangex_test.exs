defmodule PangexTest do
  use ExUnit.Case
  doctest Pangex

  test "Pangex can listen to a device" do
    event = %{}
    send(Pangex.StubbedDevice, :call)

    assert_receive {:event, event}
  end
end
