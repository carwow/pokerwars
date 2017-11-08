defmodule Pokerwars.Game do
  alias Pokerwars.Player
  alias Pokerwars.Deck

  defstruct [:players, :deck, :table]

  def start_game(player) do
    players = Enum.map(1..player, fn(_) -> Player.create end)
    deck = Deck.shuffle
    %__MODULE__{players: players, deck: deck, table: []}
  end

  def first_round(%__MODULE__{players: players, deck: deck}) do
    {players, deck} = deal_cards_to_players(players, deck)
    %__MODULE__{players: players, deck: deck}
  end

  def deal_cards_to_players(players, deck) do
    [first_player, second_player] = players
    {first_player, deck} = deal_card(first_player, deck)
    {second_player, deck} = deal_card(second_player, deck)
    {first_player, deck} = deal_card(first_player, deck)
    {second_player, deck} = deal_card(second_player, deck)

    {[first_player, second_player], deck}
  end

  def deal_card(player, deck) do
    {card, deck} = Deck.draw(deck)
    player = Player.receive_card(player, card)
    {player, deck}
  end
end
