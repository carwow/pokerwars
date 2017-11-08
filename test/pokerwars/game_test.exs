defmodule Pokerwars.GameTest do
  use ExUnit.Case, async: true
  import Pokerwars.TestHelpers
  import Pokerwars.Game
  doctest Pokerwars.Game

  test 'In the first round both playes will have 2 cards each' do
    result = Pokerwars.Game.start_game(2) |> Pokerwars.Game.first_round

    [first_player, second_player] = result.players
    assert Enum.count(first_player.hand) == 2
    assert Enum.count(second_player.hand) == 2
  end
end
