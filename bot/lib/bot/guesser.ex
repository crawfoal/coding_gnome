defmodule Bot.Guesser do
  def generate() do
    Enum.take_random(?a..?z, 1)
    |> to_string()
  end
end

