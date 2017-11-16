defmodule Pokerwars.Game do
  alias Pokerwars.{Deck}

  defstruct players: [], status: :waiting_for_players, current_deck: nil, original_deck: nil

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
    waiting_for_players(action, game)
  end

  defp phase(:ready_to_start, game, action) do
    ready_to_start(action, game)
  end

  defp waiting_for_players({:join, player}, game) do
    players = game.players ++ [player]
    enough_players = length(players) >= 2
    status = if enough_players, do: :ready_to_start, else: :waiting_for_players
    game = %{ game | players: players, status: status }
    {:ok, game}
  end
  defp waiting_for_players(_, game), do: {:invalid_action, game}

  defp ready_to_start({:start_game}, game) do
    game = deal_hands(game)

    game = %{game | status: :started}

    {:ok, game}
  end

  defp deal_hands(game) do
    game
    |> clear_table
    |> deal_two_cards_to_each_player
  end

  defp clear_table(game) do
    players = Enum.map(game.players, fn player -> put_in(player.hand, []) end)
    %{game | current_deck: game.original_deck, players: players}
  end

  defp deal_two_cards_to_each_player(game) do
    players = game.players
    deck = game.current_deck

    deal_hand = fn (player, {deck, players}) ->
      {deck, player} = deal_card_to_player(deck, player)
      {deck, players ++ [player]}
    end

    {deck, players} = Enum.reduce(players, {deck, []}, deal_hand)
    {deck, players} = Enum.reduce(players, {deck, []}, deal_hand)

    %{game | players: players, current_deck: deck}
  end

  defp deal_card_to_player(deck, player) do
    {card, deck} = Deck.deal(deck)
    hand = player.hand ++ [card]
    player = %{ player | hand: hand }
    {deck, player}
  end
end
