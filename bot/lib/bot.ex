defmodule Bot do
  alias Bot.{Mover, Summary}

  def play do
    Hangman.new_game()
    |> Mover.move_until_game_ends()
    |> Summary.display()
  end
end
