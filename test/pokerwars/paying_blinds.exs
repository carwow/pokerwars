defmodule Pokerwars.PayingBlindsTest do
  use ExUnit.Case, async: true
  import Pokerwars.TestHelpers
  alias Pokerwars.{Player,Game, Deck}

  test "Players pay blinds" do
    {:ok, game} = Game.create

    david = Player.create("David", 100)
    {:ok, game} = Game.apply_action(game, {:join, david})

    jade = Player.create("Jade", 100)
    {:ok, game} = Game.apply_action(game, {:join, jade})

    {:ok, game} = Game.apply_action(game, {:start_game})

    stacks = Enum.map(game.players, &(&1.stack))

    assert stacks == [90, 80]
  end
end
