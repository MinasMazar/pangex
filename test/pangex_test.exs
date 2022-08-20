defmodule PangexTest do
  use ExUnit.Case
  doctest Pangex

  test "greets the world" do
    assert Pangex.hello() == :world
  end
end
