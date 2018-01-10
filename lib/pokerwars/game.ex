defmodule Pokerwars.Game do
  alias Pokerwars.{Deck, Player}

  @small_blind 10
  @big_blind @small_blind * 2
  @max_players 2

  defstruct players: [], status: :waiting_for_players, current_deck: nil, original_deck: nil, \
    hole_cards: [], current_player: 0

  def create(deck \\ Deck.in_order) do
    %__MODULE__{ original_deck: deck }
  end

  def apply_action(game, action) do
    phase(game.status, game, action)
  end

  defp phase(:waiting_for_players, game, action) do
    with {:ok, game} <- waiting_for_players(action, game),
         {:ok, game} <- next_status(game)
    do
      {:ok, game}
    else
      err -> err
    end
  end
  defp phase(:ready_to_start, game, action) do
    ready_to_start(action, game)
  end
  defp phase(:pre_flop, game, action) do
    if(game.current_player == length(game.players)) do
      new_game = %{ game | status: :pre_flop, current_player: game.current_player + 1 }
    else
      flop = Enum.take(game.current_deck.cards, 3)
      new_cards = Enum.slice(game.current_deck.cards, 3, 52)

      new_game = %{ game | status: :flop, hole_cards: flop, \
        current_deck: %Deck{game.current_deck | cards: new_cards } }
    end

    {:ok, new_game}
  end
  defp phase(:flop, game, action) do
    {:ok, game}
  end

  defp next_status(%__MODULE__{status: :waiting_for_players, players: players} = game)
  when length(players) == @max_players do
    {:ok, %{game | status: :ready_to_start}}
  end
  defp next_status(game), do: {:ok, game}

  defp waiting_for_players({:join, player}, %{players: players} = game)
  when length(players) < @max_players do
    {:ok, %{game | players: game.players ++ [player]}}
  end
  defp waiting_for_players(_, game), do: {:invalid_action, game}

  defp ready_to_start({:start_game}, game) do
    game = deal_hands(game)

    game = %{game | status: :pre_flop}

    game = take_blinds(game)
    {:ok, game}
  end

  defp ready_to_start({:join, player}, game) do
    waiting_for_players({:join, player}, game)
    {:ok, game}
  end

  defp deal_hands(game) do
    game
    |> clear_table
    |> deal_cards_to_each_player
    |> deal_cards_to_each_player
  end

  defp take_blinds(game) do
    players = game.players

    [ first_player, second_player | other_players ] = players

    first_player = %{first_player | stack: first_player.stack - @small_blind}
    second_player = %{second_player | stack: second_player.stack - @big_blind}

    new_players = [first_player, second_player | other_players]

    %{game | players: new_players}
  end

  defp clear_table(game) do
    players = Enum.map(game.players, &Player.clear_hand/1)
    %{game | current_deck: game.original_deck, players: players}
  end

  defp deal_cards_to_each_player(%{players: players, current_deck: deck} = game) do
    {new_deck, new_players} = deal_cards_from_deck(deck, players)

    %{game | players: new_players, current_deck: new_deck}
  end

  defp deal_card_to_player(deck, player) do
    {card, deck} = Deck.deal(deck)
    player = Player.add_card_to_hand(player, card)
    {deck, player}
  end

  defp deal_cards_from_deck(deck, []) do
    {deck, []}
  end

  defp deal_cards_from_deck(deck, [player | others]) do
    {deck_after_deal, updated_player} = deal_card_to_player(deck, player)
    {updated_deck, updated_others} = deal_cards_from_deck(deck_after_deal, others)

    {updated_deck, [updated_player | updated_others]}
  end
end

defimpl String.Chars, for: Pokerwars.Game do
  def to_string(game) do
    Enum.join [
      "%Pokerwars.Game{\n",
      "  status: #{game.status}\n",
      "  current_deck: (#{length(game.current_deck.cards)} cards)\n",
      "  players: (#{length(game.players)})\n",
      "}"
    ]
  end
end
