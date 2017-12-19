defmodule Pokerwars.GameTest do
  use ExUnit.Case, async: true
  import Pokerwars.TestHelpers
  alias Pokerwars.{Player,Game, Deck}

  test "A game is waiting for players after being created" do
    {:ok, game} = Game.create

    assert game.status == :waiting_for_players
  end

  test "A game is waiting for players after only 1 player joins" do
    {:ok, game} = Game.create
    david = Player.create("David")

    {:ok, game} = Game.apply_action(game, {:join, david})

    assert game.status == :waiting_for_players
    assert game.players == [david]
  end

  test "A game is ready to start after the second player joins" do
    {:ok, game} = Game.create

    david = Player.create("David")
    {:ok, game} = Game.apply_action(game, {:join, david})

    jade = Player.create("David")
    {:ok, game} = Game.apply_action(game, {:join, jade})

    assert game.status == :ready_to_start
    assert game.players == [david, jade]
  end

  test "A game can starts after the second player joins" do
    {:ok, game} = Game.create

    david = Player.create("David")
    {:ok, game} = Game.apply_action(game, {:join, david})

    jade = Player.create("Jade")
    {:ok, game} = Game.apply_action(game, {:join, jade})

    {:ok, game} = Game.apply_action(game, {:start_game})


    assert game.status == :pre_flop
    assert Enum.map(game.players, &(&1.name)) == ["David", "Jade"]
  end

  test "Cards are dealt to all the player when the game starts" do
    deck = Deck.from_cards(parse_cards("Ah 10d Js 10h"))

    {:ok, game} = Game.create(deck)

    david = Player.create("David")
    {:ok, game} = Game.apply_action(game, {:join, david})

    jade = Player.create("Jade")
    {:ok, game} = Game.apply_action(game, {:join, jade})

    {:ok, game} = Game.apply_action(game, {:start_game})

    hands = Enum.map(game.players, &(&1.hand))

    assert hands == [parse_cards("Ah Js"), parse_cards("10d 10h")]
  end

  test "The game cannot start with no players" do
    {:ok, game} = Game.create
    {status, game} = Game.apply_action(game, {:start_game})

    assert status == :invalid_action
    assert game.status == :waiting_for_players
  end
end
