defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game/1 returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
  end

  test "letters are in a..z" do
    game = Game.new_game()

    assert game.letters |> Enum.all?(&( Regex.match?(~r([a-z]), &1) ))
  end

  test "state isn't changed for :won or :lost game" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert ^game = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not already used" do
    %{game_state: state} = Game.new_game() |> Game.make_move("x")
    assert state != :already_used
  end

  test "second occurrence of letter is not already used" do
    game = Game.new_game() |> Game.make_move("x")
    assert %{game_state: :already_used} = Game.make_move(game, "x")
  end

  test "a good guess is recognized" do
    game = Game.new_game("wibble") |> Game.make_move("w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a guessed word is a won game" do
    game = Game.new_game("wibble")
    game =
      ~w(w i b l)
      |> Enum.reduce(game, fn letter, game ->
        game = Game.make_move(game, letter)
        assert game.game_state == :good_guess
        game
      end)
      |> Game.make_move("e")
    assert game.game_state == :won
  end

  test "a bad guess is recognized" do
    game = Game.new_game("wibble") |> Game.make_move("x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "lost game is recognized" do
    game = Game.new_game("w")
    game =
      ~w(a b c d e f)
      |> Enum.reduce(game, fn letter, game ->
        game = Game.make_move(game, letter)
        assert game.game_state == :bad_guess
        game
      end)
      |> Game.make_move("g")
    assert game.game_state == :lost
  end
end

