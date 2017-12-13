defmodule Pokerwars.Player do
  defstruct name: '', hand: []
  alias Pokerwars.Player

  def create(name) do
    %Player{name: name}
  end

  def clear_hand(%Player{} = player) do
    %{player | hand: []}
  end

  def add_card_to_hand(%Player{hand: hand} = player, card) do
    %{player | hand: hand ++ [card]}
  end
end
