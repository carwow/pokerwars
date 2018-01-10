defmodule Pokerwars.RunningASimpleGameTest do
  use ExUnit.Case, async: true
  import Pokerwars.TestHelpers

  alias Pokerwars.{Game, Player, Deck, Card}

  @player1 Player.create "Bill", 100
  @player2 Player.create "Ben", 100

  test "Running a simple game" do
    step "We create a game and it is waiting for players"
    game = Game.create
    assert game.status == :waiting_for_players

    step "The players join and the game is ready to start"
    game = with \
      {:ok, game} <- Game.apply_action(game, {:join, @player1}),
      {:ok, game} <- Game.apply_action(game, {:join, @player2}),
      do: game
    assert game.status == :ready_to_start

    step "The game is started"
    {:ok, game} = Game.apply_action(game, {:start_game})
    assert game.status == :pre_flop

    step "The players pay small and big blinds automatically"
    assert [90, 80] == Enum.map(game.players, &(&1.stack))

    step "Both players can see 2 cards"
    assert 2 == length(Enum.map(game.players, &(&1.hand)))

    step "Both players check"
    game = with \
      {:ok, game} <- Game.apply_action(game, {:check, @player1}),
      {:ok, game} <- Game.apply_action(game, {:check, @player2}),
      do: game
    assert game.status == :flop

    step "There are 3 cards on the table"
    assert length(game.hole_cards) == 3
  end
end
