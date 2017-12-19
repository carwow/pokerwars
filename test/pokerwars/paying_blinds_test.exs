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
end
