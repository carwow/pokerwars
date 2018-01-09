defmodule Pokerwars.PayingBlindsTest do
  use ExUnit.Case, async: true
  import Pokerwars.TestHelpers
  alias Pokerwars.{Game}

  test "Players pay blinds" do
    players = [%{david() | stack: 100}, %{jade() | stack: 100}]
    game = %{ Game.create | players: players, status: :ready_to_start }

    {:ok, game} = Game.apply_action(game, {:start_game})

    stacks = Enum.map(game.players, &(&1.stack))
    assert stacks == [90, 80]
  end

  test "First player after big bling bets" do
    players = [
      %{david() | stack: 90},
      %{jade() | stack: 80},
      %{ken() | stack: 100},
    ]
    game = %{ Game.create | players: players, status: :pre_flop }

    {:ok, game} = Game.apply_action(game, {:bet, 'Ken'})

    stacks = Enum.map(game.players, &(&1.stack))
    assert stacks == [90, 80, 80]
  end

  test "Someone else not allowed to bet bets" do
    players = [
      %{david() | stack: 100},
      %{jade() | stack: 100},
      %{ken() | stack: 100},
    ]
    game = %{ Game.create | players: players, status: :pre_flop }

    {:error, :not_your_turn} = Game.apply_action(game, {:bet, 'David'})

    stacks = Enum.map(game.players, &(&1.stack))
    assert stacks == [90, 80, 100]
  end
end
