defmodule Bot.Summary do
  def display(%Hangman.Game{} = game) do
    Hangman.tally(game)
    |> display()
  end
  def display(%{ game_state: state, letters: letters, guessed: guessed }) do
    IO.puts([
      "\n",
      "Word so far: #{Enum.join(letters, " ")}\n",
      "Letters guessed: #{Enum.join(guessed, ", ")}\n",
      state_display(state)
    ])
  end

  defp state_display(:won), do: "The bot won!\n"
  defp state_display(:lost), do: "The bot lost\n"
end
