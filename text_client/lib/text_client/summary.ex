defmodule TextClient.Summary do
  def display(game = %{tally: tally}) do
    IO.puts([
      "\n",
      "Word so far: #{Enum.join(tally.letters, " ")}\n",
      "Letters guessed: #{Enum.join(tally.guessed, ", ")}\n",
      "Guesses left: #{tally.turns_left}\n"
    ])
    game
  end
end

