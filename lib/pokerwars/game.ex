defmodule Pokerwars.Game do
  alias Pokerwars.{Deck, Player}

  defstruct players: [], status: :waiting_for_players, current_deck: nil, original_deck: nil

  @max_players 2

  def create(deck \\ Deck.in_order) do
    {
      :ok,
      %__MODULE__{ original_deck: deck }
    }
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
    {:ok, %{deal_hands(game) | status: :started}}
  end

  defp deal_hands(game) do
    game
    |> clear_table
    |> deal_cards_to_each_player
    |> deal_cards_to_each_player
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

  defp deal_cards_from_deck(deck, [] = rest) do
    {deck, []}
  end

  defp deal_cards_from_deck(deck, [player | rest]) do
    {deck_after_deal, updated_player} = deal_card_to_player(deck, player)
    {final_deck, players} = deal_cards_from_deck(deck_after_deal, rest)

    {final_deck, [updated_player | players]}
  end
end
