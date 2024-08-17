defmodule Pangex.StubDevice do
  @charset ~w[a b c d e f g h i l m n o p q r s t u w x y z 1 2 3 4 5 6 7 8 9 0]
  @data_size 10

  def run do
    data = @charset
    |> Enum.shuffle()
    |> Enum.take(@data_size)
    |> Enum.join()
    IO.puts(data)
    secs = Enum.random(2..5)
    Process.sleep(round(secs * 1000))
    run()
  end
end

Pangex.StubDevice.run()
