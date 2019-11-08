defmodule TextClient.Player do

  alias TextClient.State

  # won, lost, good guess, bad guess, already used, initializing
  def play(%State{tally: %{ game_state: :won }}) do
    exit_with_message("You WON!")
  end
  def play(%State{tally: %{ game_state: :lost }}) do
    exit_with_message("Sorry, you lost")
  end
  def play(%State{tally: %{ game_state: :good_guess }} = state) do
    continue_with_message(state, "Good guess!")
  end
  def play(%State{tally: %{ game_state: :bad_guess }} = state) do
    continue_with_message(state, "Sorry, that isn't in the word")
  end
  def play(%State{tally: %{ game_state: :already_used }} = state) do
    continue_with_message(state, "You've already used that letter")
  end
  def play(game) do
    continue(game)
  end

  defp continue_with_message(game, msg) do
    IO.puts(msg)
    continue(game)
  end

  defp continue(game) do
    game
    |> display()
    |> prompt()
    |> make_move()
    |> play()
  end

  defp display(game) do
    game
  end

  defp prompt(game) do
    game
  end

  defp make_move(game) do
    game
  end

  defp exit_with_message(msg) do
    IO.puts(msg)
    exit(:normal)
  end
end

