defmodule Hangman.Game do

  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
    used: MapSet.new()
  )

  def new_game() do
    new_game(Dictionary.random_word())
  end

  def new_game(word) do
    %Hangman.Game{
      letters: word |> String.codepoints()
    }
  end

  def make_move(game = %{game_state: state}, _guess)
  when state in [:won, :lost], do: game
  def make_move(game, <<cp::utf8>> = guess) when cp not in ?a..?z do
    reject_move(game, guess)
  end
  def make_move(game, guess) do
    accept_move(game, guess, MapSet.member?(game.used, guess))
  end

  def tally(game) do
    %{
      game_state: game.game_state,
      turns_left: game.turns_left,
      letters: game.letters |> reveal_guessed(game.used),
      guessed: game.used
    }
  end

  #####################
  # Private Functions #
  #####################

  defp accept_move(game, _guess, _already_guessed = true) do
    %{ game | game_state: :already_used }
  end
  defp accept_move(game, guess, _already_guessed) do
    %{ game | used: MapSet.put(game.used, guess) }
    |> score_guess(Enum.member?(game.letters, guess))
  end

  defp reject_move(game, _guess) do
    %{ game | game_state: :invalid_guess }
  end

  defp score_guess(game, _good_guess = true) do
    new_state = MapSet.new(game.letters)
    |> MapSet.subset?(game.used)
    |> maybe_won()

    %{ game | game_state: new_state }
  end
  defp score_guess(game = %{ turns_left: 1 }, _not_good_guess) do
    %{ game | game_state: :lost }
  end
  defp score_guess(game = %{ turns_left: turns_left }, _not_good_guess) do
    %{ game | game_state: :bad_guess, turns_left: turns_left - 1 }
  end

  defp reveal_guessed(letters, used) do
    letters |> Enum.map(&reveal_letter(&1, MapSet.member?(used, &1)))
  end

  defp reveal_letter(letter, _in_word = true), do: letter
  defp reveal_letter(_letter, _not_in_word), do: "_"

  defp maybe_won(true), do: :won
  defp maybe_won(_), do: :good_guess
end

