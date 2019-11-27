defmodule Bot.Mover do
  alias Bot.Guesser

  def move_until_game_ends(%Hangman.Game{} = game) do
    move_until_game_ends({game, Hangman.tally(game)})
  end
  def move_until_game_ends({%{ game_state: state }, game})
  when state in [:won, :lost], do: game
  def move_until_game_ends({game, _tally}) do
    Hangman.make_move(game, Guesser.generate())
    |> move_until_game_ends()
  end
end

